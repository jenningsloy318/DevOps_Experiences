
Configure WAF:
```sh
tmsh create net trunk external-trunk interfaces add { 1.1  }


tmsh create net vlan external-vlan70 interfaces add { external-trunk}  tag 70
tmsh create net self external-vlan70-self-ip { address 10.36.49.142/255.255.255.128 vlan external-vlan70  allow-service default traffic-group traffic-group-local-only}
tmsh create net self external-vlan70-self-ip-floating { address 10.36.49.143/255.255.255.128 vlan external-vlan70  allow-service default traffic-group traffic-group-1}


tmsh create net trunk internal-trunk interfaces add { 1.2  }

tmsh create net vlan internal-vlan132 interfaces add { internal-trunk } tag 132
tmsh create net self internal-vlan132-self-ip { address 10.36.48.146/255.255.255.248 vlan internal-vlan132  allow-service default traffic-group traffic-group-local-only }
tmsh create net self internal-vlan132-self-ip-floating { address 10.36.48.147/255.255.255.248 vlan internal-vlan132  allow-service default traffic-group traffic-group-1 }
```


Configure TM:
```sh
tmsh create net trunk internal-trunk interfaces add { 1.1  }

tmsh create net vlan internal-vlan70 interfaces add { internal-trunk }  tag 70
tmsh create net self internal-vlan70-self-ip { address 10.36.49.144/255.255.255.128 vlan internal-vlan70  allow-service default traffic-group traffic-group-local-only}
tmsh create net self internal-vlan70-self-ip-floating { address 10.36.49.145/255.255.255.128 vlan internal-vlan70  allow-service default traffic-group traffic-group-1}
```