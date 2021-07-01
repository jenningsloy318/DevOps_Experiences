How to resolve packet loss issue
---

As applications running inside container, the network stack is much longer than usual,we need to analysize more aspects

- check the network config  of  container and the host
- check every layer of the network stack 
- link layer
  - `ethtool` or `netstat` to check packet loss count
  - `netstat -i` or `ethtool -S etho0`
  - check if there is QoS configured with `tc`, using `tc -s qdisc show dev eth0`
- network and transport layer
  - `netstatt -s` to check the summary of packet loss at each layer, it shows RX/TX summary for IP、ICMP、TCP、UDP protocol 
  - since this layer has too many points need to consider
  - check iptables conntrack and kernel related settings
    - `sysctl net.netfilter.nf_conntrack_max`
    - ` sysctl net.netfilter.nf_conntrack_count`
    - ` iptables -nvL` to check the summary of the rules
  - after each config/resolution, need to check if the packet loss still existing
  - use `tcpdump` to capture the packets, analysize the tcp 3-handshake
    - check if MTU issue