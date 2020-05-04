1. config vlan and assign IP address
    ```
    [root@workstation libvirt]# ovs-vsctl add-port br0 vlan200 tag=200  -- set interface vlan200 type=internal 
    [root@workstation libvirt]# ovs-vsctl add-port br0 vlan100 tag=100 -- set interface vlan100 type=internal 
    [root@workstation libvirt]# ovs-vsctl show
    6f640d61-54ac-4644-b6b8-3b27db02294b
        Bridge br0
            Port vlan200
                tag: 200
                Interface vlan200
                    type: internal
            Port vlan100
                tag: 100
                Interface vlan100
                    type: internal
            Port br0-phy-port0
                Interface enp24s0
                    type: system
            Port br0
                Interface br0
                    type: internal
        ovs_version: "2.13.0"

    [root@workstation libvirt]# ip l set vlan100 up
    [root@workstation libvirt]# ip l set vlan200 up
    [root@workstation libvirt]# ip a add 192.168.100.1/24 dev vlan100
    [root@workstation libvirt]# ip a add 192.168.200.1/24 dev vlan200
    ```

2. define ovs net for libvirtd 
- net-ovs.xml
  ```xml 
  <network>
    <name>ovs</name>
    <forward mode='bridge'/>
    <bridge name='br0'/>
    <virtualport type='openvswitch'/>
    <portgroup name='vlan100'>
      <vlan>
        <tag id='100'/>
      </vlan>
    </portgroup>
    <portgroup name='vlan200'>
      <vlan>
        <tag id='200'/>
      </vlan>
    </portgroup>

  </network>
  ```
- define the network 
  ```
  [root@workstation libvirt]# virsh net-define net-ovs.xml 
  Network ovs defined from net-ovs.xml

  [root@workstation libvirt]# virsh net-start ovs
  Network ovs started

  [root@workstation libvirt]# virsh net-autostart ovs
  Network ovs marked as autostarted

  [root@workstation libvirt]# virsh net-list
  Name   State    Autostart   Persistent
  -----------------------------------------
  ovs    active   yes         yes
  ```

3. create VM
- vlan100
  ```sh
  # cat meta-data
  instance-id: centos7
  network-interfaces: |
    auto eth0
    iface eth0 inet static
    address 192.168.100.5
    netmask 255.255.255.0
    gateway 192.168.100.1
  hostname: vlan100.lmy.com
  # cat user-data 
  #cloud-config
  preserve_hostname: false
  hostname: vlan100.lmy.com
  ssh_pwauth: True
  manage_resolv_conf: true
  resolv_conf:
      nameservers: ['114.114.144.114', '8.8.8.8']
  users:
    - name: jenningsl
      groups: wheel
      lock_passwd: false
      passwd: $6$oJcrtka/1w50zPDy$XmbumwMPTrFlrJsMyAsibrh0uxC9vJcoFZKOSxXwhz8PckEIj10VmlKKgCyeEH.MFqTXSYxYPToU1XJSmAqNg0
      shell: /bin/bash
      sudo: ['ALL=(ALL) NOPASSWD:ALL']
      ssh-authorized-keys:
        - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC0f7Up+COIk5UaKujA/EbbutNVq796pVNbka+oqhW10OMBmTK7Kjo4KPmxXZfjVLZf6hHWTs4G9l4HxFRICVV7+oeVTg0Bjd6IaYhavIHQp9B3ea39gbMsyeYdhl02CVSh2C8JywHowjokLHbnsoJgYchS9OanpbmYq8bZ+W988uYxfDOMx2B5xiHIOGGFPcomViy9sdO+YEVqd+Y/FkkQWE45pLKdmmSN21j0kFEsv9nxtL7ziT4bPX7Gc9myAH6oukI7tgzYip1+oVi0RlS2Nv1BTUpXtpEHMbIzTEZrJH9C+YwAHkjrT5hnMQ5qJ0eK4Jg53hJ7HYDtonV6d2gX root@workstation.lmy.com

    - name: root
      passwd: $6$oJcrtka/1w50zPDy$XmbumwMPTrFlrJsMyAsibrh0uxC9vJcoFZKOSxXwhz8PckEIj10VmlKKgCyeEH.MFqTXSYxYPToU1XJSmAqNg0
      shell: /bin/bash
      lock_passwd: false
      ssh-authorized-keys:
        - AAAAB3NzaC1yc2EAAAADAQABAAABAQC0f7Up+COIk5UaKujA/EbbutNVq796pVNbka+oqhW10OMBmTK7Kjo4KPmxXZfjVLZf6hHWTs4G9l4HxFRICVV7+oeVTg0Bjd6IaYhavIHQp9B3ea39gbMsyeYdhl02CVSh2C8JywHowjokLHbnsoJgYchS9OanpbmYq8bZ+W988uYxfDOMx2B5xiHIOGGFPcomViy9sdO+YEVqd+Y/FkkQWE45pLKdmmSN21j0kFEsv9nxtL7ziT4bPX7Gc9myAH6oukI7tgzYip1+oVi0RlS2Nv1BTUpXtpEHMbIzTEZrJH9C+YwAHkjrT5hnMQ5qJ0eK4Jg53hJ7HYDtonV6d2gX root@workstation.lmy.com

  # genisoimage -output cidata.iso -volid cidata -joliet -r user-data meta-data
  # virt-install  -n vlan100  --import --description "vlan100 "  --os-type=Linux  --os-variant=centos7.0  --ram=4086 --vcpus=2  --disk path=/data/libvirt/vlan100/vlan100.qcow2,bus=virtio  --disk path=/data/libvirt/vlan100/cidata.iso,device=cdrom  --network network:ovs,source.portgroup=vlan100 --graphics none  
  ```

