Install freeipa and integrated with freeradius
---
#Prep:
1. hostname: dc1-oob-vm-freeipa-prod01.hqxywl.com
2. domain: hqxywl.com
3. Realm: HQXYWL.COM
4. IP: 10.36.47.230

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
yum install ipa-server bind bind-dyndb-ldap
```
## 2. Install freeipa
```sh
# ipa-server-install -a Devops2019  -p Devops2019 -r HQXYWL.COM 

The log file for this installation can be found in /var/log/ipaserver-install.log
==============================================================================
This program will set up the IPA Server.

This includes:
  * Configure a stand-alone CA (dogtag) for certificate management
  * Configure the Network Time Daemon (ntpd)
  * Create and configure an instance of Directory Server
  * Create and configure a Kerberos Key Distribution Center (KDC)
  * Configure Apache (httpd)
  * Configure the KDC to enable PKINIT

To accept the default shown in brackets, press the Enter key.

WARNING: conflicting time&date synchronization service 'chronyd' will be disabled
in favor of ntpd

Do you want to configure integrated DNS (BIND)? [no]: no

Enter the fully qualified domain name of the computer
on which you're setting up server software. Using the form
<hostname>.<domainname>
Example: master.example.com.


Server host name [dc1-oob-vm-freeipa-prod01.hqxywl.com]: 

The domain name has been determined based on the host name.

Please confirm the domain name [hqxywl.com]: 


The IPA Master Server will be configured with:
Hostname:       dc1-oob-vm-freeipa-prod01.hqxywl.com
IP address(es): 10.36.47.230
Domain name:    hqxywl.com
Realm name:     HQXYWL.COM

Continue to configure the system with these values? [no]: y

The following operations may take some minutes to complete.
Please wait until the prompt is returned.

Configuring NTP daemon (ntpd)
  [1/4]: stopping ntpd
  [2/4]: writing configuration
  [3/4]: configuring ntpd to start on boot
  [4/4]: starting ntpd
Done configuring NTP daemon (ntpd).
Configuring directory server (dirsrv). Estimated time: 30 seconds
  [1/44]: creating directory server instance
  [2/44]: enabling ldapi
  [3/44]: configure autobind for root
  [4/44]: stopping directory server
  [5/44]: updating configuration in dse.ldif
  [6/44]: starting directory server
  [7/44]: adding default schema
  [8/44]: enabling memberof plugin
  [9/44]: enabling winsync plugin
  [10/44]: configuring replication version plugin
  [11/44]: enabling IPA enrollment plugin
  [12/44]: configuring uniqueness plugin
  [13/44]: configuring uuid plugin
  [14/44]: configuring modrdn plugin
  [15/44]: configuring DNS plugin
  [16/44]: enabling entryUSN plugin
  [17/44]: configuring lockout plugin
  [18/44]: configuring topology plugin
  [19/44]: creating indices
  [20/44]: enabling referential integrity plugin
  [21/44]: configuring certmap.conf
  [22/44]: configure new location for managed entries
  [23/44]: configure dirsrv ccache
  [24/44]: enabling SASL mapping fallback
  [25/44]: restarting directory server
  [26/44]: adding sasl mappings to the directory
  [27/44]: adding default layout
  [28/44]: adding delegation layout
  [29/44]: creating container for managed entries
  [30/44]: configuring user private groups
  [31/44]: configuring netgroups from hostgroups
  [32/44]: creating default Sudo bind user
  [33/44]: creating default Auto Member layout
  [34/44]: adding range check plugin
  [35/44]: creating default HBAC rule allow_all
  [36/44]: adding entries for topology management
  [37/44]: initializing group membership
  [38/44]: adding master entry
  [39/44]: initializing domain level
  [40/44]: configuring Posix uid/gid generation
  [41/44]: adding replication acis
  [42/44]: activating sidgen plugin
  [43/44]: activating extdom plugin
  [44/44]: configuring directory to start on boot
Done configuring directory server (dirsrv).
Configuring Kerberos KDC (krb5kdc)
  [1/10]: adding kerberos container to the directory
  [2/10]: configuring KDC
  [3/10]: initialize kerberos container
  [4/10]: adding default ACIs
  [5/10]: creating a keytab for the directory
  [6/10]: creating a keytab for the machine
  [7/10]: adding the password extension to the directory
  [8/10]: creating anonymous principal
  [9/10]: starting the KDC
  [10/10]: configuring KDC to start on boot
Done configuring Kerberos KDC (krb5kdc).
Configuring kadmin
  [1/2]: starting kadmin 
  [2/2]: configuring kadmin to start on boot
