Create rootfs for yum based docker container
---
1. on host, install anaconda and livemedia
  ```
  dnf install -y anaconda lorax
  ```
2. create docker rootfs tar file
  ```
  livemedia-creator --make-tar --no-virt --ks=fedora-container.ks   --image-name=fedora-base.tar
  ```
  the file will be created as  /var/tmp/fedora-base.tar

3. use a [Dockerfile](./Dockerfile) to create a further docker image
  ```
  docker build -t fedora:34 -f Dockerfile .
  ```

Create rootfs for debian based docker container
---
- create ubuntu image
  ```shell
  debootstrap --arch=amd64 --variant=minbase --make-tarball=focal.tar  focal focal-root/
  ```