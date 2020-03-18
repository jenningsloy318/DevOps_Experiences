## Configure XRDP for mate-desktop 
1. install package 
```
apt install xrdp xorgxrdp -y
 
```
or 
```
yum install xorgxrdp.x86_64 xrdp.x86_64
 ```
2. create new startubuntu.sh on ubuntu 
```
if [ ! -e /etc/xrdp/startubuntu.sh ] ; then
cat >> /etc/xrdp/startubuntu.sh << EOF
#!/bin/sh
export XDG_CURRENT_DESKTOP=MATE
exec /etc/xrdp/startwm.sh
EOF
chmod a+x /etc/xrdp/startubuntu.sh
fi
```

3. modify config 

```
sed -i 's/^TerminalServerUsers/#TerminalServerUsers/g' /etc/xrdp/sesman.ini
sed -i 's/^TerminalServerAdmins/#TerminalServerAdmins/g' /etc/xrdp/sesman.ini
sed -i_orig -e 's/allowed_users=console/allowed_users=anybody/g' /etc/X11/Xwrapper.config
echo allowed_users=anybody >>/etc/X11/Xwrapper.config
```
on ubuntu, add startububtu.sh 
```
sed -i_orig -e 's/startwm/startubuntu/g' /etc/xrdp/sesman.ini
```
4  create ~/.Xclients if on Centos/rhel
```
$ echo "mate-session" > ~/.Xclients
$ chmod a+x ~/.Xclients
```

4. reboot the system 
