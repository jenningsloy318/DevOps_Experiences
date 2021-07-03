#!/bin/bash
ovs-vsctl add-br sw0 -- set bridge sw0  protocols=OpenFlow13
ovs-vsctl get bridge sw0 datapath_id
# the output is 00004a9f1f0e8948, we add prefix 0x at the beginning then copy 0x00004a9f1f0e8948 to faucet.yaml to set the dp_id
ovs-vsctl set-fail-mode sw0 secure
ovs-vsctl set-controller sw0 tcp:127.0.0.1:6653

ovs-vsctl add-port sw0 vlan10-01 tag=10 -- set interface vlan10-01 type=internal 
ovs-vsctl add-port sw0 vlan20-01 tag=20 -- set interface vlan20-01 type=internal 
ovs-vsctl add-port sw0 vlan30-01 tag=30 -- set interface vlan30-01 type=internal 
ovs-vsctl add-port sw0 vlan40-01 tag=40 -- set interface vlan40-01 type=internal 

# dump flows, since we set the protocol in previous step, here we still need to set it
ovs-ofctl dump-flows sw0 --protocols=OpenFlow13