- vlan200
  ```sh
  # cat meta-data
  instance-id: centos7
  network-interfaces: |
    auto eth0
    iface eth0 inet static
    address 192.168.200.5
    netmask 255.255.255.0
    gateway 192.168.200.1
  hostname: vlan200.lmy.com
  # cat user-data 
  #cloud-config
  preserve_hostname: false
  hostname: vlan200.lmy.com
  ssh_pwauth: True
  manage_resolv_conf: true
  resolv_conf:
      nameservers: ['114.114.144.114', '8.8.8.8']
  users:
    - name: jenningsl
      groups: wheel
      lock_passwd: false
      passwd: $6$oJcrtka/1w50zPDy$XmbumwMPTrFlrJsMyAsibrh0uxC9vJcoFZKOSxXwhz8PckEIj10VmlKKgCyeEH.MFqTXSYxYPToU1XJSmAqNg0
      shell: /bin/bash
      sudo: ['ALL=(ALL) NOPASSWD:ALL']
      ssh-authorized-keys:
        - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC0f7Up+COIk5UaKujA/EbbutNVq796pVNbka+oqhW10OMBmTK7Kjo4KPmxXZfjVLZf6hHWTs4G9l4HxFRICVV7+oeVTg0Bjd6IaYhavIHQp9B3ea39gbMsyeYdhl02CVSh2C8JywHowjokLHbnsoJgYchS9OanpbmYq8bZ+W988uYxfDOMx2B5xiHIOGGFPcomViy9sdO+YEVqd+Y/FkkQWE45pLKdmmSN21j0kFEsv9nxtL7ziT4bPX7Gc9myAH6oukI7tgzYip1+oVi0RlS2Nv1BTUpXtpEHMbIzTEZrJH9C+YwAHkjrT5hnMQ5qJ0eK4Jg53hJ7HYDtonV6d2gX root@workstation.lmy.com

    - name: root
      passwd: $6$oJcrtka/1w50zPDy$XmbumwMPTrFlrJsMyAsibrh0uxC9vJcoFZKOSxXwhz8PckEIj10VmlKKgCyeEH.MFqTXSYxYPToU1XJSmAqNg0
      shell: /bin/bash
      lock_passwd: false
      ssh-authorized-keys:
        - AAAAB3NzaC1yc2EAAAADAQABAAABAQC0f7Up+COIk5UaKujA/EbbutNVq796pVNbka+oqhW10OMBmTK7Kjo4KPmxXZfjVLZf6hHWTs4G9l4HxFRICVV7+oeVTg0Bjd6IaYhavIHQp9B3ea39gbMsyeYdhl02CVSh2C8JywHowjokLHbnsoJgYchS9OanpbmYq8bZ+W988uYxfDOMx2B5xiHIOGGFPcomViy9sdO+YEVqd+Y/FkkQWE45pLKdmmSN21j0kFEsv9nxtL7ziT4bPX7Gc9myAH6oukI7tgzYip1+oVi0RlS2Nv1BTUpXtpEHMbIzTEZrJH9C+YwAHkjrT5hnMQ5qJ0eK4Jg53hJ7HYDtonV6d2gX root@workstation.lmy.com

  # genisoimage -output cidata.iso -volid cidata -joliet -r user-data meta-data
  # virt-install  -n vlan200  --import --description "vlan200 "  --os-type=Linux  --os-variant=centos7.0  --ram=4086 --vcpus=2  --disk path=/data/libvirt/vlan200/vlan200.qcow2,bus=virtio  --disk path=/data/libvirt/vlan200/cidata.iso,device=cdrom  --network network:ovs,source.portgroup=vlan200 --graphics none  
  ```
