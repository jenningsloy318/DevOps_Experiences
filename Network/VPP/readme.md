VPP
---

The VPP platform is an extensible framework that provides out-of-the-box production quality switch/router functionality. It is the open source version of Cisco's Vector Packet Processing (VPP) technology: a high performance, packet-processing stack that can run on commodity CPUs.



- [VPP Wiki](https://wiki.fd.io/view/VPP)
- [VPP Use Cases](https://wiki.fd.io/view/VPP#Use_Cases)
- [vpp Doc](https://docs.fd.io/vpp/)

## BVI Support
A bridge domain (BD) can have an L3 Bridge Virtual Interface (BVI) (one per BD) with multiple VXLAN-tunnels and Ethernet bridge ports. All three types of bridge ports (BVI, VXLAN and Ethernet) must interoperate properly to forward traffic to each other. BVI allow VMs on separate BDs or VXLAN segments to reach each other via IRB (Integrated Routing and Bridging).

The BVI for a BD is setup by creating and setup a loopback interface and then add it to the BD as its BVI interface. A BD in a VPP can only have one BVI. A VXLAN segment consists of multiple BDs from multiple VPPs, however, may have multiple BVIs with one BVI on each BD of each VPP.


## 1. Create two vlans and can be routable to each other
```sh{.line-numbers}
loopback create
set int l2 bridge loop1 2 bvi
set int ip table loop1 4
set int ip address loop1 192.168.2.1/24
set int state loop1 up

create vhost socket /tmp/vm00.sock server
create sub VirtualEthernet0/0/0 2

set int l2 bridge VirtualEthernet0/0/0.2 2
set int l2 tag-rewrite VirtualEthernet0/0/0.2 pop 1
set int state VirtualEthernet0/0/0.2 up


loopback create
set int l2 bridge loop2 3 bvi
set int ip table loop2 4
set int ip address loop2 192.168.3.1/24
set int state loop2 up

create sub VirtualEthernet0/0/0 3
set int l2 bridge VirtualEthernet0/0/0.3 3
set int l2 tag-rewrite VirtualEthernet0/0/0.3 pop 1
set int state VirtualEthernet0/0/0.3 up
```


## 2. XML content of the interface for libvirt 
```xml{.line-numbers}
    <interface type='vhostuser'>
      <mac address='52:54:00:4c:47:f2'/>
      <source type='unix' path='/tmp/vm00.sock ' mode='server'/>
      <model type='virtio'/>
      <alias name='net1'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x0'/>
      <portgroup name='2'>
        <vlan>
          <tag id='2'/>
        </vlan>
      </portgroup>
    </interface>
```
note: not sure portgroup is working.