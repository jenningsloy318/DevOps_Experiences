
# Links
1. https://www.shapeblue.com/networking-kvm-for-cloudstack-2018-revisit-for-centos7-and-ubuntu-18-04/



# Scenario 1:  
Description:
  VM host is connected to a **router**(**`192.168.3.1`**) which connects internet directly. on VM host, we create a bridge **`br-k8s`** oupon the physical interface **`enp24s0`**, then assigned IP address **`192.168.3.10`** to bridge internal interface **`br-k8s`**;

  Now we want to add a vlan with tag **`100`** as interface **`vlan100`**, and configure static address **`192.168.100.1`** to **`vlan100`**, then we can create multiple VMs oupon **`vlan100`**, add openflow rule to make these VMs can access internet.


1. Create bridge 
```shell
# ovs-vsctl add-br br-k8s
```

2. add physical interface
```shell
# ovs-vsctl add-port br-k8s enp24s0
```

3. show ovs
```shell
# ovs-vsctl show 
6f640d61-54ac-4644-b6b8-3b27db02294b
    Bridge "br-k8s"
        Port "enp24s0"
            Interface "enp24s0"
        Port "br-k8s"
            Interface "br-k8s"
                type: internal
    ovs_version: "2.10.0"
```

3. create vlan100
```shell
# ovs-vsctl add-port br-k8s vlan100 -- set interface vlan100 type=internal --  set Port vlan100  tag=100
# ovs-vsctl show 
6f640d61-54ac-4644-b6b8-3b27db02294b
    Bridge "br-k8s"
        Port "enp24s0"
            Interface "enp24s0"
        Port "br-k8s"
            Interface "br-k8s"
                type: internal
        Port "vlan100"
            tag: 100
            Interface "vlan100"
                type: internal
    ovs_version: "2.10.0"
```

4. configure IP address for br-k8s
```shell
# cat /etc/sysconfig/network-scripts/ifcfg-enp24s0 
DEVICE=enp24s0
ONBOOT=yes
DEVICETYPE=ovs
TYPE=OVSPort
OVS_BRIDGE=br-k8s
BOOTPROTO=none
HOTPLUG=no

# cat /etc/sysconfig/network-scripts/ifcfg-br-k8s 
DEVICE=br-k8s
ONBOOT=yes 
DEVICETYPE=ovs
TYPE=OVSBridge
BOOTPROTO=static
IPADDR=192.168.3.10
NETMASK=255.255.255.0 
GATEWAY=192.168.3.1
DNS1=192.168.3.1
HOTPLUG=no
```

5. configure IP address for vlan100
```
ip link set vlan100 up
ip addr add 192.168.100.1/24 dev vlan100
```
6. create network with this vlan for kvm 
```shell
# cat ovs-vlan100-libvirtd.xml
<network>
  <name>ovs-vlan100</name>
  <forward mode='bridge'/>
  <bridge name='br-k8s'/>
  <virtualport type='openvswitch'/>
  <portgroup name='vlan100'>
    <vlan>
      <tag id='100'/>
    </vlan>
  </portgroup>
</network>
#  virsh net-define ovs-vlan100-libvirtd.xml
Network ovs-vlan100 defined from ovs-vlan100-libvirtd.xml
# virsh net-start ovs-vlan100
Network ovs-vlan100 started
# virsh net-autostart ovs-vlan100
Network ovs-vlan100 marked as autostarted
```
7. create VM to use this network, and assign the VM with IP 192.168.100.1
```shell
virt-install --name=ovs-vlantest  --disk path=/data/libvirt/vms/ovs-vlantest.qcow2,size=20,format=qcow2 --vcpus 2  --memory=4096 --os-type=linux --os-variant=ubuntu18.04 --network network=ovs-vlan100,portgroup=vlan100,mac=fe:54:00:1a:32:76  --graphics spice  --console pty,target_type=serial   --noautoconsole --import
```
when this VM is launched, new NIC **`vnet0`** is created in bridge **`br-k8s`**

``` 
# ip link 
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: enp24s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel master ovs-system state UP mode DEFAULT group default qlen 1000
    link/ether 00:d8:61:12:b7:c8 brd ff:ff:ff:ff:ff:ff
3: ovs-system: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether ba:09:b1:28:b2:42 brd ff:ff:ff:ff:ff:ff
4: br-k8s: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/ether 00:d8:61:12:b7:c8 brd ff:ff:ff:ff:ff:ff
5: vlan100: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/ether c2:6a:ce:9d:8a:14 brd ff:ff:ff:ff:ff:ff
10: vnet0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel master ovs-system state UNKNOWN mode DEFAULT group default qlen 1000
    link/ether fe:54:00:1a:32:76 brd ff:ff:ff:ff:ff:ff
# ovs-vsctl show 
6f640d61-54ac-4644-b6b8-3b27db02294b
    Bridge "br-k8s"
        Port "vnet0"
            tag: 100
            Interface "vnet0"
        Port "enp24s0"
            Interface "enp24s0"
        Port "br-k8s"
            Interface "br-k8s"
                type: internal
        Port "vlan100"
            tag: 100
            Interface "vlan100"
                type: internal
    ovs_version: "2.10.0"
```

8. ping test from the vm 
```shell
~$ ping 192.168.100.1
PING 192.168.100.1 (192.168.100.1) 56(84) bytes of data.
64 bytes from 192.168.100.1: icmp_seq=1 ttl=64 time=0.071 ms
^C
--- 192.168.100.1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.071/0.071/0.071/0.000 ms
~$ ping 192.168.3.1
PING 192.168.3.1 (192.168.3.1) 56(84) bytes of data.
^C
--- 192.168.3.1 ping statistics ---
3 packets transmitted, 0 received, 100% packet loss, time 2047ms
```
9. show openflow ports and default flows
```shell
# ovs-ofctl show br-k8s 
OFPT_FEATURES_REPLY (xid=0x2): dpid:000000d86112b7c8
n_tables:254, n_buffers:0
capabilities: FLOW_STATS TABLE_STATS PORT_STATS QUEUE_STATS ARP_MATCH_IP
actions: output enqueue set_vlan_vid set_vlan_pcp strip_vlan mod_dl_src mod_dl_dst mod_nw_src mod_nw_dst mod_nw_tos mod_tp_src mod_tp_dst
 2(enp24s0): addr:00:d8:61:12:b7:c8
     config:     0
     state:      0
     current:    100MB-FD AUTO_NEG
     advertised: 10MB-HD 10MB-FD 100MB-HD 100MB-FD 1GB-FD COPPER FIBER AUTO_NEG AUTO_PAUSE AUTO_PAUSE_ASYM
     supported:  10MB-HD 10MB-FD 100MB-HD 100MB-FD 1GB-FD COPPER FIBER AUTO_NEG AUTO_PAUSE AUTO_PAUSE_ASYM
     speed: 100 Mbps now, 1000 Mbps max
 3(vlan100): addr:c2:6a:ce:9d:8a:14
     config:     0
     state:      0
     speed: 0 Mbps now, 0 Mbps max
 LOCAL(br-k8s): addr:00:d8:61:12:b7:c8
     config:     0
     state:      0
     speed: 0 Mbps now, 0 Mbps max
OFPT_GET_CONFIG_REPLY (xid=0x4): frags=normal miss_send_len=0
# ovs-ofctl dump-flows br-k8s
 cookie=0x0, duration=41438.873s, table=0, n_packets=39062238, n_bytes=36282672244, priority=0 actions=NORMAL
```

10. add flows
```

```