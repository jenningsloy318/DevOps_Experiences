1. some usefull variables

    - `ansible_virtualization_role`: value can be guest or host, to determine if it is a vm
    - `ansible_os_family`: value can be RedHat,Suse, Debian,
    - `ansible_distribution`: value can be Ubuntu,CentOS,Debian,Suse
    - `ansible_distribution_major_version`,`ansible_distribution_version`: 

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

if you need to add more commands excuted after instance started, you can modify template file `userdata.j2`.

This file contains three sections, 

1. first section is cloud-init file, and you need to refer to the official cloud-init website
2. following two sections are shell scripts, you can add shell commands in these two sections

