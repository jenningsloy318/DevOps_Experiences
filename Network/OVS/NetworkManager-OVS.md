#  Create OVS bridge/port/interface via NetworkManager

Since NetworkManager integrated with OVS, we can use NetworkManager to manage OVS bridge/port/interfaces

1. create a ovs bridge (`k8s`)
```sh
# nmcli connection add  con-name k8s type ovs-bridge conn.interface k8s
Connection 'k8s' (a265ffaf-e1dc-4cb2-878f-938397e3471c) successfully added.
```
2. add an ovs port (`port0`) to ovs bridge(`k8s`)
```sh
# nmcli connection add con-name k8s-port0 type ovs-port conn.interface port0 master k8s
Connection 'k8s-port0' (9ab6b6c1-e938-4a10-9f4e-48ca8a33d0dd) successfully added.

```
3. add an ethernet interface `enp24s0` to newly created port(`port0`)
```sh
# nmcli connection add con-name k8s-iface0 type ethernet conn.interface enp24s0 master port0 
Connection 'k8s-iface0' (c21e5676-f714-4f01-aec6-a035acfd884b) successfully added.

```

4. add an internal ovs port(`port1`) to ovs bridge
```sh
# nmcli connection add con-name k8s-port1 type ovs-port conn.interface port1 master k8s
Connection 'k8s-port1' (9847f5f2-f056-4b22-acf8-bde2c923e782) successfully added.

```
5. add an internal ovs interface `iface1` to port `port1`
```
# nmcli connection add con-name k8s-iface1 type ovs-interface conn.interface iface1 master port1 ipv4.method auto
Connection 'k8s-iface1' (cf2ad29e-392e-4cdd-b8f3-20f3add00342) successfully added.
```
> then this internal interface can get IP address via dhcp or static configuration, which stands for the ovs bridge


6. also add vlan 

```
# nmcli connection add con-name k8s-port2  type ovs-port conn.interface port2 master k8s ovs-port.tag 100
Connection 'k8s-port2' (7927fcc2-c1e8-4ec1-a85a-1f59cc0365a9) successfully added.
# nmcli connection add con-name k8s-iface2 type  ovs-interface conn.interface iface2 master port2 ipv4.method manual ipv4.addresses 192.168.100.1/24 
Connection 'k8s-iface2' (7b995f98-8964-4f46-b558-6157f4f251b6) successfully added.

```

7. show all NetworkManager connections and devices
```sh
# nmcli connection show 
NAME        UUID                                  TYPE           DEVICE  
NAME        UUID                                  TYPE           DEVICE  
k8s-iface1  cf2ad29e-392e-4cdd-b8f3-20f3add00342  ovs-interface  iface1  
k8s-iface2  7b995f98-8964-4f46-b558-6157f4f251b6  ovs-interface  iface2  
virbr0      e5bcf17b-7a81-4684-af01-63ba0295b873  bridge         virbr0  
k8s         a265ffaf-e1dc-4cb2-878f-938397e3471c  ovs-bridge     k8s     
k8s-iface0  c21e5676-f714-4f01-aec6-a035acfd884b  ethernet       enp24s0 
k8s-port0   9ab6b6c1-e938-4a10-9f4e-48ca8a33d0dd  ovs-port       port0   
k8s-port1   9847f5f2-f056-4b22-acf8-bde2c923e782  ovs-port       port1   
k8s-port2   7927fcc2-c1e8-4ec1-a85a-1f59cc0365a9  ovs-port       port2  
```

> we need to distinguish the `connection name` and `interface  name`  or `device`


```sh
# nmcli device 
DEVICE      TYPE           STATE      CONNECTION 
iface1      ovs-interface  connected  k8s-iface1 
iface2      ovs-interface  connected  k8s-iface2 
virbr0      bridge         connected  virbr0     
enp24s0     ethernet       connected  k8s-iface0 
k8s         ovs-bridge     connected  k8s        
port0       ovs-port       connected  k8s-port0  
port1       ovs-port       connected  k8s-port1  
port2       ovs-port       connected  k8s-port2  
lo          loopback       unmanaged  --         
virbr0-nic  tun            unmanaged  --    ```
```

8. show ovs 
```sh
# ovs-vsctl show
6f640d61-54ac-4644-b6b8-3b27db02294b
    Bridge "k8s"
        Port "port1"
            Interface "iface1"
                type: internal
        Port "port2"
            tag: 100
            Interface "iface2"
                type: internal
        Port "port0"
            Interface "enp24s0"
                type: system
    ovs_version: "2.10.1"
```

9. show IP addresses
```sh
# ip addr
20: iface1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
    link/ether 7e:32:70:d1:d8:aa brd ff:ff:ff:ff:ff:ff
    inet 192.168.3.72/24 brd 192.168.3.255 scope global dynamic noprefixroute iface0
       valid_lft 84789sec preferred_lft 84789sec
    inet6 fe80::3b64:992f:240a:52e8/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
22: iface2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
    link/ether de:2e:31:34:3c:b1 brd ff:ff:ff:ff:ff:ff
    inet 192.168.100.1/24 brd 192.168.100.255 scope global noprefixroute iface2
       valid_lft forever preferred_lft forever
    inet6 fe80::c5d4:744b:fb35:427c/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
```