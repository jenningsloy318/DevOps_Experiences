#https://pagure.io/fedora-kickstarts, this is the modification of fedora-container-common.ks

bootloader --disabled
timesource   --ntp-disable
timezone --utc  Etc/UTC
rootpw --iscrypted $6$xKub1vpR0GWKjDZg$0eBJF789knwfLiVH0VPc20Th1APy/LSFiHLB1UtdBnADeGizzPO5iPCvJmj6e3QYFWo6PU0SGYP6ULf7.6RKq.
user --name fedora --password $6$xKub1vpR0GWKjDZg$0eBJF789knwfLiVH0VPc20Th1APy/LSFiHLB1UtdBnADeGizzPO5iPCvJmj6e3QYFWo6PU0SGYP6ULf7.6RKq. --iscrypted --shell /bin/bash
url --url http://mirrors.ustc.edu.cn/fedora/releases/34/Everything/x86_64/os/
keyboard us
network --bootproto=dhcp --device=link --activate --onboot=on
reboot
# boot partitions are irrelevant as the final docker image is a tarball
zerombr
clearpart --all
autopart --noboot --nohome --noswap --nolvm
%packages --excludedocs --instLangs=en --nocore --exclude-weakdeps
rootfiles
fedora-repos-modular
dnf
dnf-yum
sudo
-glibc-langpack-en
-langpacks-en
fedora-release-container
bash
coreutils
glibc-minimal-langpack
rpm
shadow-utils
openssh-server
vim-enhanced
hostname
iproute
git
sssd-client
-open-vm-tools
util-linux
procps-ng
vte-profile
iputils
-kernel
-dosfstools
-e2fsprogs
-fuse-libs
-gnupg2-smime
-libss # used by e2fsprogs
-pinentry
-shared-mime-info
-trousers
-xkeyboard-config
-grubby
%end
%post --erroronfail --log=/root/anaconda-post.log
set -eux
# Set install langs macro so that new rpms that get installed will
# only install langs that we limit it to.
LANG="en_US"
echo "%_install_langs $LANG" > /etc/rpm/macros.image-language-conf
# https://bugzilla.redhat.com/show_bug.cgi?id=1727489
echo 'LANG="C.UTF-8"' >  /etc/locale.conf
# https://bugzilla.redhat.com/show_bug.cgi?id=1400682
echo "Import RPM GPG key"
releasever=$(rpm --eval '%{fedora}')
rm -rf /var/cache/dnf/* /tmp/*  /var/cache/* /var/log/* /var/tmp/*
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-primary
/usr/bin/ssh-keygen -A
echo "# fstab intentionally empty for containers" > /etc/fstab
# add user fedora sudo privileges
echo "fedora  ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
# Remove machine-id on pre generated images
rm -f /etc/machine-id
touch /etc/machine-id
%end