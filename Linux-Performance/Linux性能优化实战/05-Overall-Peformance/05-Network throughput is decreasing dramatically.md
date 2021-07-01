Network throughput is decreasing dramatically
---

Lab:
- client: 
  ```
  wrk --latency -c 1000 http://192.168.0.30
  ```
  but the throughput is only 189, but all 1910 responses codes are not 2xx or 3xx
- server: nginx + php-fpm

Analysize:

- check TCP connection 
  ``
  ss -s
  ```
  - established  -- very few
  - timewait  -- too many
  - closed  -- too many 
- check `dmesg`
  ```
  dmesg |tail 
  [88356.354329] nf_conntrack: nf_conntrack: table full, dropping packet
  [88356.354374] nf_conntrack: nf_conntrack: table full, dropping packet
  ```
  - check the kernel parameter regarding conntrack
    ```
    $ sysctl net.netfilter.nf_conntrack_max
    net.netfilter.nf_conntrack_max = 200
    $  sysctl net.netfilter.nf_conntrack_count
    net.netfilter.nf_conntrack_count = 200
    ```
  - increase ` nf_conntrack_max`
    ```
    $ sysctl -w net.netfilter.nf_conntrack_max=1048576
    ```
- nginx log shows `499` error 
- fpm log shows `server reached max_children setting (5)`, suggest to increase `max_children`, generally each fpm process will consume 20M memory, increase count according to the amount of memory
-   we can check the socket loss twice 
  ```
  netstat -s | grep socket
  ```
  shows  `socket overflowed` and `sockets dropped` too much socket packet loss

- check socket size 
  ```
  ss -ltnp
  ```
  -  both nginx and fpm , Send-Q is 10 
  -  nginx Recv-Q is  full  and fpm Recv-Q is almost full
  - when the state is `Listen`, and `Send-Q` and `Recv-Q`  are semi-connecion, try to increase `tcp_max_syn_backlog` and monitor
  - check queue setting in nginx 
    ```
    $cat /etc/nginx/nginx.conf | grep backlog
     listen 80 backlog=10;
    ```
  - and check queue setting in fpm
    ```
    $cat /opt/bitnami/php/etc/php-fpm.d/www.conf | grep backlog
    ```
  - check system wide queue setting
    ```
    $ sysctl net.core.somaxconn
    net.core.somaxconn = 10
    ```
  - increase the nginx/fpm queue setting to 8192, and set `net.core.somaxconn` to `65536`
  - check if there is socket packet loss `netstat -s | grep socket`
- nginx log show another error
  
  ```connect() to 127.0.0.1:9000 failed (99: Cannot assign requested address) while connecting to upstream, client: 192.168.0.2, server: localhost, request: "GET / HTTP/1.1", upstream: "fastcgi://127.0.0.1:9000", host: "192.168.0.30"```
  - indicates that this is port number error that can't be allocated or assigned properlly when nginx trying to connect to fpm
  - check the port range that nginx can use 
    ```
    $ sysctl net.ipv4.ip_local_port_range
    net.ipv4.ip_local_port_range=20000 20050
    ```
    the range is too limted, increase it
    ```
    $ sysctl -w net.ipv4.ip_local_port_range="10000 65535"
    net.ipv4.ip_local_port_range = 10000 65535
    ```
- no error found, check the overall system load with `top`
- analysize with `perf record -g`
- create flamegraph `perf script -i ~/perf.data | ./stackcollapse-perf.pl --all | ./flamegraph.pl > nginx.svg`
- identified the bottleneck with flamegraph
- `inet_hash_connect()` is probably is the root cause, 
- `__init_check_established` this function is to check the port is available, consider **if there is too many ports are allocated and not released, this may cause high cpu usage**, then we can check the network connection 
- `ss -s`: `timewait` will prevent the port reuse, if it can be reused, time consuming on ``__init_check_established`` should be decreasing
- check this `tcp_tw_reuse`, 
  ```

  $ sysctl net.ipv4.tcp_tw_reuse
  net.ipv4.tcp_tw_reuse = 0
  ```
  enable it 
  ```
  sysctl -w net.ipv4.tcp_tw_reuse = 1
  ```