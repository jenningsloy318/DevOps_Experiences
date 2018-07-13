1. some usefull variables

    - `ansible_virtualization_role`: value can be guest or host, to determine if it is a vm

    -  `ansible_os_family`: value can be RedHat,Suse, Debian,
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