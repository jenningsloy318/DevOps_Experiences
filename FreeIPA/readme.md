Install freeipa and integrated with freeradius
---
# Prepration: 
| Type   | hostname                                | IP Address   |
|--------|-----------------------------------------|--------------|
| Server |  dc1-oob-vm-freeipa-prod01.hqxywl.com   | 10.36.47.230 |
| Server |  dc1-oob-vm-freeipa-prod02.hqxywl.com   | 10.36.47.231 |
| Client |  dc1-oob-vm-ipaclient-prod01.hqxywl.com | 10.36.47.232 
| domain |  hqxywl.com |-|
| Realm  |  HQXYWL.COM |-|
| OS     | CentOS Linux release 7.6.1810 (Core) |-|
| FreeIPA|ipa-server-4.6.4-10.el7.centos.2.x86_64|-|

At this stage, 

# Configuration

- [1. Install package](#1-install-package)
- [2. Install freeipa](#2-install-freeipa)
- [3. Check ldap users](#3-check-ldap-users)
- [4. Configure freeradius](#4-configure-freeradius)
- [5. Configure firewalld](#5-configure-firewalld)
- [6. Add test user in Freeipa](#6-add-test-user-in-freeipa)
- [7. Test with otp login to freeipa portal](#7-test-with-otp-login-to-freeipa-portal)
- [8. Test user with radius](#7-test-user-with-radius)
- [9. Create sudo rule and add user to this sudo rule](#9-create-sudo-rule-and-add-user-to-this-sudo-rule)
- [10. Configure ipa-client on client server](#10-configure-ipa-client-on-client-server)
- [11. Test user login and sudo switch to root on client server](#11-test-user-login-and-sudo-switch-to-root-on-client-server)
## 1. Install package
```sh
yum install -y ipa-server bind bind-dyndb-ldap ipa-server-dns
```
## 2. Install FreeIPA
**Make sure password don't contain special character**
```sh
# ipa-server-install -a Devops2019  -p Devops2019 -r HQXYWL.COM  --setup-dns --allow-zone-overlap  --no-reverse  --no-host-dns --forwarder 114.114.114.114 --forwarder 223.5.5.5 --forwarder 119.29.29.29 --unattended
```
![](./images/concifgure-freeipa.gif)


## 3. Check LDAP Users

to find out the the default base_dn used in `radius`, which is `cn=users,cn=accounts,dc=hqxywl,dc=com`
```sh
ldapsearch -x -v -W -D 'cn=Directory Manager'  uid=admin
```
![](./images/ldap-users.gif)


## 4. Configure FreeRadius
- install radius 
```sh
# yum install freeradius freeradius-utils freeradius-ldap freeradius-krb5
```
- Edit /etc/raddb/clients.conf,modified following items:
    - ipaddr 
    - secret

  Full contenf of `/etc/raddb/clients.conf`
    ```conf
    client localhost {
      ipaddr = 10.36.0.0/16
      proto = *
      secret = SapSecrts
      require_message_authenticator = no
      limit {
        max_connections = 16
        lifetime = 0
        idle_timeout = 30
      }
    }
    ...
    ```

    Edit  /etc/raddb/mods-enabled/ldap
    only modified 
    - server
    - identity
    - password
    - base_dn

    Full content of /etc/raddb/mods-enabled/ldap
    ```conf
    ldap {
      server = '10.36.47.230'
      identity = 'cn=Directory Manager'
      password = 'Devops2019'
      base_dn = 'cn=users,cn=accounts,dc=hqxywl,dc=com'
      sasl {
      }
    ...
    ```

- Edit /etc/raddb/sites-enabled/default, modify following items
  
  - replace  
    ```conf
    -ldap
    ```
      
     with 

    ```conf
    ldap
          if ((ok || updated) && User-Password) {
              update {
                  control:Auth-Type := ldap
              }
          }
    ```
  - umcomment
      ```conf
      #  Auth-Type LDAP {
      #    ldap
      #  }
      ```
      to

      ```conf
        Auth-Type LDAP {
          ldap
        }    
      ```


- Edit /etc/raddb/sites-enabled/inner-tunnel, modify following items

    - replace 
      ```
      -ldap
      ```
      with 
      ```
      ldap
            if ((ok || updated) && User-Password) {
                update {
                    control:Auth-Type := ldap
                }
            }
      ```
    - umcomment
      ```
      #Auth-Type LDAP {
      #  ldap
      #}
      ```
      to 
      ```
      Auth-Type LDAP {
        ldap
      }
     ```     


## 5 Configure firewalld 
  ```
  firewall-cmd --add-service=http --permanent
  firewall-cmd --add-service=https --permanent
  firewall-cmd --add-service=ldap --permanent
  firewall-cmd --add-service=ldaps --permanent
  firewall-cmd --add-service=dns --permanent
  firewall-cmd --add-servicekerberos --permanent
  firewall-cmd --add-service=kerberos --permanent
  firewall-cmd --add-service=ntp --permanent
  firewall-cmd --permanent --zone=public --add-port=1812/udp --add-port=1813/udp
  firewall-cmd --reload
  ```

## 6. Add test user in FreeIPA 
  We can add user in ipa web portal or add it via command line
  also we can add OTP(2FA) to this user

  ```sh
  ipa user-add --first=Jennings --last=Liu --shell=/bin/bash   --sshpubkey=<Public key string> --password jenningsl
  Password: 
  Enter Password again to verify: 
  -------------------
  Added user "jenningsl"
  -------------------
    User login: jenningsl
    First name: jennings
    Last name: liu
    Home directory: /home/jenningsl
    Login shell: /bin/bash
    Principal name: jenningsl@HQXYWL.COM
    Principal alias: jenningsl@HQXYWL.COM
    Email address: jennings.liu@sap.com
    UID: 352200001
    GID: 352200001
    SSH public key fingerprint: SHA256:9kX8nRmXzq7dc5ckwStN78i4RORoeBtLoASr+Ky1TMw jenningsl@workstation.lmy.com (ssh-rsa)
    Account disabled: False
    Password: True
    Member of groups: ipausers
    Member of Sudo rule: admin
    Kerberos keys available: True
  ```

  then we can initialize a login, add will ask you to reset password as first login. after first login we can add otp to this user

  Step 1:
  ![](./images/OTP1.png)

  Step 2:
  ![](./images/OTP2.png)


  Step 3:
  ![](./images/OTP3.png)

  then you can use mobile APP `Google Authenticator` or `FreeOTP` to scan this QR
## 7. Test with otp login to freeipa portal, use password+OTP key to login

![](./images/user-login-ipa-portal.png)


## 8. Test user with radius 
  ```shell
  # radtest jenningsl Jennings853800 10.36.47.230 1812 SapSecrts
    Sent Access-Request Id 204 from 0.0.0.0:51736 to 10.36.47.230:1812 length 79
      User-Name = "jenningsl"
      User-Password = "Jennings853800"
      NAS-IP-Address = 10.36.47.230
      NAS-Port = 1812
      Message-Authenticator = 0x00
      Cleartext-Password = "Jennings853800"
    Received Access-Accept Id 204 from 10.36.47.230:1812 to 0.0.0.0:0 length 20
  ```  

## 9. Create sudo rule and add user to this sudo rule 
  ```shell
  # ipa sudorule-add --cmdcat=all --hostcat=all --runasusercat=all --runasgroupcat=all admin
  # ipa sudorule-add-user --users=jenningsl admin
  ```

## 10. Configure ipa-client on client server 

  ```sh
  # yum install -y ipa-client
  # ipa-client-install --domain=hqxywl.com --realm=HQXYWL.COM --server=dc1-oob-vm-freeipa-prod01.hqxywl.com  --mkhomedir -U
  ```
  > shoud modiy /etc/resolv.conf to set `10.36.47.230` as the first dns server
  
   if user home is not automatically created, excute following command to update 
  ```sh
  # authconfig --update --enablemkhomedir
  ```
## 11. Test user login and sudo switch to root on client server
```sh
[jenningsl@workstation Desktop]$ ssh 10.36.47.232
Creating home directory for jenningsl.
Last failed login: Thu Mar 14 21:55:58 CST 2019 from 10.36.52.232 on ssh:notty
There was 1 failed login attempt since the last successful login.
[jenningsl@dc1-oob-vm-freeipa-client-prod01 ~]$ pwd
/home/jenningsl
[jenningsl@dc1-oob-vm-freeipa-client-prod01 ~]$ id
uid=352200001(jenningsl) gid=352200001(jenningsl) groups=352200001(jenningsl)
[jenningsl@dc1-oob-vm-freeipa-client-prod01 ~]$ sudo -i

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

First Factor: 
Second Factor: 
[root@dc1-oob-vm-freeipa-client-prod01 ~]# 
```