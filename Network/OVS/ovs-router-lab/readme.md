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

- flows
```
# Table 0: Admission control
# 屏蔽所有进入 OVS 的以太网广播数据包
ovs-ofctl add-flow sw0 "table=0, dl_src=01:00:00:00:00:00/01:00:00:00:00:00, actions=drop"
# 屏蔽 STP 协议的广播数据包
ovs-ofctl add-flow sw0 "table=0, dl_dst=01:80:c2:00:00:00/ff:ff:ff:ff:ff:f0, actions=drop"

# 加入低优先级的包，
ovs-ofctl add-flow sw0 "table=0, priority=0, actions=resubmit(,1)"

# Table 1: VLAN Input Processing
#首先丢弃不符合的包
ovs-ofctl add-flow sw0 "table=1, priority=0, actions=drop"
# 从sw0过来的包，都要到下一步处理
ovs-ofctl add-flow sw0 "table=1, priority=99, in_port=LOCAL, actions=resubmit(,2)" 
# 修改从不同端口过来的包，加上相应的vlan ID
ovs-ofctl add-flow sw0 "table=1,priority=3,in_port=10,dl_vlan=0xffff,actions=mod_vlan_vid:10,normal"
vs-ofctl add-flow sw0 "table=1,priority=3,in_port=20,dl_vlan=0xffff,actions=mod_vlan_vid:20,normal"
ovs-ofctl add-flow sw0 "table=1,priority=3,in_port=30,dl_vlan=0xffff,actions=mod_vlan_vid:30,normal"
ovs-ofctl add-flow sw0 "table=1,priority=3,in_port=40,dl_vlan=0xffff,actions=mod_vlan_vid:40,normal"
#
#Table 2: MAC+VLAN Learning for Ingress Port

ovs-ofctl add-flow sw0 "table=2 actions=learn(table=10,NXM_OF_VLAN_TCI[0..11], NXM_OF_ETH_DST[]=NXM_OF_ETH_SRC[], load:NXM_OF_IN_PORT[]->NXM_NX_REG0[0..15]), resubmit(,3)"
## 还差一个从LOCAL过来的包的处理
# Table 3: Look Up Destination Port
# 包经过table 10后，register 0只会有两个结果，第一个，找到将要转发的的 `port number`，并记录在其中。第二个，则是在table 10中，找不到可以match的规则，register 0中记录数为0。最后发往table 4进行处理。
ovs-ofctl add-flow sw0 "table=3 priority=50 actions=resubmit(,10), resubmit(,4)"
## 为了避免多播和广播封包进入入table 10中，我们可以在table 3加上一層过滤：
ovs-ofctl add-flow sw0 "table=3 priority=99 dl_dst=01:00:00:00:00:00/01:00:00:00:00:00 actions=resubmit(,4)"

# Table 4: Output Processing
# 配合reg0加入符合转发至主干的规则：
ovs-ofctl add-flow sw0 "table=4 reg0=1 actions=1"
# 依reg0转发至各別的 access port 前，先将包的 VLAN header 去掉，再进行转发：
ovs-ofctl add-flows sw0 "table=4 reg0=10 actions=strip_vlan,10"
ovs-ofctl add-flows sw0 "table=4 reg0=20 actions=strip_vlan,20"
ovs-ofctl add-flows sw0 "table=4 reg0=30 actions=strip_vlan,30"
ovs-ofctl add-flows sw0 "table=4 reg0=40 actions=strip_vlan,40"
#对于未知的包，对应的VLAN要进行flooding或者返回原来的table 1进行处理
ovs-ofctl add-flows sw0 "table=4 reg0=0 priority=99 dl_vlan=10 actions=1,strip_vlan,10"

ovs-ofctl add-flows sw0 "table=4 reg0=0 priority=99 dl_vlan=20 actions=1,strip_vlan,20"
ovs-ofctl add-flows sw0 "table=4 reg0=0 priority=99 dl_vlan=30 actions=1,strip_vlan,30"
ovs-ofctl add-flows sw0 "table=4 reg0=0 priority=99 dl_vlan=40 actions=1,strip_vlan,40"
ovs-ofctl add-flows sw0 "table=4 reg0=0 priority=50 actions=1"
```

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
- https://www.shuzhiduo.com/A/mo5kn7bnJw/
- https://github.com/antrea-io/antrea/blob/main/docs/design/ovs-pipeline.md
- https://antrea.io/docs/v1.0.1/design/ovs-pipeline/