Done configuring kadmin.
Configuring ipa-custodia
  [1/5]: Making sure custodia container exists
  [2/5]: Generating ipa-custodia config file
  [3/5]: Generating ipa-custodia keys
  [4/5]: starting ipa-custodia 
  [5/5]: configuring ipa-custodia to start on boot
Done configuring ipa-custodia.
Configuring certificate server (pki-tomcatd). Estimated time: 3 minutes
  [1/28]: configuring certificate server instance
  [2/28]: exporting Dogtag certificate store pin
  [3/28]: stopping certificate server instance to update CS.cfg
  [4/28]: backing up CS.cfg
  [5/28]: disabling nonces
  [6/28]: set up CRL publishing
  [7/28]: enable PKIX certificate path discovery and validation
  [8/28]: starting certificate server instance
  [9/28]: configure certmonger for renewals
  [10/28]: requesting RA certificate from CA
  [11/28]: setting audit signing renewal to 2 years
  [12/28]: restarting certificate server
  [13/28]: publishing the CA certificate
  [14/28]: adding RA agent as a trusted user
  [15/28]: authorizing RA to modify profiles
  [16/28]: authorizing RA to manage lightweight CAs
  [17/28]: Ensure lightweight CAs container exists
  [18/28]: configure certificate renewals
  [19/28]: configure Server-Cert certificate renewal
  [20/28]: Configure HTTP to proxy connections
  [21/28]: restarting certificate server

  [22/28]: updating IPA configuration
  [23/28]: enabling CA instance
  [24/28]: migrating certificate profiles to LDAP
  [25/28]: importing IPA certificate profiles
  [26/28]: adding default CA ACL
  [27/28]: adding 'ipa' CA entry
  [28/28]: configuring certmonger renewal for lightweight CAs
Done configuring certificate server (pki-tomcatd).
Configuring directory server (dirsrv)
  [1/3]: configuring TLS for DS instance
  [2/3]: adding CA certificate entry
  [3/3]: restarting directory server
Done configuring directory server (dirsrv).
Configuring ipa-otpd
  [1/2]: starting ipa-otpd 
  [2/2]: configuring ipa-otpd to start on boot
Done configuring ipa-otpd.
Configuring the web interface (httpd)
  [1/22]: stopping httpd
  [2/22]: setting mod_nss port to 443
  [3/22]: setting mod_nss cipher suite
  [4/22]: setting mod_nss protocol list to TLSv1.0 - TLSv1.2
  [5/22]: setting mod_nss password file
  [6/22]: enabling mod_nss renegotiate
  [7/22]: disabling mod_nss OCSP
  [8/22]: adding URL rewriting rules
  [9/22]: configuring httpd
  [10/22]: setting up httpd keytab
  [11/22]: configuring Gssproxy
  [12/22]: setting up ssl
  [13/22]: configure certmonger for renewals
  [14/22]: importing CA certificates from LDAP
  [15/22]: publish CA cert
  [16/22]: clean up any existing httpd ccaches
  [17/22]: configuring SELinux for httpd
  [18/22]: create KDC proxy config
  [19/22]: enable KDC proxy
  [20/22]: starting httpd
  [21/22]: configuring httpd to start on boot
  [22/22]: enabling oddjobd
Done configuring the web interface (httpd).
Configuring Kerberos KDC (krb5kdc)
  [1/1]: installing X509 Certificate for PKINIT
Done configuring Kerberos KDC (krb5kdc).
Applying LDAP updates
Upgrading IPA:. Estimated time: 1 minute 30 seconds
  [1/10]: stopping directory server
  [2/10]: saving configuration
  [3/10]: disabling listeners
  [4/10]: enabling DS global lock
  [5/10]: disabling Schema Compat
  [6/10]: starting directory server
  [7/10]: upgrading server
  [8/10]: stopping directory server
  [9/10]: restoring configuration
  [10/10]: starting directory server
Done.
Restarting the KDC
Configuring client side components
Using existing certificate '/etc/ipa/ca.crt'.
Client hostname: dc1-oob-vm-freeipa-prod01.hqxywl.com
Realm: HQXYWL.COM
DNS Domain: hqxywl.com
IPA Server: dc1-oob-vm-freeipa-prod01.hqxywl.com
BaseDN: dc=hqxywl,dc=com

