sysctl -w vm.swappiness=1
echo vm.swappiness=1 >> /etc/sysctl.conf

sysctl -w vm.max_map_count=3000000
echo vm.max_map_count=3000000 >> /etc/sysctl.conf


sysctl -w fs.file-max=3000000
echo fs.file-max=3000000 >> /etc/sysctl.conf
sysctl -w fs.nr_open=3000000
echo  fs.nr_open=3000000  >>/etc/sysctl.conf


