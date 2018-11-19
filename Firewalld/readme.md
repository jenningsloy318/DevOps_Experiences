
1. define service in firewalld
```
firewall-cmd --permanent --new-service=jenkins
firewall-cmd --permanent --service=jenkins --set-short="Jenkins Service Ports"
firewall-cmd --permanent --service=jenkins --set-description="Jenkins service firewalld port exceptions"
firewall-cmd --permanent --service=jenkins --add-port=8080/tcp
firewall-cmd --permanent --add-service=jenkins
```

2. add service in zone
```
firewall-cmd --zone=public --add-service=http --permanent
```

3. add a port directly 

```
firewall-cmd --zone=public --add-port=9093/tcp --permanent
```


4. reload the firewll to take effect

```
firewall-cmd --reload
```