# https://gitlab.com/redhat/centos-stream/release-engineering/kickstarts, use CentOS-Stream-9-container-common.ks
bootloader --disabled
timezone --isUtc --nontp Etc/UTC
rootpw --iscrypted $6$xKub1vpR0GWKjDZg$0eBJF789knwfLiVH0VPc20Th1APy/LSFiHLB1UtdBnADeGizzPO5iPCvJmj6e3QYFWo6PU0SGYP6ULf7.6RKq.
user --name centos --password $6$xKub1vpR0GWKjDZg$0eBJF789knwfLiVH0VPc20Th1APy/LSFiHLB1UtdBnADeGizzPO5iPCvJmj6e3QYFWo6PU0SGYP6ULf7.6RKq. --iscrypted --shell /bin/bash
url --url  https://odcs.stream.centos.org/production/latest-CentOS-Stream/compose/BaseOS/x86_64/os/
repo --name=appstream --baseurl=https://odcs.stream.centos.org/production/latest-CentOS-Stream/compose/AppStream/x86_64/os/
keyboard us
network --bootproto=dhcp --device=link --activate --onboot=on
reboot

# boot partitions are irrelevant as the final container image is a tarball
zerombr
clearpart --all
autopart --noboot --nohome --noswap --nolvm

%packages --excludedocs --instLangs=en --nocore
redhat-release
bash
rootfiles
vte-profile
coreutils-single
glibc-minimal-langpack
crypto-policies-scripts
-kernel
-dosfstools
-e2fsprogs
vim-enhanced
rpm
git
openssh-server
iproute
iputils
procps-ng
sudo
-fuse-libs
-gnupg2-smime
-libss 
-pinentry
-shared-mime-info
-trousers
-xkeyboard-config
-xfsprogs
-qemu-guest-agent
-shared-mime-info
-grubby
-open-vm-tools
%end

%post --erroronfail --log=/root/anaconda-post.log
set -eux

# Support for subscription-manager secrets
ln -s /run/secrets/etc-pki-entitlement /etc/pki/entitlement-host
ln -s /run/secrets/rhsm /etc/rhsm-host

#https://bugzilla.redhat.com/show_bug.cgi?id=1201663
rm -f /etc/systemd/system/multi-user.target.wants/rhsmcertd.service

#fips mode
# secrets patch creates /run/secrets/system-fips if /etc/system-fips exists on the host
#in turn, openssl in the container checks /etc/system-fips but dangling symlink counts as nonexistent
ln -s /run/secrets/system-fips /etc/system-fips

# Set install langs macro so that new rpms that get installed will
# only install langs that we limit it to.
LANG="C.utf8"
echo "%_install_langs $LANG" > /etc/rpm/macros.image-language-conf
echo "LANG=C.utf8" > /etc/locale.conf

# https://bugzilla.redhat.com/show_bug.cgi?id=1400682
# https://bugzilla.redhat.com/show_bug.cgi?id=1672230
## CS TODO - Import GPG keys when we have them
#echo "Import RPM GPG key"
#rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-centos-stream-release

echo "# fstab intentionally empty for containers" > /etc/fstab
#this is not possible, guestmount needs fstab => brew build crashes without it
#fstab is removed in TDL when tar-ing files
/usr/bin/ssh-keygen -A
echo "centos  ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Remove network configuration files leftover from anaconda installation
# https://bugzilla.redhat.com/show_bug.cgi?id=1713089
rm -f /etc/sysconfig/network-scripts/ifcfg-*
rm -rf /var/cache/* /var/tmp/* /tmp/* /var/log/*
# Remove machine-id on pre generated images
rm -f /etc/machine-id
touch /etc/machine-id

%end