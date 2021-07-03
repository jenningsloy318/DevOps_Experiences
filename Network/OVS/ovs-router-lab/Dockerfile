FROM scratch
LABEL maintainer="Jennings Liu <jenningsloy318@gmail.com>"
#https://github.com/fedora-cloud/docker-brew-fedora
ADD fedora-34.20210514-x86_64.tar.xz / 
RUN dnf install -y vim vte-profile procps-ng shadow-utils iputils iproute openssh-server  && rm -rf /var/cache/dnf/* /tmp/*  /var/cache/* /var/log/* && useradd -m -d /home/centos -s /bin/bash centos && echo "centos:centos"  | chpasswd && echo "root:centos" | chpasswd && /usr/bin/ssh-keygen -A
EXPOSE 2222
CMD ["/usr/sbin/sshd","-D","-p 2222"]