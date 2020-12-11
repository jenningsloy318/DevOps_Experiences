
- install openvswtich 
  ```
  dnf install -y centos-release-openstack-train
  dnf install -y openvswitch os-net-config
  ```
- enable and config bridge 
  ```
  # systemctl  enable --now  openvswitch
  # cat ovs-bridge-single-interface.yml
    network_config:
    - type: ovs_bridge
        name: br-ex
        use_dhcp: true
        members:
        - type: interface
            name: enp9s0
  # os-net-config -c ovs-bridge-single-interface.yml
  ```  
- create kvm network
  ```
  # cat kvm-ovs.xml
    <network>
    <name>ovs-bridge</name>
    <forward mode='bridge'/>
    <bridge name='br-ex'/>
    <virtualport type='openvswitch'/>
    </network>
  # systemctl start libvirtd
  # virsh net-define  kvm-ovs.xml
  # virsh net-start ovs-bridge
  # virsh net-autostart  ovs-bridge
  # virsh net-list --all
    Name         State    Autostart   Persistent
    -----------------------------------------------
    ovs-bridge   active   yes         yes
  ```

- set image password and uninstall cloud-init
    ```
    virt-customize -a bionic-server-cloudimg-amd64.img --uninstall cloud-init,lxd,snapd --root-password password:jennings
    ```

2. create VM
```sh
# virt-install  -n linux-perf-server  --import --description "linux-perf-server "  --os-type=Linux  --os-variant=ubuntu18.04  --ram=4086 --vcpus=2  --disk path=/data/KVM/linux-perf-server/linux-perf-server.img,bus=virtio   --network network:ovs-bridge --graphics none  
```

3. config sshd 
  ```
  dpkg-reconfigure openssh-server
  ```