Skipping synchronizing time with NTP server.
New SSSD config will be created
Configured sudoers in /etc/nsswitch.conf
Configured /etc/sssd/sssd.conf
trying https://dc1-oob-vm-freeipa-prod01.hqxywl.com/ipa/json
[try 1]: Forwarding 'schema' to json server 'https://dc1-oob-vm-freeipa-prod01.hqxywl.com/ipa/json'
trying https://dc1-oob-vm-freeipa-prod01.hqxywl.com/ipa/session/json
[try 1]: Forwarding 'ping' to json server 'https://dc1-oob-vm-freeipa-prod01.hqxywl.com/ipa/session/json'
[try 1]: Forwarding 'ca_is_enabled' to json server 'https://dc1-oob-vm-freeipa-prod01.hqxywl.com/ipa/session/json'
Systemwide CA database updated.
Adding SSH public key from /etc/ssh/ssh_host_rsa_key.pub
Adding SSH public key from /etc/ssh/ssh_host_ecdsa_key.pub
Adding SSH public key from /etc/ssh/ssh_host_ed25519_key.pub
[try 1]: Forwarding 'host_mod' to json server 'https://dc1-oob-vm-freeipa-prod01.hqxywl.com/ipa/session/json'
Could not update DNS SSHFP records.
SSSD enabled
Configured /etc/openldap/ldap.conf
Configured /etc/ssh/ssh_config
Configured /etc/ssh/sshd_config
Configuring hqxywl.com as NIS domain.
Client configuration complete.
The ipa-client-install command was successful

ipaserver.dns_data_management: ERROR    unable to resolve host name dc1-oob-vm-freeipa-prod01.hqxywl.com. to IP address, ipa-ca DNS record will be incomplete
ipaserver.dns_data_management: ERROR    unable to resolve host name dc1-oob-vm-freeipa-prod01.hqxywl.com. to IP address, ipa-ca DNS record will be incomplete
Please add records in this file to your DNS system: /tmp/ipa.system.records.wvEWex.db
==============================================================================
Setup complete

Next steps:
	1. You must make sure these network ports are open:
		TCP Ports:
		  * 80, 443: HTTP/HTTPS
		  * 389, 636: LDAP/LDAPS
		  * 88, 464: kerberos
		UDP Ports:
		  * 88, 464: kerberos
		  * 123: ntp

	2. You can now obtain a kerberos ticket using the command: 'kinit admin'
	   This ticket will allow you to use the IPA tools (e.g., ipa user-add)
	   and the web user interface.

Be sure to back up the CA certificates stored in /root/cacert.p12
These files are required to create replicas. The password for these
files is the Directory Manager password
```

## 3. check ldap users

to find out the the default base_dn used in `radius`, which is `cn=users,cn=accounts,dc=hqxywl,dc=com`
```sh
ldapsearch -x -v -W -D 'cn=Directory Manager'  uid=admin
ldap_initialize( <DEFAULT> )
Enter LDAP Password: 
filter: uid=admin
requesting: All userApplication attributes
# extended LDIF
#
# LDAPv3
# base <dc=hqxywl,dc=com> (default) with scope subtree
# filter: uid=admin
# requesting: ALL
#

# admin, users, compat, hqxywl.com
dn: uid=admin,cn=users,cn=compat,dc=hqxywl,dc=com
objectClass: posixAccount
objectClass: ipaOverrideTarget
objectClass: top
gecos: Administrator
cn: Administrator
uidNumber: 1177800000
gidNumber: 1177800000
loginShell: /bin/bash
homeDirectory: /home/admin
ipaAnchorUUID:: OklQQTpocXh5d2wuY29tOjY3NDU2MGM4LTQ1OTAtMTFlOS1iY2I4LTAwNTA1Nj
 k0M2NjNw==
uid: admin

# admin, users, accounts, hqxywl.com
dn: uid=admin,cn=users,cn=accounts,dc=hqxywl,dc=com
objectClass: top
objectClass: person
objectClass: posixaccount
objectClass: krbprincipalaux
objectClass: krbticketpolicyaux
objectClass: inetuser
objectClass: ipaobject
objectClass: ipasshuser
objectClass: ipaSshGroupOfPubKeys
uid: admin
krbPrincipalName: admin@HQXYWL.COM
cn: Administrator
sn: Administrator
uidNumber: 1177800000
gidNumber: 1177800000
homeDirectory: /home/admin
loginShell: /bin/bash
gecos: Administrator
ipaUniqueID: 674560c8-4590-11e9-bcb8-005056943cc7
memberOf: cn=admins,cn=groups,cn=accounts,dc=hqxywl,dc=com
memberOf: cn=Replication Administrators,cn=privileges,cn=pbac,dc=hqxywl,dc=com
memberOf: cn=Add Replication Agreements,cn=permissions,cn=pbac,dc=hqxywl,dc=co
 m
memberOf: cn=Modify Replication Agreements,cn=permissions,cn=pbac,dc=hqxywl,dc
 =com
