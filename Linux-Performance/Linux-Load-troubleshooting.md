Tools:
- `stress/stress-ng` 是一个施加系统压力和压力测试系统的工具，我们可以使用`stress/stree-ng`工具压测试 CPU，以便方便我们定位和排查 CPU 问题。

    ```
    stress 命令使用

    // --cpu 8：8个进程不停的执行sqrt()计算操作

    // --io 4：4个进程不同的执行sync()io操作（刷盘）

    // --vm 2：2个进程不停的执行malloc()内存申请操作

    // --vm-bytes 128M：限制1个执行malloc的进程申请内存大小

    # stress --cpu 8 --io 4 --vm 2 --vm-bytes 128M --timeout 10s

    ```
- `sysstat`,包含多种分析工具





# 系统平均负载高
##  CPU 问题排查
- 模拟系统负载
    ```
    stress-ng -c 1
    ```
- uptime：使用uptime查看此时系统负载：
    ```
    uptime
    10:26:28 up 7 days, 19:13,  7 users,  load average: 4.51, 1.49, 0.52
    ```
    此时 Load1 > load5 load15,说明系统负载正在上升

    ```
    watch -d uptime 
    ```
- mpstat：使用`mpstat -P ALL 1`则可以查看每一秒的 CPU 每一核变化信息, 可以把每一秒（自定义）的数据输出方便观察数据的变化，最终输出平均数据

```
# mpstat -P ALL 1
10:31:13 AM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
10:31:14 AM  all   16.47    0.00    0.00    0.17    0.17    0.00    0.00    0.00    0.00   83.19
10:31:14 AM    0    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
10:31:14 AM    1    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
10:31:14 AM    2    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
10:31:14 AM    3    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
10:31:14 AM    4   99.00    0.00    0.00    0.00    1.00    0.00    0.00    0.00    0.00    0.00
10:31:14 AM    5    0.00    0.00    0.00    0.99    0.00    0.00    0.00    0.00    0.00   99.01
```
由以上输出可以得出结论，当前系统负载升高，并且其中 1 个核跑满主要在执行用户态任务，此时大多数属于业务工作。所以此时需要查哪个进程导致单核 CPU 跑满：


- pidstat：使用`pidstat -u 1`则是每隔 1 秒输出当前系统进程、CPU 数据：
```
# pidstat -u 1
Linux 5.7.11-200.fc32.x86_64 (fedora.lmy.com)   08/21/2020      _x86_64_        (6 CPU)

10:32:50 AM   UID       PID    %usr %system  %guest   %wait    %CPU   CPU  Command
10:32:51 AM     0    786761    0.00    0.99    0.00    0.00    0.99     4  kworker/4:1-mm_percpu_wq
10:32:51 AM     0    786791   99.01    0.00    0.00    0.00   99.01     1  stress-ng-cpu
10:32:51 AM     0    786837    0.00    0.99    0.00    0.00    0.99     0  pidstat
```

