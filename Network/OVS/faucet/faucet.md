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
    # docker run -d  --name vlan10-01 fedora-base:34
    # netns=$(docker inspect -f '{{.State.Pid}}' vlan10-01)
    # ip link set vlan10-01 netns $netns
    
    ##then enter into docker namespace
    nsenter -a -t $netns
    ip addr add 10.48.10.2/24 dev vlan10-01
    ip link set dev vlan10-01 up
    ```
  - vlan20
    ```
    docker run -d  --name vlan20-01 fedora-base:34
    netns=$(docker inspect -f '{{.State.Pid}}' vlan20-01)
    nsenter -a -t $netns
    ip addr add 10.48.20.2/24 dev vlan20-01
    ip link set dev vlan20-01 up

    ```
  - vlan30
    ```
    docker run -d  --name vlan30-01 fedora-base:34
    netns=$(docker inspect -f '{{.State.Pid}}' vlan30-01)
    nsenter -a -t $netns
    ip addr add 10.48.30.2/24 dev vlan30-01
    ip link set dev vlan30-01 up

    ```
  - vlan40
    ```
    docker run -d  --name vlan40-01 fedora-base:34
    netns=$(docker inspect -f '{{.State.Pid}}' vlan40-01)
    ip addr add 10.48.40.2/24 dev vlan40-01
    ip link set dev vlan40-01 up

    ```  
---
Links

- https://arthurchiao.art/blog/ovs-deep-dive-6-internal-port/
- https://www.cnblogs.com/CasonChan/p/4754671.html
- https://oswalt.dev/2014/07/sdn-protocols-part-2-openflow-deep-dive/
- https://xiangyu123.github.io/2018/10/19/openvswitch-intro/