- enable ip forwarding 
  ```sh
  # echo net.ipv4.ip_forward=1 >> /etc/sysctl.conf
  # sysctl -p
  ```

  now VM `vlan100` and `vlan200` can access each other

4. show ovs

  ```sh
  # ovs-vsctl show
  6f640d61-54ac-4644-b6b8-3b27db02294b
      Bridge br0
          Port vnet0
              tag: 100
              Interface vnet0
          Port vlan200
              tag: 200
              Interface vlan200
                  type: internal
          Port vnet1
              tag: 200
              Interface vnet1
          Port vlan100
              tag: 100
              Interface vlan100
                  type: internal
          Port br0-phy-port0
              Interface enp24s0
                  type: system
          Port br0
              Interface br0
                  type: internal
      ovs_version: "2.13.0"
  # ovs-ofctl show br0
  OFPT_FEATURES_REPLY (xid=0x2): dpid:000000d86112b7c8
  n_tables:254, n_buffers:0
  capabilities: FLOW_STATS TABLE_STATS PORT_STATS QUEUE_STATS ARP_MATCH_IP
  actions: output enqueue set_vlan_vid set_vlan_pcp strip_vlan mod_dl_src mod_dl_dst mod_nw_src mod_nw_dst mod_nw_tos mod_tp_src mod_tp_dst
  1(enp24s0): addr:00:d8:61:12:b7:c8
      config:     0
      state:      0
      current:    1GB-FD AUTO_NEG
      advertised: 10MB-HD 10MB-FD 100MB-HD 100MB-FD 1GB-FD COPPER AUTO_NEG AUTO_PAUSE AUTO_PAUSE_ASYM
      supported:  10MB-HD 10MB-FD 100MB-HD 100MB-FD 1GB-FD COPPER AUTO_NEG AUTO_PAUSE AUTO_PAUSE_ASYM
      speed: 1000 Mbps now, 1000 Mbps max
  5(vlan200): addr:c6:64:1e:b4:a0:d9
      config:     0
      state:      0
      speed: 0 Mbps now, 0 Mbps max
  6(vlan100): addr:3e:68:58:10:bc:06
      config:     0
      state:      0
      speed: 0 Mbps now, 0 Mbps max
  7(vnet0): addr:fe:54:00:30:7a:13
      config:     0
      state:      0
      current:    10MB-FD COPPER
      speed: 10 Mbps now, 0 Mbps max
  8(vnet1): addr:fe:54:00:d4:a0:7f
      config:     0
      state:      0
      current:    10MB-FD COPPER
      speed: 10 Mbps now, 0 Mbps max
  LOCAL(br0): addr:00:d8:61:12:b7:c8
      config:     0
      state:      0
      speed: 0 Mbps now, 0 Mbps max
  OFPT_GET_CONFIG_REPLY (xid=0x4): frags=normal miss_send_len=0

  ### set ovs  openflow version
  # ovs-vsctl set bridge br0    protocols=OpenFlow13
  ### add vlan tag 100 to the packet from enp24s0 then to vlan100

  # ovs-ofctl -O OpenFlow13 add-flow br0  in_port=1,actions=push_vlan:0x8100,mod_vlan_vid:100,output:6
  # ovs-ofctl -O OpenFlow13 add-flow br0 in_port=1,dl_type=0x0800,nw_proto=1,nw_dst=192.168.100.5/24,actions=push_vlan:0x8100,mod_vlan_vid:100,output:6
  # ovs-ofctl -O OpenFlow13 add-flow br0 in_port=1,dl_type=0x0800,nw_proto=17,nw_dst=192.168.100.5/24,actions=push_vlan:0x8100,mod_vlan_vid:100,output:6
  # ovs-ofctl -O OpenFlow13 add-flow br0 in_port=1,dl_type=0x0800,nw_proto=6,nw_dst=192.168.100.5/24,actions=push_vlan:0x8100,mod_vlan_vid:100,output:6
  
  ### remove vlan tag 100 of  packet from vlan100  then to enp24s0

  # ovs-ofctl -O OpenFlow13 add-flow br0 dl_type=0x0800,dl_vlan=100,actions=pop_vlan,output:1
  # ovs-ofctl -O OpenFlow13 add-flow br0 dl_type=0x0800,nw_proto=17,dl_vlan=100,actions=pop_vlan,output:1
  # ovs-ofctl -O OpenFlow13 add-flow br0 dl_type=0x0800,nw_proto=1,dl_vlan=100,actions=pop_vlan,output:1
  # ovs-ofctl -O OpenFlow13 add-flow br0 dl_type=0x0800,nw_proto=6,dl_vlan=100,actions=pop_vlan,output:1

  ```