#!/bin/bash
ovs-vsctl add-br sw0 -- set bridge sw0  protocols=OpenFlow13
ovs-vsctl get bridge sw0 datapath_id
# the output is 00004a9f1f0e8948, we add prefix 0x at the beginning then copy 0x00004a9f1f0e8948 to faucet.yaml to set the dp_id
ovs-vsctl set-fail-mode sw0 secure
ovs-vsctl set-controller sw0 tcp:127.0.0.1:6653

