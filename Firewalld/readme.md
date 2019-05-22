
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



5. configure Centos as a router
```
firewall-cmd --permanent --direct --passthrough ipv4 -t nat -I POSTROUTING -o ens224u2 -j MASQUERADE -s 192.168.2.0/24 
firewall-cmd --permanent --direct --passthrough ipv4 -t nat -I POSTROUTING -o ens224u2 -j MASQUERADE -s 192.168.1.0/24 
firewall-cmd --permanent --direct --passthrough ipv4 -t nat -I POSTROUTING -o ens224u2 -j MASQUERADE -s 10.36.0.0/16 

firewall-cmd --change-interface=ens224u2 --zone=external --permanent

firewall-cmd --set-default-zone=internal 

firewall-cmd --complete-reload
```


5. add forward port 
```
firewall-cmd  --add-masquerade --permanent
firewall-cmd --permanent --add-forward-port=port=41443:proto=tcp:toaddr=10.36.51.141:toport=443
firewall-cmd --permanent --add-forward-port=port=42443:proto=tcp:toaddr=10.36.51.142:toport=443
firewall-cmd --permanent --add-forward-port=port=11443:proto=tcp:toaddr=10.36.51.11:toport=443
firewall-cmd --add-port={41443/tcp,42443/tcp,11443/tcp} --permanent
```