- top：当然最方便的还是使用top命令查看负载情况：
```
# top
top - 10:34:22 up 7 days, 19:21,  7 users,  load average: 4.51, 1.49, 0.52
Tasks: 239 total,   2 running, 237 sleeping,   0 stopped,   0 zombie
%Cpu(s): 16.6 us,  0.1 sy,  0.0 ni, 83.2 id,  0.1 wa,  0.1 hi,  0.0 si,  0.0 st
MiB Mem :  34348.6 total,  11427.2 free,    936.4 used,  21985.0 buff/cache
MiB Swap:      0.0 total,      0.0 free,      0.0 used.  32896.7 avail Mem

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
 786791 root      20   0   57432   6816   3576 R  99.0   0.0   3:15.60 stress-ng-cpu
    672 root      20   0  174256   8680   7268 S   0.3   0.0   4:56.41 vmtoolsd
  10351 jenning+  20   0   11964   4300   3888 S   0.3   0.0   1:14.65 redshift
 547583 root      20   0  244976  58488  38264 S   0.3   0.2   1:42.51 Xorg
      1 root      20   0  179948  14576   9460 S   0.0   0.0   0:11.06 systemd
      2 root      20   0       0      0      0 S   0.0   0.0   0:00.43 kthreadd
      3 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 rcu_gp
      4 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 rcu_par_gp
      6 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker/0:0H-kblockd
      9 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 mm_percpu_wq
     10 root      20   0       0      0      0 S   0.0   0.0   0:01.16 ksoftirqd/0
     11 root      20   0       0      0      0 I   0.0   0.0   0:52.54 rcu_sched
     12 root      rt   0       0      0      0 S   0.0   0.0   0:00.69 migration/0
     13 root      20   0       0      0      0 S   0.0   0.0   0:00.00 cpuhp/0
     14 root      20   0       0      0      0 S   0.0   0.0   0:00.00 cpuhp/1
     15 root      rt   0       0      0      0 S   0.0   0.0   0:01.22 migration/1
     16 root      20   0       0      0      0 S   0.0   0.0   0:01.03 ksoftirqd/1
     18 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker/1:0H-kblockd
     19 root      20   0       0      0      0 S   0.0   0.0   0:00.00 cpuhp/2
     20 root      rt   0       0      0      0 S   0.0   0.0   0:01.08 migration/2
     21 root      20   0       0      0      0 S   0.0   0.0   0:01.12 ksoftirqd/2
     23 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker/2:0H-kblockd
     24 root      20   0       0      0      0 S   0.0   0.0   0:00.00 cpuhp/3
     25 root      rt   0       0      0      0 S   0.0   0.0   0:01.19 migration/3
     26 root      20   0       0      0      0 S   0.0   0.0   0:01.08 ksoftirqd/3
     28 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker/3:0H-kblockd
     29 root      20   0       0      0      0 S   0.0   0.0   0:00.00 cpuhp/4
     30 root      rt   0       0      0      0 S   0.0   0.0   0:01.24 migration/4
     31 root      20   0       0      0      0 S   0.0   0.0   0:01.08 ksoftirqd/4
     33 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker/4:0H-kblockd
     34 root      20   0       0      0      0 S   0.0   0.0   0:00.00 cpuhp/5
     35 root      rt   0       0      0      0 S   0.0   0.0   0:01.22 migration/5
     36 root      20   0       0      0      0 S   0.0   0.0   0:01.44 ksoftirqd/5
     38 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker/5:0H-kblockd
     39 root      20   0       0      0      0 S   0.0   0.0   0:00.00 kdevtmpfs
     40 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 netns
     41 root      20   0       0      0      0 S   0.0   0.0   0:00.00 rcu_tasks_kthre
     42 root      20   0       0      0      0 S   0.0   0.0   0:00.12 kauditd
     44 root      20   0       0      0      0 S   0.0   0.0   0:00.00 oom_reaper
     45 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 writeback
     46 root      20   0       0      0      0 S   0.0   0.0   0:00.39 kcompactd0
     47 root      25   5       0      0      0 S   0.0   0.0   0:00.00 ksmd
     48 root      39  19       0      0      0 S   0.0   0.0   0:00.00 khugepaged
     63 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 cryptd
    109 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kintegrityd
    110 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kblockd
    111 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 blkcg_punt_bio
    112 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 tpm_dev_wq
    113 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 ata_sff
    114 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 md
    115 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 edac-poller
```


此时可以看到是stress占用了很高的 CPU。



## IO 问题排查

- 模拟IO负载,我们使用`stress-ng -i 1 --hdd 1 --timeout 600`来模拟 IO 瓶颈问题，即死循环执行 sync 刷盘操作
    ```
    stress-ng -i 1 --hdd 10 --timeout 600
    ```


- uptime：使用uptime查看此时系统负载：
    ```
    watch -d uptime 

    uptime
    10:39:45 up 1 min,  2 users,  load average: 1.85, 0.67, 0.24
    ```

    此时 Load1 > load5 load15,说明系统负载正在上升


- mpstat: 
    ```
    # mpstat -P ALL 1

    10:40:56 AM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
    10:40:57 AM  all    0.34    0.00   27.82    1.54    0.68    0.17    0.00    0.00    0.00   69.45
    10:40:57 AM    0    1.98    0.00   97.03    0.00    0.99    0.00    0.00    0.00    0.00    0.00
    10:40:57 AM    1    0.00    0.00    0.00    0.00    3.00    0.00    0.00    0.00    0.00   97.00
    10:40:57 AM    2    0.00    0.00   17.24    9.20    0.00    0.00    0.00    0.00    0.00   73.56
    10:40:57 AM    3    0.00    0.00   51.02    1.02    0.00    1.02    0.00    0.00    0.00   46.94
    10:40:57 AM    4    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
    10:40:57 AM    5    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
    ```
    查看此时 IO 消耗，但是实际上我们发现这里 CPU 基本都消耗在了 sys 即系统消耗上, 即一直处于等待中，负载没有发生在CPU本身这里，应该是其他的地方； 然后`iowait` 也在不断的上升中，说明IO一直处于等待中


-  pidstat 先还是查看一下CPU情况
```
#   pidstat -u 1

10:55:39 AM   UID       PID    %usr %system  %guest   %wait    %CPU   CPU  Command
10:55:40 AM     0       561    0.00    2.00    0.00    4.00    2.00     1  kworker/1:1H-kblockd
10:55:40 AM     0       677    0.00    1.00    0.00    0.00    1.00     2  vmtoolsd
10:55:40 AM   985       992    1.00    0.00    0.00    0.00    1.00     5  ukui-greeter
10:55:40 AM     0      1061    0.00   29.00    0.00    1.00   29.00     1  kworker/u256:4-xfs-cil/sda1
10:55:40 AM     0      1737    0.00   15.00    0.00    1.00   15.00     1  kworker/1:0-xfs-conv/sda1
10:55:40 AM     0      1778    1.00   25.00    0.00    0.00   26.00     2  stress-ng-io
10:55:40 AM     0      1779    1.00  100.00    0.00    0.00  101.00     4  stress-ng-hdd
10:55:40 AM     0      1804    0.00    1.00    0.00    0.00    1.00     0  pidstat
```
此时可以看到是`stress-ng-hdd` 占用了100%的 系统时间，且CPU使用了已经101%了，说明罪魁祸首就是它


