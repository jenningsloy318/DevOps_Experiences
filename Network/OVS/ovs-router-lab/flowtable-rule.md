
流表规则
---

- [修改流表命令](#修改流表命令)
- [流表匹配条件](#流表匹配条件)
  - [OVS匹配条件](#ovs匹配条件)
  - [OSI模型第二层(数据链路层)](#osi模型第二层数据链路层)
  - [OSI模型第三层(网络层)](#osi模型第三层网络层)
  - [OSI模型第四层(传输层)](#osi模型第四层传输层)
- [流表动作](#流表动作)
- [Links](#links)

# 修改流表命令
```
ovs-ofctl add−flow／add−flows／mod−flows “流表匹配条件,actions=[target][,target…]”
```
# 流表匹配条件
OVS 流表匹配条件较多，下面我将其分成四部分来说明，分别是:
  - OVS匹配条件 
  - OSI模型第二层(数据链路层) 
  - OSI模型第三层(网络层) 
  - OSI模型第四层(传输层) 
  
## OVS匹配条件
- in_port=port: 流量进入的端口编号或者名称，示例 in_port=br-int
- table=number: 规则保存的流表编号，范围是 0-254，默认值：0。

## OSI模型第二层(数据链路层)
- dl 即是 data link 的缩写。
- dl_type=ethertype,匹配以太网协议类型以太类型，以10到65535之间的整数（包括0和65535）指定，以十进制或以0x前缀的十六进制数表示，示例如下。
  -  dl_type=0x0800 匹配IPv4数据包，等同于dl_type=ip 。
  - dl_type=0x086dd 匹配IPv6数据包，等同于dl_type=ipv6 。
  - dl_type=0x0806 匹配ARP数据包，等同于dl_type=arp 。
  - dl_type=0x8035 匹配RARP数据包，等同于 dl_type=rarp。
- dl_vlan=vlan: 数据包的 VLAN Tag 值，范围是 0-4095，0xffff 代表不包含 VLAN Tag 的数据包
- dl_vlan_pcp=priority,VLAN 优先级，取值区间为[0-7]。数字越大，表示优先级越高。
- dl_src=xx:xx:xx:xx:xx:xx / dl_dst=xx:xx:xx:xx:xx:xx: 源或目的的 MAC地址
  - 地址01:00:00:00:00:00/01:00:00:00:00:00 代表广播
  - 地址00:00:00:00:00:00/01:00:00:00:00:00 代表单播
  - 地址fe:ff:ff:ff:ff:ff 匹配除多播位以外的所有位，基本上不会用到。
  - 地址ff:ff:ff:ff:ff:ff 完全匹配（等同于省略子网掩码）。
  - 地址00:00:00:00:00:00 匹配全部位（等同于 dl_dst=*）。


## OSI模型第三层(网络层)
- nw_src=ip[/netmask] / nw_dst=ip[/netmask]
  - 当指定 dl_type为0x0800 或者ip时，匹配源或者目标的 IPv4 地址，可以将其指定为IP地址或主机名，例如192.168.1.1或www.typesafe.cn。同时也可以写作192.168.1.0/255.255.255.0或者192.168.1.0/24的形式。
  - 当指定dl_type为0x0806或arp时，分别与IPv4和Ethernet的ARP数据包中的arp_spa或arp_tpa字段匹配。
  - 当指定dl_type为0x8035或rarp时，分别与IPv4和Ethernet的RARP数据包中的rarp_spa或rarp_tpa字段匹配。
  - 当指定dl_type为0x0800、0x0806或0x8035之外的其他值时，将忽略nw_src和nw_dst的值。
- nw_proto=proto / ipproto=proto
  - 如果指定ip或dl_type=0x0800，则匹配IP协议类型proto，该协议类型被指定为0到255之间的十进制数（包括1和0，用于包含ICMP数据包或6以匹配TCP数据包）。
  - 如果指定了ipv6或dl_type=0x86dd，则匹配IPv6标头类型原型，该形式指定为0到255之间的十进制数字（例如，包括58以匹配ICMPv6数据包或6以匹配TCP）。标头类型是设计文档中描述的终端标头。
  - 当指定arp或dl_type=0x0806时，与ARP操作码的低8位匹配。大于255的ARP操作码被视为0。
  - 指定rarp或dl_type=0x8035时，与ARP操作码的低8位匹配。大于255的ARP操作码被视为0。
  - 当通配符dl_type或将其设置为0x0800、0x0806、0x8035或0x86dd之外的其他值时，将忽略nw_proto的值（请参见上面的流语法）。
- nw_tos=tos
  - 匹配IP ToS / DSCP或IPv6流量类别字段tos，该字段tos指定为0到255之间的十进制数字（包括0和255）。请注意，出于匹配目的，将忽略两个较低的保留位。
  - 当通配符dl_type或将其设置为0x0800或0x86dd之外的其他值时，将忽略nw_tos的值。

- ip_dscp=dscp
  - 匹配IP ToS / DSCP或IPv6流量类字段dscp，该字段指定为介于0和63之间（含0和63）的十进制数。
  - 当通配符dl_type或将其设置为0x0800或0x86dd之外的其他值时，将忽略ip_dscp的值（请参见上面的流语法）。
- nw_ecn=ecn / ip_ecn=ecn 
  - 匹配IP ToS或IPv6流量类别字段中的ecn位，该ecn位指定为0到3（含0和3）之间的十进制数。当通配符dl_type或将其设置为0x0800或0x86dd之外的其他值时，将忽略nw_ecn的值（请参见上面的流语法）。
- nw_ttl=ttl
  - 匹配IP TTL或IPv6跃点限制值ttl，该值指定为0到255之间的十进制数字（包括0和255）。
  - 当通配符dl_type或将其设置为0x0800或0x86dd之外的其他值时，将忽略nw_ttl的值（请参见上面的流语法）。

## OSI模型第四层(传输层)

- tcp_src=port / tcp_dst=port / udp_src=port / udp_dst=port / sctp_src=port / sctp_dst=port
  - 匹配TCP，UDP或SCTP源端口或目标端口，端口号指定为0到65535（含0和65535）之间的十进制数。
  - 当通配符dl_type和nw_proto或将其设置为不表示适当协议的值时，这些设置的值将被忽略（请参见上面的流语法）。

- tcp_src=port/mask , tcp_dst=port/mask , udp_src=port/mask ,udp_dst=port/mask , sctp_src=port/mask ,  sctp_dst=port/mask
  - TCP（或UDP或SCTP）源或目标端口上的按位匹配。端口和掩码是16位数字，以十进制或十六进制写为0x。掩码中的每个1位要求端口中的相应位必须匹配。掩码中的每个0位都会导致忽略相应的位。
  - 传输端口上的按位匹配很少在隔离中有用，但是可以使用一组匹配项来减少在一系列传输端口上进行匹配所需的流数。例如，假设目标是将TCP源端口1000匹配到1999（含）。一种方法是插入1000个流，每个流在单个源端口上匹配。另一种方法是查看1000和1999的二进制表示形式，如下所示：
    ```
    01111101000
    11111001111
    ```
    然后将其转换为一系列按位匹配，以实现相同的结果：
    ```
    01111101xxx
    0111111xxxx
    10xxxxxxxxx
    110xxxxxxxx
    1110xxxxxxx
    11110xxxxxx
    1111100xxxx
    ```
    使用ovs-ofctl所需的语法编写时，这些内容如下：
    ```
    tcp,tcp_src=0x03e8/0xfff8
    tcp,tcp_src=0x03f0/0xfff0
    tcp,tcp_src=0x0400/0xfe00
    tcp,tcp_src=0x0600/0xff00
    tcp,tcp_src=0x0700/0xff80
    tcp,tcp_src=0x0780/0xffc0
    tcp,tcp_src=0x07c0/0xfff0
    ```
    仅Open vSwitch 1.6和更高版本支持传输端口上的按位匹配。与上述完全匹配形式一样，按位匹配形式仅在dl_type和nw_proto指定TCP或UDP或SCTP时适用。

- tp_src=port / tp_dst=port
  - 这些是L4端口匹配项已弃用的通用形式。在新代码中，请使用上述特定于TCP，UDP或SCTP的形式。
- tcp_flags=flags/mask , tcp_flags=[+flag...][-flag...]
  - TCP标志按位匹配。标志和掩码是16位数字，以十进制或以0x为前缀的十六进制表示。掩码中的每个1位要求标志中的相应位必须匹配。掩码中的每个0位都会导致忽略相应的位。或者，可以通过标志的符号名（在下面列出）来指定标志，每个标志名的前面都带有+，表示必须设置的标志，或者-表示必须取消设置的标志，且标志之间没有其他定界符。未提及的标志是通配符。例如，tcp，tcp_flags = + syn-ack匹配不是ACK的TCP SYN。 TCP协议当前定义9个标志位，并保留另外3个位（必须作为零发送），请参阅RFC 793、3168和3540。这些标志位的编号从最低有效位开始：
  - 0：fin 查找不再有来自发送方的数据。
  - 1：syn 同步同步序列号。
  - 2：rst 重置连接。
  - 3：psh 推送功能。
  - 4：ack 确认字段有效。
  - 5：urg 紧急指针字段有效。
  - 6：ece ECN回显。
  - 7：cer 减少拥塞窗口。
  - 8：ns 现时总和
  - 9-11：保留。
  - 12-15：不处理，必须为零。
- icmp_type=type /icmp_code=code
  - 当dl_type和nw_proto指定ICMP或ICMPv6时，type匹配ICMP类型，而代码匹配ICMP代码。每个参数都指定为介于0和255之间（含两端）的十进制数。
  - 当dl_type和nw_proto采用其他值时，这些设置的值将被忽略（请参见上面的流语法）。
- metadata=value[/mask]
  - 在元数据字段中完全匹配值或使用可选掩码匹配值。 value和mask是64位整数，默认情况下为十进制（使用0x前缀指定十六进制）。允许使用任意掩码值：掩码中的1位表示值中的对应位必须完全匹配，而该位则使用0位通配符。在Open vSwitch 1.8中添加了对元数据的匹配。
- ip 等同于dl_type=0x0800
- ipv6 等同于dl_type=0x86dd
- icmp 等同于dl_type=0x0800,nw_proto=1
- icmp6 等同于dl_type=0x86dd,nw_proto=58
- tcp 等同于dl_type=0x0800,nw_proto=6
- tcp6 等同于dl_type=0x86dd,nw_proto=6
- udp 等同于dl_type=0x0800,nw_proto=17
- udp6 等同于dl_type=0x86dd,nw_proto=17
- sctp 等同于dl_type=0x0800,nw_proto=132
- sctp6 等同于dl_type=0x86dd,nw_proto=132
- arp 等同于dl_type=0x0806
- rarp 等同于dl_type=0x8035
- mpls 等同于dl_type=0x8847
- mplsm 等同于dl_type=0x8848

- vlan_tci=tci[/mask]
  - 匹配修改后的VLAN TCI tci。如果省略mask，则tci是要匹配的确切VLAN TCI；如果指定了mask，则mask中的1位表示tci中的对应位必须完全匹配，而0位通配符表示该位。 tci和mask均为16位值，默认情况下为十进制。使用0x前缀以十六进制指定它们。
  - 对于没有802.1Q标头的数据包，vlan_tci与之匹配的值为0。否则，它是802.1Q标头中的TCI值，其中CFI位（值为0x1000）被强制为1。
    - vlan_tci=0 仅匹配没有802.1Q标头的数据包。
    - vlan_tci=0xf123  匹配VLAN 0x123中标记为优先级7的数据包。
    - vlan_tci=0x1123/0x1fff 匹配标记有VLAN 0x123（和任何优先级）的数据包。
    - vlan_tci=0x5000/0xf000 匹配标记为优先级2的数据包（在任何VLAN中）。
    - vlan_tci=0/0xfff 匹配没有802.1Q标头或带有VLAN 0（和任何优先级）标记的数据包。
    - vlan_tci=0x5000/0xe000 匹配没有802.1Q标头或带有优先级2标记的数据包（在任何VLAN中）。
    - vlan_tci=0/0xefff 匹配没有802.1Q标头或带有VLAN 0和优先级0标记的数据包。
  - 使用dl_vlan和dl_vlan_pcp也可以实现某些匹配可能性
- ip_frag=frag_type
  - dl_type指定IP或IPv6时，frag_type指定要匹配的IP片段或非片段类型。支持以下frag_type值：
    - no 仅匹配非分段数据包。
    - yes 匹配所有片段。
    - first 仅匹配偏移量为0的片段。
    - later 仅匹配非零偏移量的片段。
    - not_later 匹配零碎的非碎片数据包和碎片。
- arp_spa=ip[/netmask] , arp_tpa=ip[/netmask]
  - 当dl_type指定ARP或RARP时，arp_spa和arp_tpa分别与源和目标IPv4地址匹配。可以将地址指定为IP地址或主机名（例如192.168.1.1或www.example.com）。可选的网络掩码允许将匹配限制为IPv4地址前缀。网络掩码可以指定为点分四边形（例如192.168.1.0/255.255.255.0）或CIDR块（例如192.168.1.0/24）。

- arp_sha=xx:xx:xx:xx:xx:xx , arp_tha=xx:xx:xx:xx:xx:xx
  - 当dl_type指定ARP或RARP时，arp_sha和arp_tha分别匹配源和目标硬件地址。地址指定为以冒号分隔的6对十六进制数字（例如00:0A:E4:25:6B:B0）。

- arp_sha=xx:xx:xx:xx:xx:xx/xx:xx:xx:xx:xx:xx ,arp_tha=xx:xx:xx:xx:xx:xx/xx:xx:xx:xx:xx:xx
  - 当dl_type指定ARP或RARP时，arp_sha和arp_tha分别匹配源和目标硬件地址。地址指定为以冒号分隔的6对十六进制数字（例如00:0A:E4:25:6B:B0），并在斜杠后加上通配符掩码。

- arp_op=opcode
  - 当dl_type指定ARP或RARP时，arp_op与ARP操作码匹配。只能指定1到255之间的ARP操作码进行匹配。

- ipv6_src=ipv6[/netmask] , ipv6_dst=ipv6[/netmask]
  - 当dl_type为0x86dd时（可能通过简写形式，例如ipv6或tcp6），匹配IPv6源（或目标）地址ipv6，该地址可以按RFC 2373中的规定指定。首选格式为x:x:x:x:x:x:x:x，其中x是地址的八个16位块的十六进制值。 ::的单个实例可用于指示16位零的多个组。可选的网络掩码允许将匹配限制为IPv6地址前缀。网络掩码被指定为IPv6地址（例如2001:db8:3c4d:1::/ffff:ffff:ffff:ffff::)或CIDR块（例如2001:db8:3c4d:1::/64）。打开vSwitch 1.8及更高版本，支持仲裁掩码；早期版本仅支持CIDR掩码，即CIDR块和等同于CIDR块的IPv6地址。
- ipv6_label=label
  - 当dl_type为0x86dd时（可能通过简写形式，例如ipv6或tcp6），匹配IPv6流标签label。

- tun_id=tunnel-id[/mask], tunnel_id=tunnel-id[/mask]
  - 匹配隧道标识符tunnel-id。只有通过带有密钥的隧道到达的数据包（例如具有RFC 2890密钥扩展名和非零密钥值的GRE）才会具有非零的隧道ID。如果省略mask，则tunnel-id是要匹配的确切隧道ID；如果指定了mask，则mask中的1位表示tunnel-id中的相应位必须完全匹配，而0位通配符则将该位匹配。
- tun_flags=flags
  - 匹配标志，指示隧道封装的各个方面。当前，仅定义一个标志：
    - oma 隧道协议指示这是一个OAM控制数据包。
  - 可以在标志前面加上+或-来分别指示该标志应匹配为存在或不存在。另外，可以指定没有前缀的标志，并用|分隔。表示完全匹配。
  - 请注意，较新版本的Open vSwitch可能会引入具有不同含义的其他标志。因此，不建议在此字段上使用完全匹配，因为这些新标志的行为是未知的，应忽略。
  - 对于非隧道数据包，该值为0。
  - 此字段是在Open vSwitch 2.5中引入的。

- tun_src=ip[/netmask], tun_dst=ip[/netmask]
  - 匹配隧道IPv4源（或目标）地址ip。仅通过隧道到达的数据包将具有非零的隧道地址。该地址可以指定为IP地址或主机名（例如192.168.1.1或www.example.com）。可选的网络掩码允许将匹配限制为被掩码的IPv4地址。子网掩码可以指定为点分四边形（例如192.168.1.0/255.255.255.0）或CIDR块（例如192.168.1.0/24）。
- ipv6 等同于dl_type=0x86dd

- tcp6 等同于dl_type=0x86dd,nw_proto=6

- udp6 等同于dl_type=0x86dd,nw_proto=17

- sctp6 等同于dl_type=0x86dd,nw_proto=132

- icmp6 等同于dl_type=0x86dd,nw_proto=58

# 流表动作

- output:port 将数据包输出到OpenFlow端口号port。如果port是数据包的输入端口，则不输出数据包。
- group:group_id 将数据包输出到OpenFlow组group_id。仅OpenFlow 1.1+支持组表。有关更多详细信息，请参见组语法。
- normal 使数据包经过设备的常规L2 / L3处理。 （并非所有OpenFlow交换机都执行此操作。）
- flood 在所有交换机物理端口上输出数据包，而不是在接收数据包的端口以及任何禁用洪泛的端口上进行输出（通常，这些端口是IEEE 802.1D生成树协议禁用的端口）。
- all 在所有交换机物理端口上输出数据包，而不是在接收数据包的端口上。
- local 在与本地网桥名称相同的网络设备对应的``本地端口''上输出数据包,数据包从此端口出会进入Host的网络栈
- in_port 在接收数据包的端口上输出数据包。
- enqueue(port,queue) 将数据包放入端口port中的指定队列中，该队列必须是OpenFlow端口号或关键字（例如LOCAL）。支持的队列数取决于交换机；具体取决于交换机。一些OpenFlow实现根本不支持排队。
- drop 丢弃数据包，因此不会进行进一步的处理或转发。如果使用丢弃动作，则不能指定其他动作。
- mod_vlan_vid:vlan_vid 修改报文的VLAN ID。根据需要添加或修改VLAN标记以匹配指定的值。如果添加了VLAN标记，则使用零优先级（请参阅mod_vlan_pcp操作来设置此优先级）。
- mod_vlan_pcp:vlan_pcp 修改报文的VLAN优先级。根据需要添加或修改VLAN标记以匹配指定的值。有效值介于0（最低）和7（最高）之间。如果添加了VLAN标记，则使用的vid为零（请参阅mod_vlan_vid操作进行设置）。

- strip_vlan 从数据包中剥离VLAN标记（如果存在）。
- push_vlan:ethertype 将新的VLAN标签推入数据包。以太网类型用作标签的以太网类型。仅应使用ethertype 0x8100。 （目前尚不支持规范允许的0x88a8。）新标签使用优先级为零且标签为零。

- mod_dl_src:mac 将源以太网地址设置为mac。

- mod_dl_dst:mac 将目标以太网地址设置为mac。

- mod_nw_src:ip 将IPv4源地址设置为ip。

- mod_nw_dst:ip 将IPv4目标地址设置为ip。

- mod_tp_src:port 将TCP或UDP或SCTP源端口设置为port。

- mod_tp_dst:port 将TCP或UDP或SCTP目标端口设置为port。

- mod_nw_tos:tos 将IPv4 ToS / DSCP或IPv6流量类字段中的DSCP位设置为tos，该值必须为0到255之间的4的倍数。此操作不会修改ToS字段的两个最低有效位（ECN位）。

- mod_nw_ecn:ecn 将IPv4 ToS或IPv6流量类别字段中的ECN比特设置为ecn，该值必须介于0和3之间（包括0和3）。此操作不会修改该字段的六个最高有效位（DSCP位）。需要OpenFlow 1.1或更高版本。

- mod_nw_ttl:ttl 将IPv4 TTL或IPv6跳数限制字段设置为ttl，指定为0到255之间的十进制数（包括0和255）。但是，没有很好地指定将ttl设置为零时的开关行为。
需要OpenFlow 1.1或更高版本。

- resubmit:port ,resubmit([port],[table]) 重新搜索此OpenFlow流表（或由表指定其编号的表），用in_port字段替换为端口（如果指定了port），并执行找到的操作（如果有），以及此流条目中的任何其他操作。

- set_tunnel:id, set_tunnel64:id
  - 如果输出到将数据包封装在隧道中并支持标识符（例如GRE）的端口，则将标识符设置为id。如果使用set_tunnel形式，并且id可以容纳32位，则此操作将使用Open vSwitch 1.0和更高版本支持的操作扩展。否则，如果id是64位值，则需要Open vSwitch 1.1或更高版本。

- set_queue:queue 设置输出数据包时应用于排队的队列。支持的队列数取决于交换机；具体取决于交换机。一些OpenFlow实现根本不支持排队。

- pop_queue 将队列恢复为应用任何set_queue操作之前的值。

- move:src[start..end]->dst[start..end]
 - 将已命名的位从字段src复制到字段dst。 src和dst必须是nicira-ext.h中定义的NXM字段名称，例如NXM_OF_UDP_SRC或NXM_NX_REG0。每个开始和结束对（包括首尾对）必须指定相同的位数，并且必须适合其各自的字段。存在[start..end]的简写形式：使用[bit]指定单个位，或使用[]指定整个字段。

- set_field:value[/mask]->dst, load:value−>dst[start..end]
  - 将文字值加载到字段或字段的一部分中。对于set_field，在字段dst的惯用语法中给出了值和可选掩码，表示为字段名。例如，set_field：00：11：22：33：44：55-> eth_src将以太网源地址设置为00：11：22：33：44：55。加载时，值必须是整数值（十进制或以0x开头的十六进制前缀），而dst是该字段的NXM或OXM名称。例如，load：0x001122334455-> OXM_OF_ETH_DST []与前面的set_field示例具有相同的效果。

  - 出于历史原因，存在这两种形式。 Open vSwitch 1.1引入了NXAST_REG_LOAD作为OpenFlow 1.0的Nicira扩展，并使用load来表达它。后来，Open-Flow 1.2引入了一个标准的OFPAT_SET_FIELD操作，该操作仅限于加载整个字段，因此Open vSwitch添加了具有此限制的表单set_field。 OpenFlow 1.5将OFPAT_SET_FIELD扩展到了它成为NXAST_REG_LOAD的超集的地步。 Open vSwitch会根据所使用的OpenFlow版本转换两种语法：OpenFlow 1.0和1.1中的NXAST_REG_LOAD；在OpenFlow 1.2、1.3和1.4中，NXAST_REG_LOAD用于加载或加载子字段，否则为OFPAT_SET_FIELD； OpenFlow 1.5及更高版本，OFPAT_SET_FIELD。

- push:src[start..end] 在堆栈顶部的字段中，压入开始（包括结束）位。

  - 示例：push：NXM_NX_REG2 [0..5]将存储在寄存器2位0到5（含0和5）中的值压入内部堆栈。

- pop:dst[start..end]
  - 从堆栈的顶部弹出，从弹出的值中检索包含开始到结束的位，并将它们存储在dst中的相应位中。

  - 示例：pop：NXM_NX_REG2 [0..5]从堆栈顶部弹出该值。根据刚刚弹出的值的0至5位，将寄存器2的0至5位（包括0和5）设置为1。

- multipath(fields,basis,algorithm,n_links,arg,dst[start..end])
  - 使用base作为通用哈希参数对字段进行哈希处理，然后应用多路径链接选择算法（带有参数arg）从0到n_links减去1来选择n_links输出链接之一，并将链接存储到dst [start..end]中，它必须是如上所述的NXM字段。










# Links
- https://www.openvswitch.org/support/dist-docs-2.5/ovs-ofctl.8.txt