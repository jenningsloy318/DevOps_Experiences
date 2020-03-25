Install freeipa and integrated with freeradius
---
# Prepration: 
| Type   | hostname                                | IP Address   |
|--------|-----------------------------------------|--------------|
| Server | dc1-vm-freeipa-prod01.inb.hqxywl.com  |10.36.52.172 |
| Server | dc1-vm-freeipa-prod02.inb.hqxywl.com  | 10.36.52.173|
| domain |  inb.hqxywl.com |-|
| Realm  |  INB.HQXYWL.COM |-|
| OS     | CentOS Linux release 7.6.1810 (Core) |-|
| FreeIPA|ipa-server-4.6.4-10.el7.centos.2.x86_64|-|

At this stage, 

# Configuration

- [1. Install package](#1-install-package)
- [2. Configure freeipa](#2-configure-freeipa)
- [3. Check ldap users](#3-check-ldap-users)
- [4. Configure freeradius](#4-configure-freeradius)
- [5. Configure firewalld](#5-configure-firewalld)
- [6. Add test user in Freeipa](#6-add-test-user-in-freeipa)
- [7. Test with otp login to freeipa portal](#7-test-with-otp-login-to-freeipa-portal)
- [8. Test user with radius](#7-test-user-with-radius)
- [9. Create sudo rule and add user to this sudo rule](#9-create-sudo-rule-and-add-user-to-this-sudo-rule)
- [10. Create hostenrolluser used for adding host into ipa servrer](#10-create-hostenrolluser-used-for-adding-host-into-ipa-servrer)
- [11. Configure ipa-client on client server](#11-configure-ipa-client-on-client-server)
- [12. Test user login and sudo switch to root on client server](#12-test-user-login-and-sudo-switch-to-root-on-client-server)
- [13. Integrated with PaloAlto Firewall via freeradius ](#13-integrated-with-paloalto-firewall-via-freeradius)
- [14. Integrated with F5 via freeradius ](#14-integrate-with-f5-via-freeradius)
- [15. Integrate with Cisco Switch via freeradius ](#15-integrate-with-cisco-switch-via-freeradius)
- [16. Integrate with Cisco ASA VPN via freeradius ](#16-integrate-with-cisco-asa-vpn-via-freeradius)
- [17. Integrate with grafana via ldap ](#17-integrate-with-grafana-via-ldap)
- [18. Integrate with kibana via ldap ](#18-integrate-with-kibana-via-ldap)
- [19. administration via api](#19-administration-via-api)
## 1. Install package
install packages on both master and replica nodes
- disable selinux
  - rhel7/centos7
    ```
    sed -i  '/SELINUX/s/enforcing/disabled/g' /etc/sysconfig/selinux
    ```
  - rhel8/centos8 
    ```
    sed -i  '/SELINUX/s/enforcing/disabled/g' /etc/selinux/config
    ```
- install packages on rhel7/centos7
  ```sh
  yum install -y ipa-server bind bind-dyndb-ldap ipa-server-dns
  ```
- install packages rhel8/centos8, FreeIPA Server and client packages are distributed through AppStream repository in RHEL / CentOS 8. 

  ```
  dnf module list idm
  dnf module info idm:DL1
  dnf -y install @idm:DL1 install freeipa-server ipa-server-dns bind-dyndb-ldap
  ```
## 2. Configure FreeIPA
- install Master node 
  
  **Make sure password don't contain any special characters**
  ```sh
  #ipa-server-install -a Devops2019  -p Devops2019 -r INB.HQXYWL.COM -n inb.hqxywl.com  --setup-dns --allow-zone-overlap  --reverse-zone=36.10.in-addr.arpa. --no-host-dns --forwarder 114.114.114.114 --forwarder 223.5.5.5 --forwarder 119.29.29.29 --mkhomedir -U 

  ```
- install replica
  - Update /etc/resolv.conf, add 10.36.52.172 as the first DNS server. 
  - configure firewalld rules
    ```
    #firewall-cmd --add-service=http   --add-service=https --add-service=ldap --add-service=ldaps --add-service=dns  --add-service=kerberos --add-service=kpasswd --add-service=ntp    --add-service=radius   --permanent 
    # firewall-cmd --reload
    ```
  - Configure replica and ca on this slave 
    ```

    # ipa-replica-install  -w Devops2019 -U --mkhomedir   --setup-ca   --setup-dns --allow-zone-overlap  --reverse-zone=36.10.in-addr.arpa.  --forwarder 114.114.114.114 --forwarder 223.5.5.5 --forwarder 119.29.29.29 --force-join
    ```

    if install failed, we need to remove this repica on the master node via 
    ```
    ipa-replica-manage del dc1-vm-freeipa-prod02.inb.hqxywl.com --force
    ```


- Enable DNS PTR update 
```
# ipa dnszone-mod inb.hqxywl.com. --allow-sync-ptr=TRUE
# ipa dnsconfig-mod --allow-sync-ptr=TRUE
```
  > link： https://docs.pagure.org/bind-dyndb-ldap/BIND9/SyncPTR.html

- Add/Modify DNS records 
  - add second DNS zone 
  ```
  ipa dnszone-add oob.hqxywl.com
  ```
  - add record 
  ```
  ipa dnsrecord-add  inb.hqxywl.com www --a-rec 10.1.1.1  --a-create-reverse
  ipa dnsrecord-add  oob.hqxywl.com dc1-oob-vm-ipa-prod01 --a-rec 10.36.47.218 --a-create-reverse
  ```
  - modify record
  ```
  ipa dnsrecord-mod inb.hqxywl.com www --a-rec 10.1.1.1 
  ```
## 3. Check LDAP Users

to find out the the default base_dn used in `radius`, which is `cn=users,cn=accounts,dc=inb,dc=hqxywl,dc=com`
```sh
ldapsearch -x -v -W -D 'cn=Directory Manager'  uid=admin
```



## 4. Configure FreeRadius
### 4.1  install radius packages
```sh
# yum install -y freeradius freeradius-utils freeradius-ldap freeradius-krb5
```

### 4.2  add radius service into freeipa
```
ipa service-add radius/dc1-vm-freeipa-prod01.inb.hqxywl.com
```
### 4.3  retrieve keytab for radius service from freeipa 
  ```
  ipa-getkeytab -p radius/dc1-vm-freeipa-prod01.inb.hqxywl.com@INB.HQXYWL.COM -k /etc/raddb/radiusd.keytab
  chown -R radiusd.radiusd /etc/raddb/radiusd.keytab
  ```

### 4.4 create certificates  for radius into freeipa
  ```
  # mv /etc/raddb/certs /etc/raddb/certs.bak
  # mkdir /etc/raddb/certs
  # ipa-getcert request -w -k /etc/raddb/certs/server.key -f /etc/raddb/certs/server.pem -T caIPAserviceCert -C 'systemctl restart radiusd.service' -N dc1-vm-freeipa-prod01.inb.hqxywl.com -D dc1-vm-freeipa-prod01.inb.hqxywl.com -K radius/dc1-vm-freeipa-prod01.inb.hqxywl.com
  # cp /etc/ipa/ca.crt /etc/raddb/certs/cacert.pem
  # cp /etc/ipa/ca.crt /etc/raddb/certs/ca.pem
  # openssl dhparam 2048 -out /etc/raddb/certs/dh
  # chown -R root:radiusd /etc/raddb/certs/*
  ```

### 4.5 configure radius clients, edit /etc/raddb/clients.conf,modified following items:

  - ipaddr 
  - secret

  Full contenf of `/etc/raddb/clients.conf`   
  ```conf
  client localnet {
    ipaddr = 10.36.0.0/16
    proto = *
    secret = SapSecrets2019
    require_message_authenticator = no
    nas_type         = other
    limit {
      max_connections = 16
      lifetime = 0
      idle_timeout = 30
    }
  }
  ...
  ```
### 4.6 configure  `ldap` module, edit `/etc/raddb/mods-enabled/ldap`, only modified 
  - server
  - identity
  - base_dn
  - sasl
  - tls

But first create user and permissions

  - Create ralative permision and roles 
    ```sh
    ipa permission-add 'Modify User Description'  --attrs=description  --right=write --subtree="cn=users,cn=accounts,dc=oob,dc=hqxywl,dc=com"
    ipa permission-add 'Read User Password'  --attrs=userPassword  --right=read --subtree="cn=users,cn=accounts,dc=oob,dc=hqxywl,dc=com"
    ipa privilege-add 'Radius services' --desc='Privileges needed to allow radiusd servers to operate'
    ipa privilege-add-permission 'Radius services' --permissions='Modify User Description'
    ipa privilege-add-permission 'Radius services' --permissions='Read User Password'
    ipa role-add 'Radius server' --desc="Radius server role"
    ipa role-add-privilege --privileges="Radius services" 'Radius server'
    ```
  - add service `radius/ipa.myexample.com@MYEXAMPLE.COM` to role `Radius server` so that `radius` can `Modify User Description` in ldap
    ```
    ipa role-add-member  --services=radius/dc1-vm-freeipa-prod01.inb.hqxywl.com@INB.HQXYWL.COM 'Radius server'
      Role name: Radius server
      Description: Radius server role
      Privileges: Radius services
      Member services: radius/ipa.myexample.com@INB.HQXYWL.COM
    -------------------------
    Number of members added 1
    -------------------------
    ```
  - create radius system user, and add it to role `Radius server` so that it can  `Modify User Description` in ldap
    ```sh
    #cat radius.update
    dn: uid=radius,cn=sysaccounts,cn=etc,dc=inb,dc=hqxywl,dc=com
    add:objectclass:account
    add:objectclass:simplesecurityobject
    add:uid:radius
    add:userPassword:RadiusPass
    add:passwordExpirationTime:20380119031407Z
    add:nsIdleTimeout:0
    # ipa-ldap-updater radius.update
    ```
  - update role to include this user  as a member
    ```
    # cat  radius-server-role.update
    dn: cn=Radius server,cn=roles,cn=accounts,dc=oob,dc=hqxywl,dc=com
    add:member: uid=radius,cn=sysaccounts,cn=etc,dc=oob,dc=hqxywl,dc=com
    # ipa-ldap-updater radius-server-role.update
    ``` 

  - configure rlm_ldap in /etc/raddb/mods-enabled/ldap, we have two options:
    - user user/name to bind
      ```conf
      ldap {
        server = 'ldaps://dc1-vm-freeipa-prod01.inb.hqxywl.com'
        server = 'ldaps://dc1-vm-freeipa-prod01.inb.hqxywl.com'
        base_dn = 'cn=users,cn=accounts,dc=inb,dc=hqxywl,dc=com'
        identity = 'uid=radius,cn=sysaccounts,cn=etc,dc=oob,dc=hqxywl,dc=com'
        password = 'RadiusPass'
        
        tls {

          ca_file = /etc/raddb/certs/ca.pem
          certificate_file = /etc/raddb/certs/server.pem
          private_key_file = /etc/raddb/certs/server.key
        }      
      ...
      }
      ```
    - user SASL certificate file(SASL + KRB5) to bind 
      ```conf
      ldap {
        server = 'ldaps://dc1-vm-freeipa-prod01.inb.hqxywl.com'
        server = 'ldaps://dc1-vm-freeipa-prod01.inb.hqxywl.com'
        base_dn = 'cn=users,cn=accounts,dc=inb,dc=hqxywl,dc=com'
        
        sasl {
                # SASL mechanism
                mech = 'GSSAPI'
                # SASL authorisation identity to proxy.
                #proxy = 'autz_id'
                # SASL realm. Used for kerberos.
                realm = 'INB.HQXYWL.COM'
        }      
        tls {

          ca_file = /etc/raddb/certs/ca.pem
          certificate_file = /etc/raddb/certs/server.pem
          private_key_file = /etc/raddb/certs/server.key
        }      
      ...
      }
      ```
    - (optional) if use SASL certificate(SASL + KRB5) bind, we also need to configure `/etc/raddb/mods-enabled/krb5`
      ```
      krb5 {
              keytab = /etc/raddb/radiusd.keytab
              service_principal =  radius/dc1-vm-freeipa-prod01.inb.hqxywl.com@INB.HQXYWL.COM
              pool {
                ...
              }
      }
      ```

### 4.7 configure module `eap`, edit `/etc/raddb/mods-enabled/eap`, setting following certificates and keys 
  ```
  ....
      tls-config tls-common {
      ....
      private_key_file = ${certdir}/server.key
      certificate_file = ${certdir}/server.pem
      ca_file = ${cadir}/ca.pem
      ....
      }
  ...
  ```
### 4.8 Configure site, edit `/etc/raddb/sites-enabled/default`, modify following items
  - authorize
  - authenticate
  - post-auth

    - in section `authorize`, replace   
      ```conf
      authorize {
        ...
        -ldap
        ...
      }
      ```
        
      with 

      ```conf
      authorize {
        ...
        ldap
              if ((ok || updated) && User-Password) {
                  update {
                      control:Auth-Type := ldap
                  }
              }
        ...
      }
      ```
    - in section `authenticate`, umcomment
        ```conf
        authenticate {
          ...
          
          #  Auth-Type LDAP {
          #    ldap
          #  }
          ...
        }
        ```
        to

        ```conf
        authenticate {
          ...
          Auth-Type LDAP {
            ldap
          }    
          ...

        }
        ```


### 4.9 Configure site, edit /etc/raddb/sites-enabled/inner-tunnel, modify following items
  - authorize
  - authenticate
  - post-auth


    - in section `authorize`, replace 
      ```
      authorize {
        ...
        -ldap
        ...
      }
      ```
      with 
      ```
      authorize {
        ...
        ldap
              if ((ok || updated) && User-Password) {
                  update {
                      control:Auth-Type := ldap
                  }
              }
        ...
      }
      ```
    - in section `authenticate`, uncomment
      ```
      authenticate {
        ...
        #Auth-Type LDAP {
        #  ldap
        #}
        ...
      }
      ```
      to 
      ```
      Auth-Type LDAP {
        ldap
      }
     ```     
  > `post-auth` configure will be detailed described in [14.2.2](#14.2.2-configure-post-auth-for-vpn-in-freeradius) and [16.2](#16.2-configure-post-auth-for-vpn-in-freeradius) 


### 4.10 configure preprocess (optional)
Edit `/etc/raddb/mods-config/preprocess/hints` and/or  `/etc/raddb/mods-config/preprocess/huntgroups` to preprocess the request from clients, which will be process within   directive `preprocess` of section `authorize` in each site files

### 4.11 Notes on Freeradius attributes
  We can get all attributes for different devices from directories in  ` /usr/share/freeradius/`
- [Service-Type](https://www.gnu.org/software/radius/manual/html_node/radius_202.html)
  
  This attribute indicates the type of service the user has requested, or the type of service to be provided

  - Login-User: The user should be connected to a host.
  - Framed-User: A framed protocol, such as PPP or SLIP, should be started for the user. The Framed-IP-Address attribute will supply the IP to be used.
  - Callback-Login-User: The user should be disconnected and called back, then connected to a host.
  - Callback-Framed-User: The user should be disconnected and called back; then a framed protocol, such as PPP or SLIP, should be started for the user.
  - Outbound-User: The user should be granted access to outgoing devices. **This can be configured when integrated with VPN** 
  - Administrative-User: The user should be granted access to the administrative interface to the NAS, from which privileged commands can be executed.
  - NAS-Prompt: The user should be provided a command prompt on the NAS, from which nonprivileged commands can be executed.
  - Authenticate-Only: Only authentication is requested, and no authorization information needs to be returned in the Access-Accept.




## 5 Configure firewalld 
  ```
  firewall-cmd --add-service=http   --add-service=https --add-service=ldap --add-service=ldaps --add-service=dns  --add-service=kerberos --add-service=kpasswd --add-service=ntp    --add-service=radius   --permanent 
  firewall-cmd --reload
  ```

## 6. Add test user in FreeIPA 
  We can add user in ipa web portal or add it via command line, also we can add OTP(2FA) to this user

  ```sh
  ipa user-add  --setattr=description="new user" --first=Jennings --last=Liu --shell=/bin/bash   --sshpubkey=<Public key string> --password jenningsl
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
    Principal name: jenningsl@INB.HQXYWL.COM
    Principal alias: jenningsl@INB.HQXYWL.COM
    Email address: jennings.liu@sap.com
    UID: 352200001
    GID: 352200001
    SSH public key fingerprint: SHA256:9kX8nRmXzq7dc5ckwStN78i4RORoeBtLoASr+Ky1TMw jenningsl@workstation.lmy.com (ssh-rsa)
    Account disabled: False
    Password: True
    Member of groups: ipausers
    Member of Sudo rule: admin
    Kerberos keys available: True

    ip user-show --all jenningsl
    --------------
    1 user matched
    --------------
      User login: jenningsl
      First name: jennings
      Last name: liu
      Home directory: /home/jenningsl
      Login shell: /bin/bash
      Principal name: jenningsl@INB.HQXYWL.COM
      Principal alias: jenningsl@INB.HQXYWL.COM
      Email address: jennings.liu@sap.com
      UID: 352200001
      GID: 352200001
      SSH public key fingerprint: SHA256:9kX8nRmXzq7dc5ckwStN78i4RORoeBtLoASr+Ky1TMw jenningsl@workstation.lmy.com (ssh-rsa)
      Account disabled: False
      Password: True
      Member of groups: ipausers
      description: new user
      Member of Sudo rule: admin
      Kerberos keys available: True
  ```
  > when add a user, set an attribute `description="xxxx"`, this will add `description: xxxx` in its ldap attributes, this attribute can be updated by radius when integrade with radius for authentication
 
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
## 10. Create hostenrolluser used for adding host into ipa servrer 
```
# ipa user-add  --first=hostenrolluser --last=system  --homedir=/home/hostenrolluser  hostenrolluser
---------------------------
Added user "hostenrolluser"
---------------------------
  User login: hostenrolluser
  First name: hostenrolluser
  Last name: system
  Full name: hostenrolluser system
  Display name: hostenrolluser system
  Initials: hs
  Home directory: /home/hostenrolluser
  GECOS: hostenrolluser system
  Login shell: /bin/bash
  Principal name: hostenrolluser@INB.HQXYWL.COM
  Principal alias: hostenrolluser@INB.HQXYWL.COM
  Email address: hostenrolluser@sap.com
  UID: 352200011
  GID: 352200011
  Password: False
  Member of groups: ipausers
  Kerberos keys available: False
# ipa passwd hostenrolluser
New Password:
Enter New Password again to verify:
------------------------------------------------
Changed password for "hostenrolluser@HQXYWL.COM"
------------------------------------------------

# ipa role-add --desc="HostEnrollRole" HostEnrollRole
---------------------------
Added role "HostEnrollRole"
---------------------------
  Role name: HostEnrollRole
  Description: HostEnrollRole


# ipa role-add-member --users=hostenrolluser HostEnrollRole
  Role name: HostEnrollRole
  Description: HostEnrollRole
  Member users: hostenrolluser
-------------------------
Number of members added 1
-------------------------
#  ipa role-add-privilege  HostEnrollRole --privileges='Host Enrollment'
  Role name: HostEnrollRole
  Description: HostEnrollRole
  Member users: hostenrolluser
  Privileges: Host Enrollment
----------------------------
Number of privileges added 1
----------------------------


# ipa privilege-add-permission "Host Enrollment" --permissions="System: Add Hosts"
  Privilege name: Host Enrollment
  Description: Host Enrollment
  Permissions: System: Add Hosts, System: Add krbPrincipalName to a Host, System: Enroll a Host, System: Manage Host Certificates, System: Manage Host Enrollment Password, System: Manage
               Host Keytab, System: Manage Host Principals
  Granting privilege to roles: Enrollment Administrator, HostEnrollRole
-----------------------------
Number of permissions added 1
-----------------------------
```

## 11. Configure ipa-client on client server 

- RHEL
  ```sh
  # yum install -y ipa-client nscd nss-pam-ldapd
  # ipa-client-install --domain=inb.hqxywl.com --realm=INB.HQXYWL.COM --server=dc1-vm-freeipa-prod01.inb.hqxywl.com  --mkhomedir -p hostenrolluser -w password  -U

  ```
  > shoud modiy /etc/resolv.conf to set `10.36.52.172` as the first dns server
  
   if user home is not automatically created, excute following command to update 
  ```sh
  # authconfig --update --enablemkhomedir
  ```
- SLES
  
  For configure freeipa client on sles 12, refer to [SLES_IPAClient](SLES_IPAClient.md).
## 12. Test user login and sudo switch to root on client server
```sh
[jenningsl@workstation ]$ ssh 10.36.47.232
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

## 13. Integrated with PaloAlto Firewall via freeradius
PA info
| Type   | hostname                                | IP Address   |
|--------|-----------------------------------------|--------------|
| Model |	PA-3020|
| Software Version|	8.0.13|
| GlobalProtect Agent	|0.0.0|
| Application Version	|8134-5351 (03/14/19)|
| Threat Version	|8134-5351 (03/14/19)|
| Antivirus Version	|2924-3434 (03/21/19)|
| WildFire Version	|333381-336058 (03/22/19)|
| URL Filtering Version|	20190322.20092|


### 13.1 Create `Radius Server Profile`   
    
  ![](./images/freeradius-pa-1.jpg)




### 13.2 Create `Authentication Profile` which unitilize  newly created  `Radius Server Profile`   

  ![](./images/freeradius-pa-2.jpg)



### 13.3 Create Administrator mapping to newly created Ahtentication Profile 

  ![](./images/freeradius-pa-3.jpg)



then commit the changes to the firewall, now we can use the users defined in `FreeIPA` to logon PA.


## 14. Integrated with F5 via freeradius

### 14.1 To restrict the users that can administrate F5 devices, create groups in freeipa
```
# ipa group-add f5_admin   --nonposix
# ipa group-add ltm_admin   --nonposix
# ipa group-add waf_admin   --nonposix
# ipa group-add-member f5_admin --users=i336589

```
###  14.2 Configure post auth for F5 in freeradius
- modify `/etc/raddb/sites-enabled/default`, at  `post-auth` section, add following lines
```
  {
  ...

  post-auth {
  
  ....
        ldap
        if (( NAS-IP-Address == "10.36.48.13" ) || ( NAS-IP-Address == "10.36.48.14" ) || ( NAS-IP-Address == "10.36.48.21" ) || ( NAS-IP-Address == "10.36.48.22" ) ) {
              if ( !(LDAP-Group == "f5_admin") &&  !(LDAP-Group == "ltm_admin") && !(LDAP-Group == "waf_admin") ) {
                  reject
              }
           }
  ...
  }

  ...
  }
```



## 15. Integrate with Cisco Switch via freeradius

No special conf for switches on FreeIPA side, just defines the client in FreeRadius

## 16. Integrate with Cisco ASA VPN via freeradius
### 16.1 configure clients in freeradius
- add client conf for vpn, add following lines to `/etc/raddb/clients.conf`
  ```conf
  client vpn {
    ipaddr = 10.36.48.2
    proto = *
    secret = SapSecrets
    nas_type = cisco
    require_message_authenticator = no

  }

  ```
  > Cisco devices `nas_type` can be set to `cisco`, 
### 16.2 configure post auth for vpn  in freeradius  
  

- modify `/etc/raddb/sites-enabled/default`, at  `post-auth` section, add following lines
  ```conf
  {
  ...

  post-auth {
  
  ....

    ldap
    if (ASA-ClientType) {

              if (LDAP-Group == "jm_vpn" &&  ASA-TunnelGroupName =="JM_VPN" ) {
                  update reply {
                      Service-Type = "Outbound-User",
                      ASA-Group-Policy = "OU=JM_VPN"
                      }
              }
              elsif ( LDAP-Group == "oob_admin_vpn" &&  ASA-TunnelGroupName =="OOB_ADMIN_VPN" ) {
                  update reply {
                      Service-Type = "Outbound-User",
                      ASA-Group-Policy = "OU=OOB_ADMIN_VPN"
                      }
              }
              elsif ( LDAP-Group == "inb_admin_vpn" &&  ASA-TunnelGroupName =="INB_ADMIN_VPN" ) {
                  update reply {
                      Service-Type = "Outbound-User",
                      ASA-Group-Policy = "OU=INB_ADMIN_VPN"
                      }
              }
              elsif ( LDAP-Group == "inb_s1_dev_vpn" &&  ASA-TunnelGroupName =="INB_S1_DEV_VPN" ) {
                  update reply {
                      Service-Type = "Outbound-User",
                      ASA-Group-Policy = "OU=INB_S1_DEV_VPN"
                      }
              }
              elsif ( LDAP-Group == "inb_s1_qa_vpn" &&  ASA-TunnelGroupName =="INB_S1_QA_VPN" ) {
                  update reply {
                      Service-Type = "Outbound-User",
                      ASA-Group-Policy = "OU=INB_S1_QA_VPN"
                      }
              }                                                                                                         
            }

      
  ....
    }
  
  ...
  }
  ```
  > Notes:
  > 1. [Freeradius wiki page](http://wiki.freeradius.org/modules/Rlm_ldap) says  this should be   configured in `raddb/mods-available/ldap`, but for freeradius-3.0.13-9.el7_5.x86_64 on centos7, it will display error 
   `/etc/raddb/mods-enabled/ldap[413]: Invalid location for 'if'`
   `Errors reading or parsing /etc/raddb/radiusd.conf`
    so we shoud configure it at /etc/raddb/sites-enabled/default
  > 2. To restrict user to have specific permission, we need to map  Group-Policy betwwen ASA and freeradius, so we need to add attribute `ASA-Group-Policy` in this section too. we can get all attributes from `/usr/share/freeradius/dictionary.cisco.asa`     
    ```sh
       grep -i policy /usr/share/freeradius/dictionary.cisco.asa
       ATTRIBUTE	ASA-Group-Policy			25	string
    ```
  > 3. Configuration for ` Group-Policy` and other attributes are  listed  https://www.cisco.com/c/en/us/td/docs/security/asa/asa912/configuration/general/asa-912-general-config/aaa-radius.html

  > 4. also we can here add reply based on some runtime attributes and vaules
 
    e.g , we can use `ASA_ClientType` at `post-auth` to reply based on request of vpn autentication request, since only VPN authentication request have `ASA_` prefix attribitutes in the requests   

  ```
    if (ASA-ClientType) {

              if (LDAP-Group == "jm_vpn" &&  ASA-TunnelGroupName =="JM_VPN" ) {
                  update reply {
                      Service-Type = "Outbound-User",
                      ASA-Group-Policy = "OU=JM_VPN"
                      }
              }
              elsif ( LDAP-Group == "oob_admin_vpn" &&  ASA-TunnelGroupName =="OOB_ADMIN_VPN" ) {
                  update reply {
                      Service-Type = "Outbound-User",
                      ASA-Group-Policy = "OU=OOB_ADMIN_VPN"
                      }
              }
              elsif ( LDAP-Group == "inb_admin_vpn" &&  ASA-TunnelGroupName =="INB_ADMIN_VPN" ) {
                  update reply {
                      Service-Type = "Outbound-User",
                      ASA-Group-Policy = "OU=INB_ADMIN_VPN"
                      }
              }
              elsif ( LDAP-Group == "inb_s1_dev_vpn" &&  ASA-TunnelGroupName =="INB_S1_DEV_VPN" ) {
                  update reply {
                      Service-Type = "Outbound-User",
                      ASA-Group-Policy = "OU=INB_S1_DEV_VPN"
                      }
              }
              elsif ( LDAP-Group == "inb_s1_qa_vpn" &&  ASA-TunnelGroupName =="INB_S1_QA_VPN" ) {
                  update reply {
                      Service-Type = "Outbound-User",
                      ASA-Group-Policy = "OU=INB_S1_QA_VPN"
                      }
              }
              else{
                reject
              }                                                                                                         
            }
  ```
## 17. Integrate with grafana via ldap

### 17.1 Create ldap user for binding 
```sh
# cat grafana.updater
dn: uid=grafana,cn=sysaccounts,cn=etc,dc=inb,dc=cnsgas,dc=com
add:objectclass:account
add:objectclass:simplesecurityobject
add:uid:grafana
add:userPassword:GrafanaPass
add:passwordExpirationTime:20380119031407Z
add:nsIdleTimeout:0
# ipa-ldap-updater grafana.update
```
### 17.2 Configure grafana to enable ldap auth 
- enable ldap module in /etc/grafana/grafana.ini
  ```conf
  [auth.ldap]
  enabled = true
  config_file = /etc/grafana/ldap.toml
  allow_sign_up = true
  ```
- Donwload freeipa ca.crt, save it to /etc/grafana/ipa-ca.crt
- Configure /etc/grafana/ldap.toml
  ```
  # To troubleshoot and get more log info enable ldap debug logging in grafana.ini
  #[log]
  #filters = "ldap:debug"

  [[servers]]
  # Ldap server host (specify multiple hosts space separated)
  host = "10.36.52.172 10.36.52.173"
  # Default port is 389 or 636 if use_ssl = true
  port = 636
  # Set to true if ldap server supports TLS
  use_ssl = true
  # Set to true if connect ldap server with STARTTLS pattern (create connection in insecure, then upgrade to secure connection with TLS)
  start_tls = false
  # set to true if you want to skip ssl cert validation
  ssl_skip_verify = false
  # set to the path to your root CA certificate or leave unset to use system defaults
  root_ca_cert = "/etc/grafana/ipa-ca.crt"
  # Authentication against LDAP servers requiring client certificates
  # client_cert = "/path/to/client.crt"
  # client_key = "/path/to/client.key"

  # Search user bind dn
  bind_dn = "uid=kibana,cn=sysaccounts,cn=etc,dc=inb,dc=cnsgas,dc=com"
  # Search user bind password
  # If the password contains # or ; you have to wrap it with triple quotes. Ex """#password;"""
  bind_password = 'kibanaPass'

  # User search filter, for example "(cn=%s)" or "(sAMAccountName=%s)" or "(uid=%s)"
  search_filter = "(uid=%s)"

  # An array of base dns to search through
  search_base_dns = ["cn=users,cn=accounts,dc=inb,dc=cnsgas,dc=com"]

  ## For Posix or LDAP setups that does not support member_of attribute you can define the below settings
  ## Please check grafana LDAP docs for examples
  # group_search_filter = "(&(objectClass=posixGroup)(memberUid=%s))"
  # group_search_base_dns = ["ou=groups,dc=grafana,dc=org"]
  # group_search_filter_user_attribute = "uid"

  # Specify names of the ldap attributes your ldap uses
  [servers.attributes]
  name = "cn"
  surname = "sn"
  username = "uid"
  member_of = "memberOf"
  email =  "mail"

  # Map ldap groups to grafana org roles
  [[servers.group_mappings]]
  group_dn = "cn=grafanaadmins,cn=groups,cn=accounts,dc=inb,dc=cnsgas,dc=com"
  org_role = "Admin"
  # To make user an instance admin  (Grafana Admin) uncomment line below
  # grafana_admin = true
  # The Grafana organization database id, optional, if left out the default org (id 1) will be used
  # org_id = 1

  [[servers.group_mappings]]
  group_dn = "cn=grafanaeditors,cn=groups,cn=accounts,dc=inb,dc=cnsgas,dc=com"
  org_role = "Editor"

  [[servers.group_mappings]]
  # If you want to match all (or no ldap groups) then you can use wildcard
  group_dn = "cn=grafanausers,cn=groups,cn=accounts,dc=inb,dc=cnsgas,dc=com"
  org_role = "Viewer"
  ```

## 18. Integrate with kibana via ldap
### 18.1 install [kibana-mithril](https://github.com/codingchili/kibana-mithril) plugin into kibana
  > if no binary plugin provided, we need to compile it from source
### 18.2 add kibana user for binding 
  ```sh
  # cat kibana.updater
  dn: uid=grafana,cn=sysaccounts,cn=etc,dc=inb,dc=cnsgas,dc=com
  add:objectclass:account
  add:objectclass:simplesecurityobject
  add:uid:grafana
  add:userPassword:kibanaPass
  add:passwordExpirationTime:20380119031407Z
  add:nsIdleTimeout:0
  # ipa-ldap-updater kibana.update
  ```
### 18.3 configure kibana-mithril plugin 
  ```sh
  # cat /usr/share/kibana/plugins/kibana-mithril/config.json
  {
      "storage": "ldap",
      "two-factor": {
          "enabled": false,
          "length": 16
      },
      "proxy": {
          "enabled": false,
          "port": 7575,
          "remote": "localhost:5601"
      },
      "authentication": {
          "kbnVersion": "6.6.2",
          "cookieName": "mithril",
          "cookie": {
              "ttl": 1209600,
              "path": "/",
              "encoding": "none",
              "isSecure": false,
              "isHttpOnly": true,
              "clearInvalid": true,
              "strictHeader": true
          },
          "secret": "SBPyEIwubNvOsY2hgLa+gtwty5Q7c5cbdH2ATvvfQSkKi5/so2i442aM5j3bsCfl5hogN1vsnIveKlZt9X9ffg=="
      },
      "file": {
          "filename": "users.json"
      },
      "ldap": {
          "url": "ldap://10.36.52.172:389,ldap://10.36.52.173:389",
          "admin": {
              "dn": "uid=kibana,cn=sysaccounts,cn=etc,dc=inb,dc=hqxywl,dc=com",
              "password": "kibanaPass"
          },
          "search": {
              "scope": "sub",
              "user-dn": "cn=users,cn=accounts,dc=inb,dc=hqxywl,dc=com",
              "group-dn": "cn=groups,cn=accounts,dc=inb,dc=hqxywl,dc=com"
          }
      },
      "mongodb": {
          "remote": "mongodb://localhost/plugin"
      }
  }
  ```

## 19. administration via api

### get authentication cookie 
```
# Login with user name and password
export COOKIEJAR=./auth-COOKIEJAR
export _USERNAME=admin
export _PASSWORD=pass
#  get the ca.crt

curl -k   https://dc1-vm-freeipa-prod01.inb.hqxywl.com/ipa/config/ca.crt -o /tmp/ca.crt  

$  curl -v  -k -H Referer:https://dc1-vm-freeipa-prod01.inb.hqxywl.com/ipa  -H "Content-Type:application/x-www-form-urlencoded" -H "Accept:text/plain" -c $COOKIEJAR -b $COOKIEJAR --cacert /tmp/ca.crt  --data "user=$_USERNAME&password=$_PASSWORD" -X POST https://dc1-vm-freeipa-prod01.inb.hqxywl.com/ipa/session/login_password
```
### find user via curl 
```
# query user_info 
# cat request.json  
    {
        "method" : "user_show",
        "params":[
            ["i336589"],
            {"all" : true,
            "version": "2.230"
            }
        ],
        "id":0
    }

curl -v -k     -H referer:https://dc1-vm-freeipa-prod01.inb.hqxywl.com/ipa      -H "Content-Type:application/json"     -H "Accept:application/json"    -c $COOKIEJAR -b $COOKIEJAR     --cacert /tmp/ca.crt    -d  @request.json     -X POST     https://dc1-vm-freeipa-prod01.inb.hqxywl.com/ipa/session/json

{
  "result": {
    "result": {
      "has_keytab": true,
      "uid": [
        "i336589"
      ],
      "krbcanonicalname": [
        "i336589@INB.HQXYWL.COM"
      ],
      "ipauserauthtype": [
        "otp"
      ],
      "memberof_group": [
        "grafana_admin",
        "ipausers",
        "kibana_admin"
      ],
      "has_password": true,
      "homedirectory": [
        "/home/i336589"
      ],
      "nsaccountlock": false,
      "cn": [
        "Jennings Liu"
      ],
      "loginshell": [
        "/bin/sh"
      ],
      "uidnumber": [
        "1662200001"
      ],
      "preserved": false,
      "krbextradata": [
        {
          "__base64__": "AALvz0ddaTMzNjU4OUBJTkIuU05GQy5DT00A"
        }
      ],
      "mail": [
        "i336589@inb.hqxywl.com"
      ],
      "dn": "uid=i336589,cn=users,cn=accounts,dc=inb,dc=hqxywl,dc=com",
      "displayname": [
        "Jennings Liu"
      ],
      "description": [
        "Authenticated at 2019-08-05 16:23:27.786724"
      ],
      "mepmanagedentry": [
        "cn=i336589,cn=groups,cn=accounts,dc=inb,dc=hqxywl,dc=com"
      ],
      "ipauniqueid": [
        "048683f8-b74c-11e9-bb39-0050568eb537"
      ],
      "krbprincipalname": [
        "i336589@INB.HQXYWL.COM"
      ],
      "givenname": [
        "Jennings"
      ],
      "krbpasswordexpiration": [
        {
          "__datetime__": "20191103064255Z"
        }
      ],
      "krblastfailedauth": [
        {
          "__datetime__": "20190806055522Z"
        }
      ],
      "objectclass": [
        "top",
        "person",
        "organizationalperson",
        "inetorgperson",
        "inetuser",
        "posixaccount",
        "krbprincipalaux",
        "krbticketpolicyaux",
        "ipaobject",
        "ipasshuser",
        "ipaSshGroupOfPubKeys",
        "mepOriginEntry",
        "ipauserauthtypeclass"
      ],
      "gidnumber": [
        "1662200001"
      ],
      "gecos": [
        "Jennings Liu"
      ],
      "sn": [
        "Liu"
      ],
      "krbloginfailedcount": [
        "0"
      ],
      "krblastpwdchange": [
        {
          "__datetime__": "20190805064255Z"
        }
      ],
      "initials": [
        "JL"
      ]
    },
    "value": "i336589",
    "summary": null
  },
  "version": "4.6.4",
  "error": null,
  "id": 0,
  "principal": "admin@INB.HQXYWL.COM"
}


```