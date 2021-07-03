Faucet
---
Lab:
- fedora 34
- install package
  ```
  dnf install -y openvswitch python-devel  make gcc lorax
   pip3 install faucet
   ```
- create and config ovs via [ovs-config.sh](./ovs-config.sh)

- create [faucet config](./faucet.yaml) in /etc/faucet/faucet.yaml

- config firewalld via [firewalld-config.sh](./firewalld-config.sh)

- create docker image for testing  with [Dockerfile](./Dockerfile)
  ```
  docker build -f Dockerfile -t fedora-base:34 .
  ```

- start container and make config
  - vlan10
    ```
    docker run -d  --name vlan10-01  --net=none fedora-base:34
    ## move the link to container vlan10-01 network namespace
    ip link set vlan10-01 netns $(docker inspect -f '{{.State.Pid}}' vlan10-01) 
    
    ##then enter into docker namespace
    nsenter -a -t $(docker inspect -f '{{.State.Pid}}' vlan10-01)
    ip addr add 10.48.10.2/24 dev vlan10-01
    ip link set dev vlan10-01 up
    ```
  - vlan20
    ```
    docker run -d  --name vlan20-01 --net=none fedora-base:34
    ip link set vlan20-01 netns $(docker inspect -f '{{.State.Pid}}' vlan20-01)
    nsenter -a -t $(docker inspect -f '{{.State.Pid}}' vlan20-01)
    ip addr add 10.48.20.2/24 dev vlan20-01
    ip link set dev vlan20-01 up

    ```
  - vlan30
    ```
    docker run -d  --name vlan30-01 --net=none fedora-base:34
    ip link set vlan30-01 netns $(docker inspect -f '{{.State.Pid}}' vlan30-01)
    nsenter -a -t $(docker inspect -f '{{.State.Pid}}' vlan30-01)
    ip addr add 10.48.30.2/24 dev vlan30-01
    ip link set dev vlan30-01 up

    ```
  - vlan40
    ```
    docker run -d  --name vlan40-01 --net=none fedora-base:34
    ip link set vlan40-01 netns $(docker inspect -f '{{.State.Pid}}' vlan40-01)
    nsenter -a -t $(docker inspect -f '{{.State.Pid}}' vlan40-01)
    ip addr add 10.48.40.2/24 dev vlan40-01
    ip link set dev vlan40-01 up

    ```
- config internal interface `sw0`
  ```
  ip addr add 10.48.0.1/24 dev sw0
  ip link set dev sw0 up
  ip route add 10.48.0.0/16 via 10.48.0.1 dev sw0
  ```
- config flows for different vlan routing
  ```
  ovs-ofctl dump-flows sw0 --protocols=OpenFlow13
  ```


table=0, priority=200,in_port=sw0 actions=load:0x1->NXM_NX_REG0[0..15],goto_table:10

table=20, priority=200,arp,arp_tpa=10.10.1.1,arp_op=1 actions=move:NXM_OF_ETH_SRC[]->NXM_OF_ETH_DST[],mod_dl_src:aa:bb:cc:dd:ee:ff,load:0x2->NXM_OF_ARP_OP[],move:NXM_NX_ARP_SHA[]->NXM_NX_ARP_THA[],load:0xaabbccddeeff->NXM_NX_ARP_SHA[],move:NXM_OF_ARP_SPA[]->NXM_OF_ARP_TPA[],load:0xa0a0101->NXM_OF_ARP_SPA[],IN_PORT
---
Links

- https://arthurchiao.art/blog/ovs-deep-dive-6-internal-port/
- https://www.cnblogs.com/CasonChan/p/4754671.html
- https://oswalt.dev/2014/07/sdn-protocols-part-2-openflow-deep-dive/
- https://xiangyu123.github.io/2018/10/19/openvswitch-intro/
- https://zhaozhanxu.com/2017/02/26/SDN/OVN/2017-02-26-ovn-flows/
- https://vcpu.me/openvswitch3/
- https://github.com/openvswitch/ovs/blob/master/Documentation/tutorials/ovs-advanced.rst
- https://tonydeng.github.io/sdn-handbook/ovs/ovn-internal.html
- http://galsagie.github.io/2015/11/23/ovn-l3-deepdive/
- https://networkop.co.uk/blog/2016/12/10/ovn-part2/
- https://blog.csdn.net/weixin_30747253/article/details/99916400