Faucet
---
Lab:
- fedora 34
- install package
  ```
  dnf install -y openvswitch python-devel  make gcc
   pip3 install faucet
   ```
- create and config ovs via [ovs-config.sh](./ovs-config.sh)

- create [faucet config](./faucet.yaml) in /etc/faucet/faucet.yaml

- config firewalld via [firewalld-config.sh](./firewalld-config.sh)
- create docker env for testing 

  - build image
    ```
     livemedia-creator --make-tar --iso=CentOS-Stream-8-x86_64-20210629-boot.iso --ks=centos8.ks --image-name=centos-8-docker.tar.gz
    ```
---
Links

- https://arthurchiao.art/blog/ovs-deep-dive-6-internal-port/
- https://www.cnblogs.com/CasonChan/p/4754671.html
- https://oswalt.dev/2014/07/sdn-protocols-part-2-openflow-deep-dive/
- https://xiangyu123.github.io/2018/10/19/openvswitch-intro/