-  pidstat 再查看一下IO情况
```
#  pidstat -d 1

10:59:01 AM   UID       PID   kB_rd/s   kB_wr/s kB_ccwr/s iodelay  Command
10:59:02 AM     0      1778      0.00      0.00      0.00      38  stress-ng-io
10:59:02 AM     0      1779      0.00 1275057.43      0.00       0  stress-ng-hdd
```
此时看到`stress-ng-hdd` 有大量的写操作，问题应该就是再这里


## 进程数过多问题排查

- 模拟

进程数过多这个问题比较特殊，如果系统运行了很多进程超出了 CPU 运行能，就会出现等待 CPU 的进程。使用`stress -c 24`来模拟执行 24 个进程（我的 CPU 是 6 核）

- uptime：
```
# uptime
 11:08:47 up 30 min,  3 users,  load average: 21.90, 14.01, 16.79
```

- mpstat
```
# mpstat -P ALL 1

11:09:40 AM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
11:09:41 AM  all   99.34    0.00    0.00    0.00    0.66    0.00    0.00    0.00    0.00    0.00
11:09:41 AM    0   99.00    0.00    0.00    0.00    1.00    0.00    0.00    0.00    0.00    0.00
11:09:41 AM    1   99.01    0.00    0.00    0.00    0.99    0.00    0.00    0.00    0.00    0.00
11:09:41 AM    2  100.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00
11:09:41 AM    3   99.01    0.00    0.00    0.00    0.99    0.00    0.00    0.00    0.00    0.00
11:09:41 AM    4   99.00    0.00    0.00    0.00    1.00    0.00    0.00    0.00    0.00    0.00
11:09:41 AM    5  100.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00
```


- pidstat
```
#   pidstat -u 1
Average:      UID       PID    %usr %system  %guest   %wait    %CPU   CPU  Command
Average:        0       959    0.00    0.25    0.00    0.00    0.25     -  Xorg
Average:        0      1033    0.00    0.50    0.00    0.00    0.50     -  sshd
Average:        0      2252    0.00    0.25    0.00    0.00    0.25     -  kworker/u256:0-events_unbound
Average:        0      2337   23.44    0.00    0.00   76.56   23.44     -  stress-ng-cpu
Average:        0      2338   24.19    0.00    0.00   75.81   24.19     -  stress-ng-cpu
Average:        0      2339   23.44    0.00    0.00   76.56   23.44     -  stress-ng-cpu
Average:        0      2340   24.19    0.00    0.00   75.56   24.19     -  stress-ng-cpu
Average:        0      2341   23.44    0.00    0.00   76.56   23.44     -  stress-ng-cpu
Average:        0      2342   23.69    0.00    0.00   76.31   23.69     -  stress-ng-cpu
Average:        0      2343   24.44    0.00    0.00   75.31   24.44     -  stress-ng-cpu
Average:        0      2344   30.67    0.00    0.00   68.83   30.67     -  stress-ng-cpu
Average:        0      2345   24.19    0.00    0.00   75.56   24.19     -  stress-ng-cpu
Average:        0      2346   25.44    0.00    0.00   73.82   25.44     -  stress-ng-cpu
Average:        0      2347   24.44    0.00    0.00   75.81   24.44     -  stress-ng-cpu
Average:        0      2348   24.69    0.00    0.00   75.31   24.69     -  stress-ng-cpu
Average:        0      2349   24.19    0.00    0.00   75.56   24.19     -  stress-ng-cpu
Average:        0      2350   23.19    0.00    0.00   76.31   23.19     -  stress-ng-cpu
Average:        0      2351   23.19    0.00    0.00   76.56   23.19     -  stress-ng-cpu
Average:        0      2352   23.69    0.00    0.00   76.31   23.69     -  stress-ng-cpu
Average:        0      2353   35.41    0.00    0.00   64.59   35.41     -  stress-ng-cpu
Average:        0      2354   24.19    0.00    0.00   75.56   24.19     -  stress-ng-cpu
Average:        0      2355   24.44    0.00    0.00   75.56   24.44     -  stress-ng-cpu
Average:        0      2356   23.69    0.00    0.00   76.06   23.69     -  stress-ng-cpu
Average:        0      2357   24.44    0.00    0.00   75.56   24.44     -  stress-ng-cpu
Average:        0      2358   24.19    0.00    0.00   75.56   24.19     -  stress-ng-cpu
Average:        0      2359   24.94    0.00    0.00   74.81   24.94     -  stress-ng-cpu
Average:        0      2360   23.44    0.00    0.00   76.56   23.44     -  stress-ng-cpu
Average:        0      2387    0.00    0.75    0.00    0.75    0.75     -  pidstat
```
这里可以看出，此时CPU处于繁忙的状态，大量处在等待中，说明是进程过多的原因

`pidstat -d 1` 此时没有IO的信息

## 总结

通过以上问题现象及解决思路可以总结出：

