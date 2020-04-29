#  Create OVS bridge/port/interface via NetworkManager
Since NetworkManager integrated with OVS, we can use NetworkManager to manage OVS bridge/port/interfaces

1. install required package 
    ```
    dnf install NetworkManager-ovs
    ```
2. remove default connections for the physical ethernets, and reboot the server

3. create a ovs bridge (`br0`)
    ```
    nmcli connection add  con-name br0  type ovs-bridge conn.interface br0

    ## add physical ethernet to br0
    nmcli connection add con-name ens160 type ovs-port conn.interface ens160 master br0
    nmcli connection add con-name ens160 type ethernet slave-type ovs-port conn.interface ens160 master ens160

    ## create internal port and interface, and then IP address will be added to the interface
    nmcli connection add con-name br0-port0 type ovs-port conn.interface br0-port0 master br0
    nmcli connection add con-name br0-inface0 type ovs-interface conn.interface br0-inface0 master br0-port0 ipv4.method auto
    ```

4. show all NetworkManager connections and devices
    ```sh
    # nmcli connection show 
    NAME         UUID                                  TYPE           DEVICE
    br0-inface0  087851a8-0121-4ddb-b9e2-40047938e579  ovs-interface  br0-inface0
    br0          b912ba0f-9ee8-469a-8aea-80614949e597  ovs-bridge     br0
    br0-port0    1742bbda-c234-40d0-9a07-dc4bf93d6287  ovs-port       br0-port0
    ens160       ce4aa26b-d9e1-46e0-93f7-e7a1fa78c849  ethernet       ens160
    ens160       2917fae3-b5c0-4983-9a88-5a0c64dede6a  ovs-port       ens160
    ```

    > we need to distinguish the `connection name` and `interface  name`  or `device`


    ```sh
    # nmcli device 
    DEVICE       TYPE           STATE      CONNECTION
    br0-inface0  ovs-interface  connected  br0-inface0
    ens160       ethernet       connected  ens160
    br0          ovs-bridge     connected  br0
    br0-port0    ovs-port       connected  br0-port0
    ens160       ovs-port       connected  ens160
    lo          loopback       unmanaged  --         
    virbr0-nic  tun            unmanaged  --    ```
    ```

5. show ovs 
    ```sh
    # ovs-vsctl show
    da9eb4c9-66c1-4f96-8a5c-9ac8580bef42
        Bridge br0
            Port ens160
                Interface ens160
                    type: system
            Port br0-port0
                Interface br0-inface0
                    type: internal
        ovs_version: "2.13.0"
    ```

6. show IP addresses
    ```sh
    # ip addr
    4: br0-inface0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
        link/ether 26:2d:35:6e:e7:df brd ff:ff:ff:ff:ff:ff
        inet 192.168.34.133/24 brd 192.168.34.255 scope global dynamic noprefixroute br0-inface0
        valid_lft 1602sec preferred_lft 1602sec
        inet6 fe80::fa0b:2d33:113d:c46f/64 scope link noprefixroute
        valid_lft forever preferred_lft forever
    ```