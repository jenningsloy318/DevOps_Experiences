## Configure XRDP for mate-desktop 
1. install package 
```
apt install xrdp xorgxrdp -y
 
```
or 
```
yum install xorgxrdp.x86_64 xrdp.x86_64
 ```
2. create new startmate.sh on mate environment 
```
cat >> /usr/libexec/xrdp/startmate.sh << EOF
#!/bin/sh
export XDG_CURRENT_DESKTOP=MATE
exec /usr/libexec/xrdp/startwm.sh
EOF
chmod a+x /etc/xrdp/startmate.sh
```


or on other desktop environment
```
cat >> /usr/libexec/xrdp/startgnome.sh  << EOF
#!/bin/sh
export XDG_CURRENT_DESKTOP=GNOME
exec /usr/libexec/xrdp/startwm.sh
EOF

chmod a+x /usr/libexec/xrdp/startgnome.sh
```

modify startwm-bash.sh
```
sed -i -e '2a export XDG_CURRENT_DESKTOP=MATE' /usr/libexec/xrdp/startwm-bash.sh 
```
or
```
sed -i -e '2a export XDG_CURRENT_DESKTOP=GNOME' /usr/libexec/xrdp/startwm-bash.sh 
```
3. modify config 

```
sed -i 's/^TerminalServerUsers/#TerminalServerUsers/g' /etc/xrdp/sesman.ini
sed -i 's/^TerminalServerAdmins/#TerminalServerAdmins/g' /etc/xrdp/sesman.ini
sed -i -e 's/KillDisconnected=false/KillDisconnected=true/g' /etc/xrdp/sesman.ini
sed -i_orig -e 's/allowed_users=console/allowed_users=anybody/g' /etc/X11/Xwrapper.config
echo allowed_users=anybody >>/etc/X11/Xwrapper.config
sed -i_orig -e 's/crypt_level=high/crypt_level=none/g' /etc/xrdp/xrdp.ini
sed -i_orig -e 's/security_layer=negotiate/security_layer=rdp/g' /etc/xrdp/xrdp.ini
```
on mate, modify default UserWindowManager 
```
sed -i_orig -e 's/startwm.sh/startmate.sh/g' /etc/xrdp/sesman.ini
```
on gnome, modify default UserWindowManager 
```
sed -i_orig -e 's/startwm.sh/startgnome.sh/g' /etc/xrdp/sesman.ini
```
4  create ~/.Xclients if on Centos/rhel
```
$ echo "mate-session" > ~/.Xclients
$ chmod a+x ~/.Xclients
```

4. reboot the system 
