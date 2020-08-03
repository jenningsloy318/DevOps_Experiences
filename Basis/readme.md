1. [How To Set Password Policies In Linux](https://www.ostechnix.com/how-to-set-password-policies-in-linux/)

2. create encrypt password aka hash which can be used in  /etc/shadow
    2.1 use perl 
    ```
    export salt=$(openssl rand 1000 | strings | grep -io [0-9A-Za-z\.\/] |  head -n 16 | tr -d '\n' )
    export password=password
    echo $(perl -e 'print crypt("$ENV{'password'}","\$6\$"."$ENV{'salt'}"."\$")'
    ```
    or 
    ```
    perl -e 'print crypt("password","\$6\$saltsalt\$") . "\n"'
    ```

    2.2 use python 

    ```
    python -c 'import crypt; print crypt.crypt("password", "$6$saltsalt$")'
    ```
    or ptyon 3.3+ 
    ```
    python -c 'import crypt; print(crypt.crypt('password', crypt.mksalt(crypt.METHOD_SHA512)))'
    ```
3. repo repos https://developer.aliyun.com/mirror
    - kubernetes.repo
    ```conf
    [kubernetes]
    name=Kubernetes
    baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
    enabled=1
    gpgcheck=1
    repo_gpgcheck=1
    gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
    ```
    - https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
    - http://mirrors.aliyun.com/repo/epel-7.repo
    - http://mirrors.aliyun.com/repo/epel-8.repo

 3. minikube 
    - install docker engine
    - minikube start  --vm-driver=none --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers   
    
    reference:
    1. https://unix.stackexchange.com/questions/158400/etc-shadow-how-to-generate-6-s-encrypted-password
    2. https://www.linuxquestions.org/questions/linux-security-4/command-to-create-encrypted-password-265368/

4. rpm spec to build packages
    - install `rpmdevtools`, ans use `spectool -g -R vim.spec` to download the tarball file