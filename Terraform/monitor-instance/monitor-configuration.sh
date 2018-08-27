#!/bin/bash
  yum install -y https://repos.influxdata.com/centos/7Server/x86_64/stable/telegraf-1.7.3-1.x86_64.rpm#/telegraf-1.7.3-1.x86_64.rpm
  yum install -y https://packagecloud.io/prometheus-rpm/release/packages/el/7/alertmanager-0.15.2-1.el7.centos.x86_64.rpm/download.rpm#/alertmanager-0.15.2-1.el7.centos.x86_64.rpm
  yum install -y https://packagecloud.io/prometheus-rpm/release/packages/el/7/prometheus2-2.3.2-1.el7.centos.x86_64.rpm/download.rpm#/prometheus2-2.3.2-1.el7.centos.x86_64.rpm
  yum install -y https://packagecloud.io/prometheus-rpm/release/packages/el/7/mysqld_exporter-0.11.0-1.el7.centos.x86_64.rpm/download.rpm#/mysqld_exporter-0.11.0-1.el7.centos.x86_64.rpm
  yum install -y https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-5.2.2-1.x86_64.rpm#/grafana-5.2.2-1.x86_64.rpm

systemctl daemon-reload
systemctl restart telegraf
systemctl enable telegraf
systemctl restart prometheus
systemctl enable prometheus
systemctl restart alertmanager
systemctl enable alertmanager
systemctl restart mysqld_exporter
systemctl enable mysqld_exporter
systemctl restart grafana-server
systemctl enable grafana-server