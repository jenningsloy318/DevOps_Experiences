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

# Configuration

- [1. Install package](#1-install-package)
- [2. Install freeipa](#2-install-freeipa)
- [3. Check ldap users](#3-check-ldap-users)
- [4. Configure freeradius](#4-configure-freeradius)
- [5. Configure firewalld](#5-configure-firewalld)
- [6. Add test user in Freeipa](#6-add-test-user-in-freeipa)
- [7. Test with otp login to freeipa portal](#7-test-with-otp-login-to-freeipa-portal)
- [8. Test user with radius](#7-test-user-with-radius)

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

## 6. Add test user in Freeipa 

## 7. Test with otp login to freeipa portal 

## 8. Test user with radius 
  ```
    radtest jenningsl Jennings853800 10.36.47.230 1812 SapSecrts
    Sent Access-Request Id 204 from 0.0.0.0:51736 to 10.36.47.230:1812 length 79
      User-Name = "jenningsl"
      User-Password = "Jennings853800"
      NAS-IP-Address = 10.36.47.230
      NAS-Port = 1812
      Message-Authenticator = 0x00
      Cleartext-Password = "Jennings853800"
    Received Access-Accept Id 204 from 10.36.47.230:1812 to 0.0.0.0:0 length 20
  ```  