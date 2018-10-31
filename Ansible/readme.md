1. some usefull variables

    - `ansible_virtualization_role`: value can be guest or host, to determine if it is a vm
    - `ansible_os_family`: AIX,Alpine,Altlinux,Archlinux,Darwin,Debian,FreeBSD,Gentoo,HP-UX,Mandrake,RedHat,SGML,Slackware,Solaris,Suse,
    
    - `ansible_distribution`: Alpine,Altlinux,Amazon,Archlinux,CentOS,ClearLinux,Coreos,Debian,Gentoo,Mandriva,NA,OpenWrt,OracleLinux,RedHat,Slackware,SMGL,SUSE,SLES,VMwareESX,Ubuntu
    - `ansible_distribution_major_version`,`ansible_distribution_version`: 
    - https://docs.ansible.com/ansible/2.6/user_guide/playbooks_conditionals.html#ansible-distribution
2. 
for a better management, we can use following structure 

```sh
.
├── ansible.cfg
├── environments/         # Parent directory for our environment-specific directories
│   ├──roles/
│   ├── dev/              # Contains all files specific to the dev environment
│   │   ├── group_vars/   # dev specific group_vars files
│   │   │   ├── all
│   │   │   ├── db
│   │   │   └── web
│   │   |── host_vars/         # Contains only the hosts in the prod environment
|   |   |    ├── 192.168.6.10
│   │   └── hosts         # Contains only the hosts in the dev environment
│   │
│   ├── prod/             # Contains all files specific to the prod environment
│   │   ├── group_vars/   # prod specific group_vars files
│   │   │   ├── all
│   │   │   ├── db
│   │   │   └── web
│   │   |── host_vars/         # Contains only the hosts in the prod environment
|   |   |    ├── 192.168.6.10
│   │   |── hosts  
│   └── stage/            # Contains all files specific to the stage environment
│       ├── group_vars/   # stage specific group_vars files
│       │   ├── all
│       │   ├── db
│       │   └── web
│       |── host_vars/         # Contains only the hosts in the prod environment
|       |    ├── 192.168.6.10
│       └── hosts         # Contains only the hosts in the stage environment
│
├── playbook.yml
. . .
```
Example playbook: App.yml

```yaml
---
- hosts: app
  remote_user: "{{ remote_user }}"
  vars_files:
    - "{{ env }}/group_vars/certs.yml"
    - "{{ env }}/group_vars/credentials.yml"
    - "{{ env }}/group_vars/keys.yml"
    - "{{ env }}/group_vars/deploy_keys.yml"
  roles:
    - common
    - security
    - credentials
    - apache
    - php
    - hosts
    - ssl-keys
    - node
    - newrelic
  tasks:
    - name: Bring Apache Online
      service:
        name: apache2
        state: started
        enabled: yes
      sudo: yes
```

3. programmer tips 
  - for templating files, if the content contains `{{ some conteent}}` which is not the ansible varaible, and we need to keep it as it is, we need add  `{%raw%} {{ some conteent}} {%endraw%}` to enclose them.

Note for ansible-role-openstack
---

### Prequisites


you should use pip to upgrade `openstacksdk` and `shade` to the latest version
and also install ansible 2.6+

### Usage:
1. modify `clouds.yaml`, which defines the openstack connection credentials, you can rename default name `monsoon03cn1` to anything you like and set it to `os_cloud` in playbook `openstack.yaml`

2. modify  the variables in `openstack.yaml`

3. excute the playbook via 
    ```sh
    ansible-playbook openstack.yaml
    ```


### Customization

if you need to add more commands excuted after instance started, you can modify template file `userdata.j2`. and it is generated via command `write-mime-multipart` to combine multiple parts into one cloud-init config

This file contains three sections, 

1. first section is cloud-init file, and you need to refer to the official cloud-init website
2. following two sections are shell scripts, you can add shell commands in these two sections

