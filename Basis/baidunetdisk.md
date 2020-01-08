默认情况下,在Fedora 31安装完成百度网盘linux版3.0.1后运行会报以下错误

```
# baidunetdisk 
(node:5623) ExperimentalWarning: The dns.promises API is experimental
Fontconfig warning: "/usr/share/fontconfig/conf.avail/05-reset-dirs-sample.conf", line 6: unknown element "reset-dirs"
get_adapter_mac interface num = 3
get_adapter_mac mac=525400083aa7
CreatePCGuid::get_cpu_id 0000000D6874754169746E65444D4163
browser engine version: 1.0.0.2
Segmentation fault
```

通过gdb进行分析

```
# gdb /opt/baidunetdisk/baidunetdisk  
(gdb) r
Starting program: /opt/baidunetdisk/baidunetdisk 
Missing separate debuginfos, use: dnf debuginfo-install baidunetdisk-3.0.1-1.x86_64
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
[New Thread 0x7fffe757a700 (LWP 5940)]
[Detaching after fork from child process 5941]
[New Thread 0x7fffe6d79700 (LWP 5942)]
[New Thread 0x7fffe64fb700 (LWP 5943)]
[New Thread 0x7fffe5cfa700 (LWP 5944)]
[New Thread 0x7fffe54f9700 (LWP 5945)]
[New Thread 0x7fffe4cf8700 (LWP 5946)]
[New Thread 0x7fffe44f7700 (LWP 5947)]
[New Thread 0x7ffff7b23700 (LWP 5948)]
(node:5936) ExperimentalWarning: The dns.promises API is experimental
Fontconfig warning: "/usr/share/fontconfig/conf.avail/05-reset-dirs-sample.conf", line 6: unknown element "reset-dirs"
[New Thread 0x7fffe0de9700 (LWP 5949)]
[New Thread 0x7fffe05e8700 (LWP 5950)]
[New Thread 0x7fffdfde7700 (LWP 5951)]
[New Thread 0x7fffdfdde700 (LWP 5952)]
[New Thread 0x7fffdf5dd700 (LWP 5953)]
[New Thread 0x7fffdeddc700 (LWP 5954)]
[New Thread 0x7fffde5db700 (LWP 5955)]
[New Thread 0x7fffdddda700 (LWP 5956)]
[New Thread 0x7fffdd5d9700 (LWP 5957)]
[New Thread 0x7fffdcdd8700 (LWP 5958)]
[New Thread 0x7fffdc5d7700 (LWP 5959)]
[New Thread 0x7fffdbdd6700 (LWP 5960)]
[New Thread 0x7fffdb5d5700 (LWP 5961)]
[New Thread 0x7fffdadd4700 (LWP 5962)]
[New Thread 0x7fffda5d3700 (LWP 5963)]
[New Thread 0x7fffd9c15700 (LWP 5964)]
[Detaching after fork from child process 5965]
XDG_RUNTIME_DIR (/run/user/1000) is not owned by us (uid 0), but by uid 1000! (This could e.g. happen if you try to connect to a non-root PulseAudio as a root user, over the native protocol. Don't do that.)
[New Thread 0x7fffd9297700 (LWP 5966)]
[New Thread 0x7fffd8a96700 (LWP 5967)]
[New Thread 0x7fffd8295700 (LWP 5968)]
[New Thread 0x7fffd7a94700 (LWP 5969)]
get_adapter_mac interface num = 3
get_adapter_mac mac=525400083aa7
CreatePCGuid::get_cpu_id 0000000D6874754169746E65444D4163
browser engine version: 1.0.0.2
[New Thread 0x7fffd7270700 (LWP 5976)]
[New Thread 0x7fffd6a6f700 (LWP 5977)]
[New Thread 0x7fffd626e700 (LWP 5978)]

Thread 1 "baidunetdisk" received signal SIGSEGV, Segmentation fault.
0x00007ffff559fb56 in EVP_CIPHER_CTX_reset () from /lib64/libcrypto.so.1.1
```
可以看到在运行到` /lib64/libcrypto.so.1`时候报错,结合网上说18.04运行正常,故推测是该库的问题,故下载ubuntu 18.04的 `libcrypto++6_5.6.4-8_amd64.deb` 解压后 复制 `libcrypto++.so.6` 到 `/opt/baidunetdisk/libcrypto.so.1.1`

再次运行也报错

```
# baidunetdisk 
baidunetdisk: /opt/baidunetdisk/./libcrypto.so.1.1: no version information available (required by /lib64/libk5crypto.so.3)
baidunetdisk: symbol lookup error: /lib64/libk5crypto.so.3: undefined symbol: Camellia_cbc_encrypt, version OPENSSL_1_1_0
```
故又下载 下载ubuntu 18.04的 `libk5crypto3_1.16-2build1_amd64.deb`, 解压后将`libk5crypto.so.3.1`复制到`/opt/baidunetdisk/libk5crypto.so.3`

再次运行, 成功启动并未报错.