平均负载高有可能是 CPU 密集型进程导致的
平均负载高并不一定代表 CPU 使用率高，还有可能是 I/O 更繁忙了
当发现负载高的时候，你可以使用 mpstat、pidstat 等工具，辅助分析负载的来源
总结工具：mpstat、pidstat、top和uptime



# CPU 上下文切换

CPU 上下文：CPU 执行每个任务都需要知道任务从哪里加载、又从哪里开始运行，也就是说，需要系统事先帮它设置好 CPU 寄存器和程序计数器（Program Counter，PC）包括 CPU 寄存器在内都被称为 CPU 上下文。

CPU 上下文切换：CPU 上下文切换，就是先把前一个任务的 CPU 上下文（也就是 CPU 寄存器和程序计数器）保存起来，然后加载新任务的上下文到这些寄存器和程序计数器，最后再跳转到程序计数器所指的新位置，运行新任务。

CPU 上下文切换：分为进程上下文切换、线程上下文切换以及中断上下文切换。

- 进程上下文切换
    从用户态切换到内核态需要通过系统调用来完成，这里就会发生进程上下文切换（特权模式切换），当切换回用户态同样发生上下文切换。

    一般每次上下文切换都需要几十纳秒到数微秒的 CPU 时间，如果切换较多还是很容易导致 CPU 时间的浪费在寄存器、内核栈以及虚拟内存等资源的保存和恢复上，这里同样会导致系统平均负载升高。

    Linux 为每个 CPU 维护一个就绪队列，将 R 状态进程按照优先级和等待 CPU 时间排序，选择最需要的 CPU 进程执行。这里运行进程就涉及了进程上下文切换的时机：

    - 进程时间片耗尽、。
    - 进程在系统资源不足（内存不足）。
    - 进程主动sleep。
    - 有优先级更高的进程执行。
    - 硬中断发生。


- 线程上下文切换
    - 线程和进程：

        - 当进程只有一个线程时，可以认为进程就等于线程。
        - 当进程拥有多个线程时，这些线程会共享相同的虚拟内存和全局变量等资源。这些资源在上下文切换时是不需要修改的。
        - 线程也有自己的私有数据，比如栈和寄存器等，这些在上下文切换时也是需要保存的。

    所以线程上下文切换包括了 2 种情况：

    - 不同进程的线程，这种情况等同于进程切换。
    - 同进程的线程切换，只需要切换线程私有数据、寄存器等不共享数据。

- 中断上下文切换
    中断处理会打断进程的正常调度和执行，转而调用中断处理程序，响应设备事件。而在打断其他进程时，就需要将进程当前的状态保存下来，这样在中断结束后，进程仍然可以从原来的状态恢复运行。

    对同一个 CPU 来说，中断处理比进程拥有更高的优先级，所以中断上下文切换并不会与进程上下文切换同时发生。由于中断会打断正常进程的调度和执行，所以大部分中断处理程序都短小精悍，以便尽可能快的执行结束。

## 排查
- 问题模拟，使用`sysbench`工具模拟上下文切换问题
    ```
    sysbench --threads=128 --time=300 threads run
    ```

- vmstat：工具可以查看系统的内存、CPU 上下文切换以及中断次数：
    ```
    # vmstat -w 1
    --------------memory-----------------------------------     ---swap--   ----io----   -system--      ------cpu--------
    r  b         swpd         free         buff        cache    si   so    bi    bo      in   cs       us  sy  id  wa  st
    0  0            0     33936156         1628       788396     0    0     0     0      93  143        0   0 100   0   0
    0  0            0     33936512         1628       788396     0    0     0     0     167  308        0   0 100   0   0
    0  0            0     33936512         1628       788396     0    0     0     0     157  292        0   0 100   0   0
    0  0            0     33936704         1628       788396     0    0     0     0      88  146        0   0 100   0   0
    0  0            0     33937096         1628       788396     0    0     0     0     198  312        0   0 100   0   0
    0  0            0     33937096         1628       788396     0    0     0     0      84  135        0   0 100   0   0
    0  0            0     33937096         1628       788396     0    0     0     0     101  174        0   0 100   0   0
    0  0            0     33936668         1628       788396     0    0     0     0     144  292        0   0 100   0   0
    12  0            0     33932488         1628       788396    0    0     0     0    26482 265883    1  10  89   0   0
    19  0            0     33932228         1628       788396    0    0     0     0    137148 1408627  5  57  39   0   0
    22  0            0     33932080         1628       788396    0    0     0     0    138466 1389870  5  57  38   0   0
    20  0            0     33932112         1628       788396    0    0     0     0    131291 1281110  4  55  40   0   0
    27  0            0     33932112         1628       788396    0    0     0   138    135575 1371706  5  56  38   0   0
    22  0            0     33931504         1628       788396    0    0     0     0    140819 1418318  5  55  40   0   0
    ```

    Procs
    - r: The number of processes waiting for run time.
    - b: The number of processes in uninterruptible sleep.
    
    Memory
    - swpd: the amount of virtual memory used.
    - free: the amount of idle memory.
    - buff: the amount of memory used as buffers.
    - cache: the amount of memory used as cache.
    - inact: the amount of inactive memory. (-a option)
    - active: the amount of active memory. (-a option)
    
    Swap
    - si: Amount of memory swapped in from disk (/s).
    - so: Amount of memory swapped to disk (/s).
    
    IO
    - bi: Blocks received from a block device (blocks/s).
    - bo: Blocks sent to a block device (blocks/s).
    
    System
    - in: The number of interrupts per second, including the clock.
    - cs: The number of context switches per second.

    CPU:  These are percentages of total CPU time.
    - us: Time spent running non-kernel code. (user time, including nice time)
    - sy: Time spent running kernel code. (system time)
    - id: Time spent idle. Prior to Linux 2.5.41, this includes IO-wait time.
    - wa: Time spent waiting for IO. Prior to Linux 2.5.41, included in idle.
    - st: Time stolen from a virtual machine. Prior to Linux 2.6.11, unknown.


    我们可以看到：
    1. 当前 cs、in 此时剧增。
    2. sy+us 的 CPU 占用超过   60%。
    3. r 就绪队列长度达到 16 个超过了 CPU 核心数 8 个。  