memberOf: cn=Read Replication Agreements,cn=permissions,cn=pbac,dc=hqxywl,dc=c
 om
memberOf: cn=Remove Replication Agreements,cn=permissions,cn=pbac,dc=hqxywl,dc
 =com
memberOf: cn=Modify DNA Range,cn=permissions,cn=pbac,dc=hqxywl,dc=com
memberOf: cn=Read PassSync Managers Configuration,cn=permissions,cn=pbac,dc=hq
 xywl,dc=com
memberOf: cn=Modify PassSync Managers Configuration,cn=permissions,cn=pbac,dc=
 hqxywl,dc=com
memberOf: cn=Read LDBM Database Configuration,cn=permissions,cn=pbac,dc=hqxywl
 ,dc=com
memberOf: cn=Add Configuration Sub-Entries,cn=permissions,cn=pbac,dc=hqxywl,dc
 =com
memberOf: cn=Read DNA Range,cn=permissions,cn=pbac,dc=hqxywl,dc=com
memberOf: cn=Host Enrollment,cn=privileges,cn=pbac,dc=hqxywl,dc=com
memberOf: cn=System: Add krbPrincipalName to a Host,cn=permissions,cn=pbac,dc=
 hqxywl,dc=com
memberOf: cn=System: Enroll a Host,cn=permissions,cn=pbac,dc=hqxywl,dc=com
memberOf: cn=System: Manage Host Certificates,cn=permissions,cn=pbac,dc=hqxywl
 ,dc=com
memberOf: cn=System: Manage Host Enrollment Password,cn=permissions,cn=pbac,dc
 =hqxywl,dc=com
memberOf: cn=System: Manage Host Keytab,cn=permissions,cn=pbac,dc=hqxywl,dc=co
 m
memberOf: cn=System: Manage Host Principals,cn=permissions,cn=pbac,dc=hqxywl,d
 c=com
memberOf: cn=trust admins,cn=groups,cn=accounts,dc=hqxywl,dc=com
krbPrincipalKey:: MIHeoAMCAQGhAwIBAaIDAgEBowMCAQGkgccwgcQwaKAbMBmgAwIBBKESBBBk
 QnZVW11xJGQ1LkhJcVtToUkwR6ADAgESoUAEPiAArAvqaj/0KppLj0cYDhfGgEfT18/X1dlynNfn3
 Yug0ijpVSeuIkDm2pe+sEsz/fdP8u8vKspH9AD/CGo1MFigGzAZoAMCAQShEgQQWj9fKD1dKmdcc0
 56Ml99YKE5MDegAwIBEaEwBC4QAFVVlsbT1MMgFCX1Wft5q4C4nSJGRmLEaVPTL+WqoyONU7zNErx
 4bt9w8CdP
krbLastPwdChange: 20190313130742Z
krbPasswordExpiration: 20190611130742Z
userPassword:: e1NTSEE1MTJ9OHpNaDVycGhxSWxUSDhGWEoyd04rSFd3bUt2amQ3SlVFdW5sVWV
 5S1RHS0U4YTRtYTZ4amFybGw5Z2p4bUhOY2NMLzVKZHVEZVdneUY3QzQwR1Fhck44enNyTkwxTVZm
krbExtraData:: AAKeAIlccm9vdC9hZG1pbkBIUVhZV0wuQ09NAA==

# search result
search: 2
result: 0 Success

