Description: Now we can use LXD to management the lxc containers, 

This document discribe lxd 3.x, for prvious lxd conf, refer to [lxd 2.0](./lxd-2.0.md).

Environment:
---
Host: fedora 30 x86_64, disable NetworkManager, enable traditional network-scripts
lxd: 3.16
lxc: 3.2.1
ovs: 2.10.1

LXD config
---
1. set uid/guid mapping

```sh
  # cat /etc/subuid
  lxd:100000:65536
  root:100000:65536
  # cat /etc/subgid
  lxd:100000:65536
  root:100000:65536
```
2. make alias for images, we can create alias for downloaded image
```sh
  # lxc image list
  +------------+--------------+--------+--------------------------------------+--------+---------+------------------------------+
  |   ALIAS    | FINGERPRINT  | PUBLIC |             DESCRIPTION              |  ARCH  |  SIZE   |         UPLOAD DATE          |
  +------------+--------------+--------+--------------------------------------+--------+---------+------------------------------+
  |            | b0ff8810c4c3 | no     | Centos 7 amd64 (20190831_07:08)      | x86_64 | 84.07MB | Sep 1, 2019 at 1:20am (UTC)  |
  +------------+--------------+--------+--------------------------------------+--------+---------+------------------------------+
  |            | 2975c43f6719 | no     | Debian buster amd64 (20190831_05:24) | x86_64 | 93.21MB | Sep 1, 2019 at 12:11am (UTC) |
  +------------+--------------+--------+--------------------------------------+--------+---------+------------------------------+
  |            | ad7655ad0231 | no     | Ubuntu bionic amd64 (20190831_07:42) | x86_64 | 93.72MB | Sep 1, 2019 at 12:12am (UTC) |
  +------------+--------------+--------+--------------------------------------+--------+---------+------------------------------+

  # lxc image alias create Centos7 b0ff8810c4c3

  # lxc image list
  +------------+--------------+--------+--------------------------------------+--------+---------+------------------------------+
  |   ALIAS    | FINGERPRINT  | PUBLIC |             DESCRIPTION              |  ARCH  |  SIZE   |         UPLOAD DATE          |
  +------------+--------------+--------+--------------------------------------+--------+---------+------------------------------+
  | Centos7    | b0ff8810c4c3 | no     | Centos 7 amd64 (20190831_07:08)      | x86_64 | 84.07MB | Sep 1, 2019 at 1:20am (UTC)  |
  +------------+--------------+--------+--------------------------------------+--------+---------+------------------------------+
  | Debian9    | 2975c43f6719 | no     | Debian buster amd64 (20190831_05:24) | x86_64 | 93.21MB | Sep 1, 2019 at 12:11am (UTC) |
  +------------+--------------+--------+--------------------------------------+--------+---------+------------------------------+
  | Ubuntu1804 | ad7655ad0231 | no     | Ubuntu bionic amd64 (20190831_07:42) | x86_64 | 93.72MB | Sep 1, 2019 at 12:12am (UTC) |
  +------------+--------------+--------+--------------------------------------+--------+---------+------------------------------+

```

LXD Containers
---

# Use external interface for lxc network 
1. add storage pool

```sh
lxc storage create ovs dir source=/data/lxd

```
2. add storage pool to profile
```sh
lxc profile device add default root disk path=/ pool=default
```

3. show existing network 
```sh
lxc network list
+---------+----------+---------+-------------+---------+
|  NAME   |   TYPE   | MANAGED | DESCRIPTION | USED BY |
+---------+----------+---------+-------------+---------+
| br-ovs  | bridge   | NO      |             | 0       |
+---------+----------+---------+-------------+---------+
| enp24s0 | physical | NO      |             | 0       |
+---------+----------+---------+-------------+---------+
```

4. add existing network into profile, as we have already created a bridge with openvswitch, we can use that
```sh
lxc network attach-profile br-ovs  default eth0
```

5. edit profile, 
  - add cloud-init conf
  - change the `nictype` from `macvlan` to `bridged`
  