- pidstat：使用pidstat -w选项查看具体进程的上下文切换次数：
    ```
    # pidstat -w -u -t   1
    Average:      UID      TGID       TID   cswch/s nvcswch/s  Command
    Average:        0        10         -      0.50      0.00  ksoftirqd/0
    Average:        0         -        10      0.50      0.00  |__ksoftirqd/0
    Average:        0        11         -     23.88      0.00  rcu_sched
    Average:        0         -        11     23.88      0.00  |__rcu_sched
    Average:        0        12         -      0.25      0.00  migration/0
    Average:        0         -        12      0.25      0.00  |__migration/0
    Average:        0        15         -      0.25      0.00  migration/1
    Average:        0         -        15      0.25      0.00  |__migration/1
    Average:        0        16         -      0.25      0.00  ksoftirqd/1
    Average:        0         -        16      0.25      0.00  |__ksoftirqd/1
    Average:        0        20         -      0.25      0.00  migration/2
    Average:        0         -        20      0.25      0.00  |__migration/2
    Average:        0        21         -      4.98      0.00  ksoftirqd/2
    Average:        0         -        21      4.98      0.00  |__ksoftirqd/2
    Average:        0        25         -      0.25      0.00  migration/3
    Average:        0         -        25      0.25      0.00  |__migration/3
    Average:        0        30         -      0.25      0.00  migration/4
    Average:        0         -        30      0.25      0.00  |__migration/4
    Average:        0        35         -      0.25      0.00  migration/5
    Average:        0         -        35      0.25      0.00  |__migration/5
    Average:        0        36         -      0.25      0.00  ksoftirqd/5
    Average:        0         -        36      0.25      0.00  |__ksoftirqd/5
    Average:        0       376         -      3.23      0.00  kworker/2:2-mm_percpu_wq
    Average:        0         -       376      3.23      0.00  |__kworker/2:2-mm_percpu_wq
    Average:        0       396         -      1.00      0.00  irq/16-vmwgfx
    Average:        0         -       396      1.00      0.00  |__irq/16-vmwgfx
    Average:        0         -       670      1.24      0.00  |__in:imjournal
    Average:        0       677         -     11.44      0.00  vmtoolsd
    Average:        0         -       677     11.44      0.00  |__vmtoolsd
    Average:        0         -       691      1.00      0.00  |__HangDetector
    Average:        0         -       778      0.25      0.00  |__gmain
    Average:        0         -       842      0.25      0.00  |__gmain
    Average:        0       931         -      0.25      0.00  nmbd
    Average:        0         -       931      0.25      0.00  |__nmbd
    Average:        0       959         -     17.66      0.00  Xorg
    Average:        0         -       959     17.66      0.00  |__Xorg
    Average:      985       992         -      3.98      0.00  ukui-greeter
    Average:      985         -       992      3.98      0.00  |__ukui-greeter
    Average:      985         -       993      1.99      0.00  |__QXcbEventQueue
    Average:      985         -      1006      0.75      0.00  |__MonitorWatcher
    Average:        0      1033         -     38.31      0.00  sshd
    Average:        0         -      1033     38.31      0.00  |__sshd
    Average:        0      1737         -     13.93      0.00  kworker/1:0-events
    Average:        0         -      1737     13.93      0.00  |__kworker/1:0-events
    Average:        0      1767         -      3.23      0.00  kworker/0:1-events
    Average:        0         -      1767      3.23      0.00  |__kworker/0:1-events
    Average:        0      1930         -      2.74      0.00  kworker/3:0-mm_percpu_wq
    Average:        0         -      1930      2.74      0.00  |__kworker/3:0-mm_percpu_wq
    Average:        0      2682         -     95.52      0.00  kworker/u256:2-events_unbound
    Average:        0         -      2682     95.52      0.00  |__kworker/u256:2-events_unbound
    Average:        0      2861         -     96.27      0.00  kworker/u256:0-events_unbound
    Average:        0         -      2861     96.27      0.00  |__kworker/u256:0-events_unbound
    Average:        0      3505         -      1.00      0.00  kworker/4:1-events
    Average:        0         -      3505      1.00      0.00  |__kworker/4:1-events
    Average:        0      3607         -      0.25      0.00  systemd-userwor
    Average:        0         -      3607      0.25      0.00  |__systemd-userwor
    Average:        0      3617         -      0.25      0.00  systemd-userwor
    Average:        0         -      3617      0.25      0.00  |__systemd-userwor
    Average:        0      3621         -      0.50      0.00  kworker/3:2-ata_sff
    Average:        0         -      3621      0.50      0.00  |__kworker/3:2-ata_sff
    Average:        0      3625         -      1.99      0.00  kworker/5:1-events
    Average:        0         -      3625      1.99      0.00  |__kworker/5:1-events
    Average:        0         -      3652   1761.19   8863.68  |__sysbench
    Average:        0         -      3653   1622.14   9051.00  |__sysbench
    Average:        0         -      3654   1802.99   8030.35  |__sysbench
    Average:        0         -      3655   1837.56   7005.22  |__sysbench
    Average:        0         -      3656   1825.87   9990.55  |__sysbench
    Average:        0         -      3657   1634.58   8777.11  |__sysbench
    Average:        0         -      3658   1740.30   7999.25  |__sysbench
    Average:        0         -      3659   1866.67   8234.33  |__sysbench
    Average:        0         -      3660   1936.07   7352.24  |__sysbench
    Average:        0         -      3661   1780.85   7576.87  |__sysbench
    Average:        0         -      3662   1726.37   8463.68  |__sysbench
    Average:        0         -      3663   1794.03   8089.55  |__sysbench
    Average:        0         -      3664   1746.27   9604.23  |__sysbench
    Average:        0         -      3665   1748.01   8843.78  |__sysbench
    Average:        0         -      3666   1783.33   7993.53  |__sysbench
    Average:        0         -      3667   1727.36   7189.55  |__sysbench
    Average:        0         -      3668   1586.07   8697.76  |__sysbench
    Average:        0         -      3669   1743.53   8092.04  |__sysbench
    Average:        0         -      3670   1747.01  10212.69  |__sysbench
    Average:        0         -      3671   1796.02   9150.25  |__sysbench
    Average:        0         -      3672   1768.66   7989.80  |__sysbench
    Average:        0         -      3673   1625.62   8791.29  |__sysbench
    Average:        0         -      3674   1642.29   8166.92  |__sysbench
    Average:        0         -      3675   1714.18  10090.55  |__sysbench
    Average:        0         -      3676   1715.17   7051.99  |__sysbench
    Average:        0         -      3677   1707.21   8710.20  |__sysbench
    Average:        0         -      3678   1724.88   9104.98  |__sysbench
    Average:        0         -      3679   1797.51   8228.86  |__sysbench
    Average:        0         -      3680   1601.24   9193.28  |__sysbench
    Average:        0         -      3681   1784.83   8349.75  |__sysbench
    Average:        0         -      3682   1674.38   8957.96  |__sysbench
    Average:        0         -      3683   1760.20   8164.43  |__sysbench
    Average:        0         -      3684   1784.33   9055.72  |__sysbench
    Average:        0         -      3685   1743.78   8563.93  |__sysbench
    Average:        0         -      3686   1758.71   9113.93  |__sysbench
    Average:        0         -      3687   1694.03   9278.11  |__sysbench
    Average:        0         -      3688   1798.76   8830.60  |__sysbench
    Average:        0         -      3689   1751.24   7636.57  |__sysbench
    Average:        0         -      3690   1767.91   7055.47  |__sysbench
    Average:        0         -      3691   1703.23   7127.61  |__sysbench
    Average:        0         -      3692   1750.00   7845.27  |__sysbench
    Average:        0         -      3693   1809.95   9274.38  |__sysbench
    Average:        0         -      3694   1632.34   8627.61  |__sysbench
    Average:        0         -      3695   1801.49   8597.26  |__sysbench
    Average:        0         -      3696   1735.07   8905.72  |__sysbench
    Average:        0         -      3697   1792.79   8458.21  |__sysbench
    Average:        0         -      3698   1698.26   9112.69  |__sysbench
    Average:        0         -      3699   1744.78   7806.72  |__sysbench
    Average:        0         -      3700   1775.12   8777.36  |__sysbench
    Average:        0         -      3701   1700.00   8269.90  |__sysbench
    Average:        0         -      3702   1762.69   8271.39  |__sysbench
    Average:        0         -      3703   1753.98   9795.27  |__sysbench
    Average:        0         -      3704   1662.94   8480.10  |__sysbench
    Average:        0         -      3705   1758.21   7384.33  |__sysbench
    Average:        0         -      3706   1811.94   7313.93  |__sysbench
    Average:        0         -      3707   1645.02   8274.88  |__sysbench
    Average:        0         -      3708   1688.31   7846.27  |__sysbench
    Average:        0         -      3709   1666.17   8148.76  |__sysbench
    Average:        0         -      3710   1777.36   8722.64  |__sysbench
    Average:        0         -      3711   1602.24   9487.81  |__sysbench
    Average:        0         -      3712   1859.20   7412.94  |__sysbench
    Average:        0         -      3713   1754.73   8902.24  |__sysbench
    Average:        0         -      3714   1805.22   8678.86  |__sysbench
    Average:        0         -      3715   1732.59   8948.76  |__sysbench
    Average:        0         -      3716   1777.11   7258.71  |__sysbench
    Average:        0         -      3717   1656.72   7675.87  |__sysbench
    Average:        0         -      3718   1715.92   8340.05  |__sysbench
    Average:        0         -      3719   1627.61   7834.58  |__sysbench
    Average:        0         -      3720   1831.34   7239.05  |__sysbench
    Average:        0         -      3721   1597.26   7586.57  |__sysbench
    Average:        0         -      3722   1752.74   8162.44  |__sysbench
    Average:        0         -      3723   1705.97   9437.31  |__sysbench
    Average:        0         -      3724   1736.57   7302.99  |__sysbench
    Average:        0         -      3725   1812.44   8224.63  |__sysbench
    Average:        0         -      3726   1839.05   7142.04  |__sysbench
    Average:        0         -      3727   1731.59   8681.34  |__sysbench
    Average:        0         -      3728   1693.78   8581.59  |__sysbench
    Average:        0         -      3729   1688.06   7633.83  |__sysbench
    Average:        0         -      3730   1977.36   8314.93  |__sysbench
    Average:        0         -      3731   1722.64   7221.89  |__sysbench
    Average:        0         -      3732   1787.06   9976.12  |__sysbench
    Average:        0         -      3733   1684.08   7710.95  |__sysbench
    Average:        0         -      3734   1572.89   7625.62  |__sysbench
    Average:        0         -      3735   1693.28   8228.86  |__sysbench
    Average:        0         -      3736   1675.37   8620.15  |__sysbench
    Average:        0         -      3737   1615.67   8979.35  |__sysbench
    Average:        0         -      3738   1664.68   9192.79  |__sysbench
    Average:        0         -      3739   1752.99   7141.04  |__sysbench
    Average:        0         -      3740   1696.52   6863.18  |__sysbench

    ```
    其中cswch/s和nvcswch/s表示自愿上下文切换和非自愿上下文切换
    - 自愿上下文切换：是指进程无法获取所需资源，导致的上下文切换。比如说， I/O、内存等系统资源不足时，就会发生自愿上下文切换。

    - 非自愿上下文切换：则是指进程由于时间片已到等原因，被系统强制调度，进而发生的上下文切换。比如说，大量进程都在争抢 CPU 时，就容易发生非自愿上下文切换


    所以我们可以看到大量的sysbench线程存在很多的上下文切换。


