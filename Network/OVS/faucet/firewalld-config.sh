#!/bin/bash
firewall-cmd --add-port={6633/tcp,5355/tcp,9302/tcp} --permanent
firewall-cmd --reload