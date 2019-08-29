This is the manual process for enrolling a host running SUSE/SLE 12 SP2 with FreeIPA.

The following reference documentation was used to create this process:
* An [outdated guide on Enrolling a SUSE machine](https://en.opensuse.org/Portal:FreeIPA/Installation#FreeIPA_Client) with FreeIPA
* The  [Manual FreeIPA guide](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Identity_Management_Guide/linux-manual.html) from the RedHat documentation.

I do not recommend using yast to set this up, however it is useful to check if the configuration is valid. SUSE/SLE has all the required packages to use FreeIPA but does not have the conveinent `ipa-client` tools, such as `ipa-client-install`.

# Pre-Requisites

* The host must have a fully qualified domain name
* The host must be able to resolve the FreeIPA server hostname
* The FreeIPA server must in the host's `/etc/resolv.conf` as a nameserver, and it should be the first nameserver
* The host must have a route to the FreeIPA server
* The FreeIPA server is assumed to be managing:
    * The Kerberos Realm
    * The DNS domain
* The host must be able to connect to the following services (port protocols) on the FreeIPA server
    * `ntp` (123 TCP)
    * `http` (80 TCP)
    * `https` (443 TCP)
    * `ldap` (389 TCP)
    * `ldaps` (636 TCP)
    * `Kerberos` (88 TCP/UDP)
    * `kpasswd` (464 TCP/UDP)
    * `dns` (53 TCP/UDP)

# Step-by-step guide

## On the FreeIPA server


1. Create the host entry and DNS for the host to be enrolled
    ```
    kinit admin
    ipa host-add yh-vm-freeipa-client-prod01 --ip-address=10.36.52.187
    ```

1. Set the FreeIPA server to manage the host
    ```
    ipa host-add-managedby --hosts=yh-vm-freeipa-prod01.inb.hqxywl.com yh-vm-freeipa-client-prod01
    ```

1. Retrieve the host's keytab, send it to the host, and delete it
    ```
    ipa-getkeytab -s yh-vm-freeipa-prod01.inb.hqxywl.com -p host/yh-vm-freeipa-client-prod01.inb.hqxywl.com -k yh-vm-freeipa-client-prod01.inb.hqxywl.com.krb5.keytab
    scp yh-vm-freeipa-client-prod01.inb.hqxywl.com.krb5.keytab root@yh-vm-freeipa-client-prod01.inb.hqxywl.com:/etc/krb5.keytab
    rm yh-vm-freeipa-client-prod01.inb.hqxywl.com.krb5.keytab 
    ```

## On the host to be enrolled

**Prequsites:  hostname must be configured fqdn**


1. change the DNS settings, add freeipa server as the nameservers
    ```
    cat /etc/resolv.conf
    nameserver 10.36.52.172
    namserver 10.36.52.173
    ```
2. Install the required packages for FreeIPA and the sssd ipa module 
    ```
    zypper install  sssd sssd-ipa krb5-client openldap2-client sssd-ad cyrus-sasl-gssapi
    ```

3. Deploy the host's keytab
    ```
    chown root:root /etc/krb5.keytab
    chmod 0600 /etc/krb5.keytab
    ```

4. Retrieve the FreeIPA server's certificate
    ```
    mkdir /etc/ipa
    curl -k -o /etc/ipa/ca.crt -SL  https://yh-vm-freeipa-prod01.inb.hqxywl.com/ipa/config/ca.crt
    cp /etc/ipa/ca.crt /etc/pki/trust/anchors/ipa.crt
    update-ca-certificates
    ```
5. configure /etc/sssd/sssd.conf
    ```conf
    [sssd]
    config_file_version = 2
    services = sudo, nss, pam, ssh
    domains = inb.hqxywl.com
    debug_level = 10

    [domain/inb.hqxywl.com]
    cache_credentials = True
    krb5_store_password_if_offline = True
    krb5_realm = INB.HQXYWL.COM
    ipa_domain = inb.hqxywl.com
    debug_level = 10
    id_provider = ipa
    auth_provider = ipa
    access_provider = ipa
    chpass_provider = ipa
    sudo_provider = ipa
    ipa_server = yh-vm-freeipa-prod01.inb.hqxywl.com,yh-vm-freeipa-prod02.inb.hqxywl.com,
    ldap_tls_cacert = /etc/sssd/ca.crt
    ldap_sudo_search_base = ou=sudoers,dc=inb,dc=snfc,dc=com
    
    [nss]
    homedir_substring = /home
    debug_level = 10

    [pam]

    debug_level = 10
    [ssh]
    debug_level = 10
    [sudo]
    debug_level = 10
    ```
6. Edit `/etc/nsswitch.conf`
    ```conf
    #
    # /etc/nsswitch.conf
    #
    # An example Name Service Switch config file. This file should be
    # sorted with the most-used services at the beginning.
    #
    # The entry '[NOTFOUND=return]' means that the search for an
    # entry should stop if the search in the previous entry turned
    # up nothing. Note that if the search failed due to some other reason
    # (like no NIS server responding) then the search continues with the
    # next entry.
    #
    # Legal entries are:
    #
    #       compat                  Use compatibility setup
    #       nisplus                 Use NIS+ (NIS version 3)
    #       nis                     Use NIS (NIS version 2), also called YP
    #       dns                     Use DNS (Domain Name Service)
    #       files                   Use the local files
    #       [NOTFOUND=return]       Stop searching if not found so far
    #
    # For more information, please read the nsswitch.conf.5 manual page.
    #

    # passwd: files nis
    # shadow: files nis
    # group:  files nis

    passwd:     files sss
    shadow:     files sss
    group:      files sss

    hosts:          files dns
    networks:       files dns

    services:       files sss
    protocols:      files
    rpc:            files
    ethers:         files
    netmasks:       files
    netgroup:       files nis sss
    publickey:      files

    bootparams:     files
    automount:      files nis sss
    aliases:        files

    sudoers:        files sss
    ```


7. Edit `/etc/krb5.conf`
    ```conf
    [libdefaults]
        default_realm = INB.HQXYWL.COM
        dns_lookup_realm = false
        dns_lookup_kdc = false
        rdns = false
        dns_canonicalize_hostname = false
        ticket_lifetime = 24h
        forwardable = true
        udp_preference_limit = 0
        default_ccache_name = KEYRING:persistent:%{uid}
    #       default_realm = EXAMPLE.COM


    [realms]

        INB.HQXYWL.COM= {
        kdc = yh-vm-freeipa-prod01.inb.hqxywl.com:88
        master_kdc = yh-vm-freeipa-prod01.inb.hqxywl.com:88
        admin_server = yh-vm-freeipa-prod01.inb.hqxywl.com:749
        kpasswd_server = yh-vm-freeipa-prod01.inb.hqxywl.com:464
        default_domain = inb.hqxywl.com
        pkinit_anchors = FILE:/var/lib/ipa-client/pki/kdc-ca-bundle.pem
        pkinit_pool = FILE:/var/lib/ipa-client/pki/ca-bundle.pem
        }
    #       EXAMPLE.COM = {
    #                kdc = kerberos.example.com
    #               admin_server = kerberos.example.com
    #       }

    [domain_realm]
    .inb.hqxywl.com = INB.HQXYWL.COM
    inb.hqxywl.com = INB.HQXYWL.COM
    yh-vm-freeipa-client-prod01.inb.hqxywl.com = INB.HQXYWL.COM

    [dbmodules]
    INB.HQXYWL.COM = {
        db_library = ipadb.so
    }

    [logging]
        kdc = FILE:/var/log/krb5/krb5kdc.log
        admin_server = FILE:/var/log/krb5/kadmind.log
        default = SYSLOG:NOTICE:DAEMON
    ```

8. Configure `/etc/pam.d` to use sssd
    since pam-config can't make extra conf to sss, so we need to create extra conf manually, before that we need to unlink   `common-account` `common-auth` `common-password` `common-session` to `common-*-pc`
    ```sh       
    unlink /etc/pam.d/common-account
    unlink /etc/pam.d/common-password
    unlink /etc/pam.d/common-auth
    unlink /etc/pam.d/common-session
    ```
    
    then create  new pam conf `common-account` `common-auth` `common-password` `common-session`


   ```sh
   cat > /etc/pam.d/common-account <<EOF
    account     required      pam_unix.so
    account     sufficient    pam_localuser.so
    account     sufficient    pam_succeed_if.so uid < 1000 quiet
    account     [default=bad success=ok user_unknown=ignore] pam_sss.so
    account     required      pam_permit.so
    EOF
    

    cat > /etc/pam.d/common-auth <<EOF
    auth        required      pam_env.so
    auth        required      pam_faildelay.so delay=2000000
    auth        [default=1 ignore=ignore success=ok] pam_succeed_if.so uid >= 1000 quiet
    auth        [default=1 ignore=ignore success=ok] pam_localuser.so
    auth        sufficient    pam_unix.so nullok try_first_pass
    auth        requisite     pam_succeed_if.so uid >= 1000 quiet_success
    auth        sufficient    pam_sss.so forward_pass
    auth        required      pam_deny.so
    EOF

    cat > /etc/pam.d/common-password <<EOF
    password    sufficient    pam_unix.so sha512 shadow nullok try_first_pass use_authtok
    password    sufficient    pam_sss.so use_authtok
    password    required      pam_deny.so   
    EOF

    cat  > /etc/pam.d/common-session <<EOF
    session     optional      pam_keyinit.so revoke
    session     required      pam_limits.so
    -session     optional      pam_systemd.so
    session  optional      pam_mkhomedir.so umask=0077
    session     [success=1 default=ignore] pam_succeed_if.so service in crond quiet use_uid
    session     required      pam_unix.so
    session     optional      pam_sss.so
    EOF
    ```
9. configure /etc/ssh/sshd_config, add following lines, and restart sshd 
    ```conf
    
    AuthorizedKeysCommand /usr/bin/sss_ssh_authorizedkeys
    GSSAPIAuthentication yes
    ChallengeResponseAuthentication yes
    AuthorizedKeysCommandUser nobody
    ```

    with sed command to chage sshd config
    ```
    sed -i -e '$aAuthorizedKeysCommand /usr/bin/sss_ssh_authorizedkeys\nGSSAPIAuthentication yes\nChallengeResponseAuthentication yes\nAuthorizedKeysCommandUser nobody' /etc/ssh/sshd_config
    sed -i '/ChallengeResponseAuthentication/s/no/yes/g' /etc/ssh/sshd_config
    systemctl restart sshd
    ```
9. Enable and start sssd
    ```
    systemctl enable sssd
    systemctl start sssd
    ```