- 分析 in 中断问题
  我们可以查看系统的watch -d cat /proc/softirqs以及watch -d cat /proc/interrupts来查看系统的软中断和硬中断（内核中断）。我们这里主要观察/proc/interrupts即可。
    ```
    # cat /proc/interrupts
    NMI:       2979       3033       3152       3250       3253       3042   Non-maskable interrupts
    LOC:    2525903    2519785    2636213    2706767    2695099    2555816   Local timer interrupts
    SPU:          0          0          0          0          0          0   Spurious interrupts
    PMI:       2979       3033       3152       3250       3253       3042   Performance monitoring interrupts
    IWI:          8          0          0          0          1          0   IRQ work interrupts
    RTR:          0          0          0          0          0          0   APIC ICR read retries
    RES:   15427265   15766879   15657043   15568958   15375296   15493721   Rescheduling interrupts
    CAL:     527074       2873     774456     642006     561340     599559   Function call interrupts
    TLB:        967       1085        176        927        342        390   TLB shootdowns
    TRM:          0          0          0          0          0          0   Thermal event interrupts
    THR:          0          0          0          0          0          0   Threshold APIC interrupts
    DFR:          0          0          0          0          0          0   Deferred Error APIC interrupts
    MCE:          0          0          0          0          0          0   Machine check exceptions
    MCP:         14         15         15         15         15         15   Machine check polls
    ERR:          0
    MIS:          0
    PIN:          0          0          0          0          0          0   Posted-interrupt notification event
    NPI:          0          0          0          0          0          0   Nested posted-interrupt event
    PIW:          0          0          0          0          0          0   Posted-interrupt wakeup event
    ```

    这里明显看出重调度中断（RES）增多，这个中断表示唤醒空闲状态 CPU 来调度新任务执行，

