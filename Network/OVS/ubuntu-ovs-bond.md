Ubuntu 18.04 introduced Netplan as a replacement to the legacy “/etc/network/interfaces” network configuration. Unfortunately Netplan does not support OVS, hence the first challenge is to revert Ubuntu to the legacy configuration method.

1. modify grub, edit /etc/default/grub
```
GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0 ipv6.disable=1 netcfg/do_not_use_netplan=true"
```
2. generate new grub.cfg
```
grub-mkconfig -o /boot/grub/grub.cfg
```
3. remove netplan 
```
apt-get purge nplan netplan.io
```

4. create ovs 
```sh
apt-get install openvswitch-switch ifupdown 
ovs-vsctl add-br virtbr0
ovs-vsctl add-bond virtbr0 bond0 eno1 eno2  lacp=active bond_mode=balance-tcp other_config:bond-detect-mode=miimon other_config:bond-miimon-interval=100 
```

5. modify /etc/network/interfaces
```
iface eno1 inet manual
iface eno2 inet manual

auto virtbr0
allow-ovs virtbr0
iface virtbr0 inet static
  address 10.36.48.46
  netmask 255.255.255.128
  gateway 10.36.48.1
  dns-nameserver 114.114.114.114
  ovs_type OVSBridge
  ovs_ports bond0
  
allow-virtbr0 bond0 
iface bond0 inet manual 
  ovs_bridge virtbr0 
  ovs_type OVSBond 
  ovs_bonds eno1 eno2 
  ovs_options  lacp=active bond_mode=balance-tcp other_config:miimon=100 other_config:lacp-rate=1
```