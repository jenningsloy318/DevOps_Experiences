
## Preparation
```
useradd -m -d /home/git -r -s /bin/bash -U -c 'Git Version Control' git
useradd -s -m /db posrgres
/usr/bin/initdb -D /db/ -E UTF8
sed  's/^#Port.*$/Port 2222/g' /etc/ssh/sshd_config
systemctl restart sshd
```
## gitea config
- app.ini
```

APP_NAME = S1 Plus Git Server
RUN_USER = git
RUN_MODE = prod

[repository]
ROOT               = /apps/gitea/repositories
SCRIPT_TYPE        = bash
FORCE_PRIVATE      = true
DEFAULT_PRIVATE    = private
DEFAULT_REPO_UNITS = repo.code,repo.releases,repo.issues,repo.pulls,repo.wiki

[server]
PROTOCOL         = https
ROOT_URL         = https://git.lmy.com:443/
HTTP_PORT        = 443
CERT_FILE        = /etc/gitea/gitea.crt
KEY_FILE         = /etc/gitea/gitea.pem
DISABLE_SSH      = false
START_SSH_SERVER = true
SSH_PORT         = 22
; ./gitea cert -ca=true -duration=8760h0m0s -host=git.lmy.com
APP_DATA_PATH    = /apps/gitea/data
LFS_START_SERVER = true
LFS_CONTENT_PATH = /apps/gitea/data/lfs
LFS_JWT_SECRET   = i-ag3mGahbjpjrdolwresUTHjULPxRfL1fy4QzamF7I

[database]
DB_TYPE = postgres
HOST    = localhost:5432
NAME    = giteadb
USER    = gitea
PASSWD  = gitea

[mailer]
ENABLED        = true
FROM           = noreply@lmy.com
MAILER_TYPE    = smtp
HOST           = mail.lmy.com:587
IS_TLS_ENABLED = true
USER           = sbda-alerts
PASSWD         = "Q1RVTjUwOTQ3OTYzQQo"

[service]
REQUIRE_SIGNIN_VIEW = true

[oauth2]
JWT_SECRET = q_rqZwLCUsfO9GsqSRA46pD1FDf0vy_b35rmm7R6NWQ

[security]
INTERNAL_TOKEN = eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYmYiOjE1ODUyODMwMTJ9.4QkYa4JfRbx6aYQsjD_eSNqNRd0DH40Y3NrLIFLsIG8
INSTALL_LOCK = true


```
- gitea.service
```
[Unit]
Description=Gitea (Git with a cup of tea)
After=syslog.target
After=network.target

[Service]
LimitMEMLOCK=infinity
LimitNOFILE=65535
RestartSec=2s
Type=simple
User=git
Group=git
WorkingDirectory=/apps
#RuntimeDirectory=gitea
ExecStart=/usr/bin/gitea web --config /etc/gitea/app.ini
Restart=always

# If you want to bind Gitea to a port below 1024, uncomment
# the two values below, or use socket activation to pass Gitea its ports as above
###
CapabilityBoundingSet=CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_BIND_SERVICE
###

[Install]
WantedBy=multi-user.target
```