## 总结
- 自愿上下文切换变多了，说明进程都在等待资源，有可能发生了 I/O 等其他问题。
- 非自愿上下文切换变多了，说明进程都在被强制调度，也就是都在争抢 CPU，说明 CPU 的确成了瓶颈。
- 中断次数变多了，说明 CPU 被中断处理程序占用，还需要通过查看/proc/interrupts文件来分析具体的中断类型。


# CPU 使用率
Linux 通过/proc虚拟文件系统向用户控件提供系统内部状态信息，其中/proc/stat则是 CPU 和任务信息统计。
```
#  cat /proc/stat | grep cpu
cpu  882058 32 609613 1364888 34220 32494 3369 0 0 0
cpu0 147403 6 94198 238011 3689 4344 524 0 0 0
cpu1 147021 18 90283 224566 12673 11050 644 0 0 0
cpu2 146968 0 104273 225354 5708 4338 624 0 0 0
cpu3 147140 3 112199 217682 6397 4272 550 0 0 0
cpu4 146966 4 112651 221273 2653 4288 502 0 0 0
cpu5 146556 0 96006 238000 3098 4199 523 0 0 0
```
- user（通常缩写为 us），代表用户态 CPU 时间。注意，它不包括下面的 nice 时间，但包括了 guest 时间。
- nice（通常缩写为 ni），代表低优先级用户态 CPU 时间，也就是进程的 nice 值被调整为 1-19 之间时的 CPU 时间。这- 里注意，nice 可取值范围是 -20 到 19，数值越大，优先级反而越低。
- system（通常缩写为 sys），代表内核态 CPU 时间。
- idle（通常缩写为 id），代表空闲时间。注意，它不包括等待 I/O 的时间（iowait）。
- iowait（通常缩写为 wa），代表等待 I/O 的 CPU 时间。
- irq（通常缩写为 hi），代表处理硬中断的 CPU 时间。
- softirq（通常缩写为 si），代表处理软中断的 CPU 时间。
- steal（通常缩写为 st），代表当系统运行在虚拟机中的时候，被其他虚拟机占用的 CPU 时间。
- guest（通常缩写为 guest），代表通过虚拟化运行其他操作系统的时间，也就是运行虚拟机的 CPU 时间。
- guest_nice（通常缩写为 gnice），代表以低优先级运行虚拟机的时间。