# numResponses: 3
# numEntries: 2
```



## 4. Configure freeradius
- Edit /etc/raddb/clients.conf,modified following items:
    - ipaddr 
    - secret

  Full contenf of `/etc/raddb/clients.conf`
    ```
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
    client localhost_ipv6 {
      ipv6addr	= ::1
      secret		= testing123
    }
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
      update {
        control:Password-With-Header	+= 'userPassword'
        control:			+= 'radiusControlAttribute'
        request:			+= 'radiusRequestAttribute'
        reply:				+= 'radiusReplyAttribute'
      }
      user {
        base_dn = "${..base_dn}"
        filter = "(uid=%{%{Stripped-User-Name}:-%{User-Name}})"
        sasl {
        }
      }
      group {
        base_dn = "${..base_dn}"
        filter = '(objectClass=posixGroup)'
        membership_attribute = 'memberOf'
      }
      profile {
      }
      client {
        base_dn = "${..base_dn}"
        filter = '(objectClass=radiusClient)'
        template {
        }
        attribute {
          ipaddr				= 'radiusClientIdentifier'
          secret				= 'radiusClientSecret'
        }
      }
      accounting {
        reference = "%{tolower:type.%{Acct-Status-Type}}"
        type {
          start {
            update {
              description := "Online at %S"
            }
          }
          interim-update {
            update {
              description := "Last seen at %S"
            }
          }
          stop {
            update {
              description := "Offline at %S"
            }
          }
        }
      }
      post-auth {
        update {
          description := "Authenticated at %S"
        }
      }
      options {
        chase_referrals = yes
        rebind = yes
        res_timeout = 10
        srv_timelimit = 3
        net_timeout = 1
        idle = 60
        probes = 3
        interval = 3
        ldap_debug = 0x0028
      }
      tls {
      }
      pool {
        start = ${thread[pool].start_servers}
        min = ${thread[pool].min_spare_servers}
        max = ${thread[pool].max_servers}
        spare = ${thread[pool].max_spare_servers}
        uses = 0
        retry_delay = 30
        lifetime = 0
        idle_timeout = 60
      }
    }
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
      ```
      #  Auth-Type LDAP {
      #    ldap
      #  }
      ```
      to

      ```
        Auth-Type LDAP {
          ldap
        }    
      ```
    
    Full content /etc/raddb/sites-enabled/default
    ```conf
    server default {
    listen {
      type = auth
      ipaddr = *
      port = 0
      limit {
            max_connections = 16
            lifetime = 0
            idle_timeout = 30
      }
    }
    listen {
      ipaddr = *
      port = 0
      type = acct
      limit {
      }
    }
    listen {
      type = auth
      port = 0
      limit {
            max_connections = 16
            lifetime = 0
            idle_timeout = 30
      }
    }
    listen {
      ipv6addr = ::
      port = 0
      type = acct
      limit {
      }
    }
    authorize {
      filter_username
      preprocess
      auth_log
      chap
      mschap
      digest
      suffix
      eap {
        ok = return
      }
      files
      -sql
      ldap
            if ((ok || updated) && User-Password) {
                update {
                    control:Auth-Type := ldap
                }
            }
      expiration
      logintime
      pap
    }
    authenticate {
      Auth-Type PAP {
        pap
      }
      Auth-Type CHAP {
        chap
      }
      Auth-Type MS-CHAP {
        mschap
      }
      mschap
      digest
      Auth-Type LDAP {
        ldap
      }
      eap
    }
    preacct {
      preprocess
      acct_unique
      suffix
      files
    }
    accounting {
      detail
      unix
      -sql
      exec
      attr_filter.accounting_response
    }
    session {
    }
    post-auth {
      update {
        &reply: += &session-state:
      }
      -sql
      exec
      remove_reply_message_if_eap
      Post-Auth-Type REJECT {
        -sql
        attr_filter.access_reject
        eap
        remove_reply_message_if_eap
      }
      Post-Auth-Type Challenge {
      }
    }
    pre-proxy {
    }
    post-proxy {
      eap
    }
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

    Full content /etc/raddb/sites-enabled/inner-tunnel
    ```conf
    server default {
    listen {
      type = auth
      ipaddr = *
      port = 0
      limit {
            max_connections = 16
            lifetime = 0
            idle_timeout = 30
      }
    }
    listen {
      ipaddr = *
      port = 0
      type = acct
      limit {
      }
    }
    listen {
      type = auth
      port = 0
      limit {
            max_connections = 16
            lifetime = 0
            idle_timeout = 30
      }
    }
    listen {
      ipv6addr = ::
      port = 0
      type = acct
      limit {
      }
    }
    authorize {
      filter_username
      preprocess
      auth_log
      chap
      mschap
      digest
      suffix
      eap {
        ok = return
      }
      files
      -sql
      ldap
            if ((ok || updated) && User-Password) {
                update {
                    control:Auth-Type := ldap
                }
            }
      expiration
      logintime
      pap
    }
    authenticate {
      Auth-Type PAP {
        pap
      }
      Auth-Type CHAP {
        chap
      }
      Auth-Type MS-CHAP {
        mschap
      }
      mschap
      digest
      Auth-Type LDAP {
        ldap
      }
      eap
    }
    preacct {
      preprocess
      acct_unique
      suffix
      files
    }
    accounting {
      detail
      unix
      -sql
      exec
      attr_filter.accounting_response
    }
    session {
    }
    post-auth {
      update {
        &reply: += &session-state:
      }
      -sql
      exec
      remove_reply_message_if_eap
      Post-Auth-Type REJECT {
        -sql
        attr_filter.access_reject
        eap
        remove_reply_message_if_eap
      }
      Post-Auth-Type Challenge {
      }
    }
    pre-proxy {
    }
    post-proxy {
      eap
    }
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