```conf
lxc profile show default
config:
  user.user-data: |
    #cloud-config
    users:
    - name: root
      password: $6$UnQHfmaW93n/aHh3$2Ib5OWND3NCqoamVCJdxXr5ENM7me2kPQPYpbK/3wGZJSvNhAd2NEuJ5zN3RnzkKNjgb0nULTrZnDeqr/8TM19U0
      ssh_authorized_keys:
      - AAAAB3NzaC1yc2EAAAADAQABAAABAQDyDim/4NldQtJFkLUZPAtjIxj1GZBD8AwAMunW1pac+vfvpE+pB31xnECEFlwbRtrbsksF2LRjqw87o1GhrybZBuJdR3K3KN6VR9qLdsiNCqrBUAcpkO0K9PYK43zJf9bhvhZl2qa5lA6xHdRtg20etc6g/uBVMJp6MXKrdt88Az+nOhWb0Ozdper+vnqH1JcHw/dWN9mPJz4eN+dv3LO9PXpEI756KI2TXgXdHmgJV76sPHQVLR6wC8GoAWgcm60aU8eR1ekfefU85mGWjq8oR8Ghmda00z3mVrKukvdiLNvhIlO1iFdwS9lXTAzfych+MeKhGXscwNR+xk3cH8JYwN jenningsl@workstation.lmy.com
    - name: jenningsl
      home: /home/jenningsl
      shell: /bin/bash
      groups: [adm, root,wheel]
      sudo:  ALL=(ALL) ALL
      password: $6$UnQHfmaW93n/aHh3$2Ib5OWND3NCqodxamVCJXr5ENM7me2kPQPYpbK/3wGZJSvNhAd2NEuJ5zN3RnzkKNjgb0nULTrZnDeqr/8TM19U0
      ssh_authorized_keys:
       - AAAAB3NzaC1yc2EAAAADAQABAAABAQDyDim/4NldQtJFkLdUZPAtjIxj1GZBD8AwAMunW1pac+vfvpE+pB31xnECEFlwbRtrbsksF2LRjqw87o1GhrybZBuJdR3K3KN6VR9qLiNCqrBUAcpkO0K9PYK43zJf9bhvhZl2qa5lA6xHdRtg20etc6g/uBVMJp6MXKrdt88Az+nOhWb0Ozdper+vnqH1JcHw/dWN9mPJz4eN+dv3LO9PXpEI756KI2TXgXdHmgJV76sPHQVLR6wC8GoAWgcm60aU8eR1ekfefU85mGWjq8oR8Ghmda00z3mVrKukvdiLNvhIlO1iFdwS9lXTAzfych+MeKhGXscwNR+xk3cH8JYwN jenningsl@workstation.lmy.com
description: ""
devices:
  eth0:
    nictype: bridged
    parent: br-ovs
    type: nic
  root:
    path: /
    pool: default
    type: disk
name: ovs
used_by: []
```

6. create lxc container

```sh
lxc init images:centos/7/amd64 container1
lxc start container1
lxc list
+--------------+---------+---------------------+------+------------+-----------+
|     NAME     |  STATE  |        IPV4         | IPV6 |    TYPE    | SNAPSHOTS |
+--------------+---------+---------------------+------+------------+-----------+
| container1   | RUNNING | 192.168.3.77 (eth0) |      | PERSISTENT | 0         |
+--------------+---------+---------------------+------+------------+-----------+

```

and we can access the container with `lxc exec container1 bash`

```sh
[root@container1 ~]# yum install openssh-server 
Failed to set locale, defaulting to C
Loaded plugins: fastestmirror
Determining fastest mirrors
 * base: mirrors.aliyun.com
 * extras: mirrors.aliyun.com
 * updates: mirrors.aliyun.com
base                                                                                                                                                                                                                    | 3.6 kB  00:00:00     
extras                                                                                                                                                                                                                  | 3.4 kB  00:00:00     
updates                                                                                                                                                                                                                 | 3.4 kB  00:00:00     
(1/4): base/7/x86_64/group_gz                                                                                                                                                                                           | 166 kB  00:00:00     
(2/4): extras/7/x86_64/primary_db                                                                                                                                                                                       | 215 kB  00:00:00     
(3/4): base/7/x86_64/primary_db                                                                                                                                                                                         | 6.0 MB  00:00:01     
(4/4): updates/7/x86_64/primary_db                                                                                                                                                                                      | 7.4 MB  00:00:01     
Resolving Dependencies
--> Running transaction check
---> Package openssh-server.x86_64 0:7.4p1-16.el7 will be installed
--> Processing Dependency: libwrap.so.0()(64bit) for package: openssh-server-7.4p1-16.el7.x86_64
--> Running transaction check
---> Package tcp_wrappers-libs.x86_64 0:7.6-77.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

===============================================================================================================================================================================================================================================
 Package                                                          Arch                                                  Version                                                      Repository                                           Size
===============================================================================================================================================================================================================================================
Installing:
 openssh-server                                                   x86_64                                                7.4p1-16.el7                                                 base                                                458 k
Installing for dependencies:
 tcp_wrappers-libs                                                x86_64                                                7.6-77.el7                                                   base                                                 66 k

Transaction Summary
===============================================================================================================================================================================================================================================
Install  1 Package (+1 Dependent package)

Total download size: 525 k
Installed size: 1.1 M
Is this ok [y/d/N]: y
Downloading packages:
(1/2): openssh-server-7.4p1-16.el7.x86_64.rpm                                                                                                                                                                           | 458 kB  00:00:00     
(2/2): tcp_wrappers-libs-7.6-77.el7.x86_64.rpm                                                                                                                                                                          |  66 kB  00:00:00     
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                                                                                                                          1.5 MB/s | 525 kB  00:00:00     
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : tcp_wrappers-libs-7.6-77.el7.x86_64                                                                                                                                                                                         1/2 
  Installing : openssh-server-7.4p1-16.el7.x86_64                                                                                                                                                                                          2/2 
  Verifying  : tcp_wrappers-libs-7.6-77.el7.x86_64                                                                                                                                                                                         1/2 
  Verifying  : openssh-server-7.4p1-16.el7.x86_64                                                                                                                                                                                          2/2 

Installed:
  openssh-server.x86_64 0:7.4p1-16.el7                                                                                                                                                                                                         

Dependency Installed:
  tcp_wrappers-libs.x86_64 0:7.6-77.el7                                                                                                                                                                                                        

Complete!
# password root

```

and then we can access container from host via ssh

```sh
[jenningsl@workstation ~]$ ssh 192.168.3.77 -l root
Failed to add the host to the list of known hosts (/home/jenningsl/.ssh/known_hosts).
[root@container1 ~]# 
[root@container1 ~]# 
[root@container1 ~]# 
[root@container1 ~]# logout
Connection to 192.168.3.77 closed.
```