## CPU 使用率问题排查
这里总结一下 CPU 使用率问题及排查思路：

- 用户 CPU 和 Nice CPU 高，说明用户态进程占用了较多的 CPU，所以应该着重排查进程的性能问题。
- 系统 CPU 高，说明内核态占用了较多的 CPU，所以应该着重排查内核线程或者系统调用的性能问题。
- I/O 等待 CPU 高，说明等待 I/O 的时间比较长，所以应该着重排查系统存储是不是出现了 I/O 问题。
- 软中断和硬中断高，说明软中断或硬中断的处理程序占用了较多的 CPU，所以应该着重排查内核中的中断服务程序。

## CPU 问题排查套路
- CPU 使用率,CPU 使用率主要包含以下几个方面：

    - 用户 CPU 使用率，包括用户态 CPU 使用率（user）和低优先级用户态 CPU 使用率（nice），表示 CPU 在用户态运行的时间百分比。用户 CPU 使用率高，通常说明有应用程序比较繁忙。
    - 系统 CPU 使用率，表示 CPU 在内核态运行的时间百分比（不包括中断）。系统 CPU 使用率高，说明内核比较繁忙。
    - 等待 I/O 的 CPU 使用率，通常也称为 iowait，表示等待 I/O 的时间百分比。iowait 高，通常说明系统与硬件设备的 I/O 交互时间比较长。
    - 软中断和硬中断的 CPU 使用率，分别表示内核调用软中断处理程序、硬中断处理程序的时间百分比。它们的使用率高，通常说明系统发生了大量的中断。
    - 除在虚拟化环境中会用到的窃取 CPU 使用率（steal）和客户 CPU 使用率（guest），分别表示被其他虚拟机占用的 CPU 时间百分比，和运行客户虚拟机的 CPU 时间百分比。
- 平均负载,反应了系统的整体负载情况，可以查看过去 1 分钟、过去 5 分钟和过去 15 分钟的平均负载。

- 上下文切换,上下文切换主要关注 2 项指标：

    - 无法获取资源而导致的自愿上下文切换。
    - 被系统强制调度导致的非自愿上下文切换。
- CPU 缓存命中率

CPU 的访问速度远大于内存访问，这样在 CPU 访问内存时不可避免的要等待内存响应。为了协调 2 者的速度差距出现了 CPU 缓存（多级缓存）。如果 CPU 缓存命中率越高则性能会更好,使用这个工具可以查看CPU 缓存命中率 https://github.com/brendangregg/perf-tools
```
 ./cachestat.sh
Counting cache functions... Output every 1 seconds.
    HITS   MISSES  DIRTIES    RATIO   BUFFERS_MB   CACHE_MB
    2380        0        0   100.0%            2        699
    1402        0        0   100.0%            2        699
    1404        0        0   100.0%            2        699
    2321        0        0   100.0%            2        699
    1418        0        0   100.0%            2        699
    1452        0        0   100.0%            2        699
    2378        0        0   100.0%            2        699
    1450        0        0   100.0%            2        699
    2379        0        0   100.0%            2        699
    1430        0        0   100.0%            2        699
    1417        0        0   100.0%            2        699
```

Links:
- https://mp.weixin.qq.com/s/7HGjAy_R_sdpfckFlFr0cw