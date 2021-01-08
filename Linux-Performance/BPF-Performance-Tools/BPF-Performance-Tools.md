Notes about BPF.Performance.Tools
--
- [EBPF Esentials](#EBPF-Esentials)
- [Traditional Tools](#Traditional-Tools)
    - [Perf To Examine PMC](#Perf-To-Examine-PMC)
    - [Perf Tracing For Various Aspects](#Perf-Tracing-For-Various-Aspects)
- [BCC Onelineers](#bcc)
    - [BCC CPU analysis](#BCC-CPU-analysis)
    - [BCC Memory analysis](#BCC-Memory-analysis)
    - [BCC Filesystem analysis](#BCC-Filesystem-analysis)
    - [BCC Disk I/O Analysis](#BCC-Disk-I/O-Analysis)

- [bpftrace Onelineers](#bpftrace)
    - [bpftrace CPU analysis](#bpftrace-CPU-analysis)
    - [bpftrace Memory analysis](#bpftrace-Memory-analysis)
    - [bpftrace Filesystem analysis](#bpftrace-Filesystem-analysis)
    - [bpftrace Disk I/O Analysis](#bpftrace-Disk-I/O-Analysis)




EBPF Esentials
---

-  event source
    - kprobes: provide kernel dynamic instrumentation,kprobes can create instrumentation events for any kernel function, and it can instrument instructions within functions. It can do this live, in production environments, without needing to either reboot the system or run the kernel in any special mode.
    
      There interfaces of kprobes
    
      - kprobe API: register_kprobe() etc
      - Ftrace-based, via /sys/kernel/debug/tracing/kprobe_events: where kprobes can be enabled and disabled by writing configuration strings to this file
      -  perf_event_open(): as used by the perf(1) tool, and more recently by BPF tracing
        
      The biggest use of kprobes has been via front-end tracers, including perf(1), SystemTap, and the BPF tracers BCC and bpftrace.
      - BCC: attach_kprobe() and attach_kretprobe()
      - bpftrace: kprobe and kretprobe probe types
    
    - uprobes provides user-level dynamic instrumentation.

       uprobes can instrument user-level function entries as well as instruction offsets, and uretprobes can instrument the return of functions

       uprobes are also file based: When a function in an executable file is traced, all processes using that file are instrumented, including those that start in the future. This allows library calls to be traced system-wide
       
       There are two interfaces for uprobes:
       - Ftrace-based, via /sys/kernel/debug/tracing/uprobe_events: where uprobes can be enabled and disabled by writing configuration strings to this file
       - perf_event_open(): as used by the perf(1) tool and, more recently, by BPF tracing

       uprobes for ebpf
       - BCC: attach_uprobe() and attach_uretprobe()
       - bpftrace: uprobe and uretprobe probe types
    - Tracepoints are used for kernel static instrumentation. 
    
      They involve tracing calls that developers have inserted into the kernel code at logical places; those calls are then compiled into the kernel binary.

      the tracepoints provide a stable API24: Tools written to use tracepoints should continue working across newer kernel versions.

      You should always try to use tracepoints first, if available and sufficient, and turn to kprobes only as a backup

      There are two interfaces for tracepoints:
      - Ftrace-based, via /sys/kernel/debug/tracing/events: which has subdirectories for each tracepoint system, and files for each tracepoint itself (tracepoints can be enabled and disabled by writing to these files.)
      - perf_event_open(): as used by the perf(1) tool and, more recently, by BPF tracing

      The interfaces for ebpf:
      - BCC: TRACEPOINT_PROBE()
      - bpftrace: The tracepoint probe type
      
      BPF Raw Tracepoints: It avoids the cost of creating the stable tracepoint arguments,exposes the raw arguments to the tracepoint,this is like accessing tracepoints as though they were kprobes

    - USDT 
      
      User-level statically defined tracing (USDT) provides a user-space version of tracepoints. not easy use, as should be decalared and implemented  in application source code.

      interfaces for ebpf:
      - BCC: USDT().enable_probe()
      - bpftrace: The usdt probe type
    
    - Dynamic USDT
      
      JVM already contains many USDT probes in its C++ code—for GC events, class loading, and other high-level activities

      Dynamic USDT can be used to add instrumentation points in the Java code
    
    - PMCs

      Performance monitoring counters (PMCs) are also known by other names, such as performance instrumentation counters (PICs), CPU performance counters (CPCs), and performance monitoring unit events (PMU events).

      These terms all refer to the same thing: programmable hardware counters on the processor


      Intel Architectural PMCs
      |Event Name| UMask |Event Select| Example Event Mask Mnemonic|
      |- | - | - |-|
      |UnHalted Core Cycles |00H |3CH| CPU_CLK_UNHALTED.THREAD_P|
      |Instruction Retired| 00H |C0H |INST_RETIRED.ANY_P|
      |UnHalted Reference Cycles |01H |3CH |CPU_CLK_THREAD_UNHALTED.REF_XCLK|
      |LLC References |4FH |2EH |LONGEST_LAT_CACHE.REFERENCE|
      |LLC Misses| 41H| 2EH| LONGEST_LAT_CACHE.MISS|
      |Branch Instruction Retired |00H |C4H |BR_INST_RETIRED.ALL_BRANCHES|
      |Branch Misses Retired |00H |C5H| BR_MISP_RETIRED.ALL_BRANCHES|

      - PMCs are a vital resource for performance analysis. Only through PMCs can you measure the efficiency of CPU instructions; the hit ratios of CPU caches; memory, interconnect, and device bus utilization; stall cycles; and so on.
      - PMCs are also a strange resource. While there are hundreds of PMCs available, only a fixed number of registers (perhaps as few as six) are available in the CPUs to measure them at the same time. You need to choose which PMCs you’d like to measure on those six registers, or cycle through different PMC sets as a way of sampling them. (Linux perf(1) supports this cycling automatically.)

      PMCs can be used in one of two modes:
      - Counting: In this mode, PMCs keep track of the rate of events. T
      - Overflow Sampling: In this mode, the PMCs can send interrupts to the kernel for the events they are monitoring, so that the kernel can collect extra state.

      PEBS(precise event-based sampling): uses hardware buffers to record the correct instruction pointer at the time of the PMC event. The Linux perf_events framework supports using PEBS.
    
    - perf_events 
    
      perf_events facility is used by the perf(1) command for sampling and tracing perf(1) and its perf_events facility have received a lot of attention and development over the years, and BPF tracers can make calls to perf_events to use its features. BCC and bpftrace first used perf_events for its ring buffer, and then for PMC instrumentation, and now for all event instrumentation via perf_event_open()

      perf(1) is the only BPF front-end tracer that is built into Linux.

- ebpf APIs 
    - list in /usr/src/kernels/<uname -r>/include/uapi/linux/bpf.h
    - BPF Helper Functions
        |BPF Helper Function |          Description|
        |-----------------------------| ------------------|
        |bpf_map_lookup_elem(map, key)|Finds a key in a map and returns its value (pointer)|
        |bpf_map_update_elem(map, key, value, flags)|Updates the value of the entry selected by key|
        |bpf_map_delete_elem(map, key) |Deletes the entry selected by key from the map|
        |bpf_probe_read(dst, size, src) |Safely reads size bytes from address src and stores in dst.|
        |bpf_ktime_get_ns()|Returns the time since boot, in nanoseconds.|
        |bpf_trace_printk(fmt, fmt_size, ...) |A debugging helper that writes to TraceFS trace{_pipe}.|
        |bpf_get_current_pid_tgid()| Returns a u64 containing the current TGID (what user space calls the PID) in the upper bits and the current PID (what user space calls the kernel thread ID) in the lower bits.|
        |bpf_get_current_comm(buf, buf_size)| Copies the task name to the buffer.|
        |bpf_perf_event_output(ctx, map,data, size)|Writes data to the perf_event ring buffers; this is used for per-event output.|
        |bpf_get_stackid(ctx, map, flags)|Fetches a user or kernel stack trace and returns an identifier|
        |bpf_get_current_task()| Returns the current task struct. This contains many details about the running process and links to other structs containing system state. Note that these are all considered an unstable API.|
        |bpf_probe_read_str(dst, size, ptr)|Copies a NULL terminated string from an unsafe pointer to the destination, limited by size (including the NULL byte).|
        |bpf_perf_event_read_value(map, flags, buf, size)|Reads a perf_event counter and stores it in the buf. This is a way to read PMCs during a BPF program.|
        |bpf_get_current_cgroup_id()| Returns the current cgroup ID.|
        |bpf_spin_lock(lock), bpf_spin_unlock(lock)|Concurrency control for network programs|


- CPU
    - tracepoints for scheduler and syscall events, 
    - kprobes for scheduler internal functions, 
    - uprobes for application-level functions
    - PMCs for timed sampling and low-level CPU activity
    > - PMC(Performance monitoring counters) refer to programmable hardware counters on the processor
    > - There are many PMCs, Intel has selected seven PMCs as an “architectural set” that provides a high-level overview of some core functions
- Memory 
    - software events or tracepoints for faults syscalls
    - probes for kernel memory allocation functions
    - uprobes for library, runtime, and application allocators
    - USDT probes for libc allocator events
    - PMCs for overflow sampling of memory accesses

    > - User-level statically defined tracing (USDT)  provides a user-space version of tracepoints.
    > - page fault: application tries to access an address in virtual memory pages which isn't currently mapped to physical RAM, This causes an MMU error called a page fault

- show  probes in libc 
    -  list USDT probes available in libc
        ```
        # bpftrace -l usdt:/lib64/libc.so.6
        usdt:/lib64/libc.so.6:libc:setjmp
        usdt:/lib64/libc.so.6:libc:longjmp
        usdt:/lib64/libc.so.6:libc:longjmp_target
        usdt:/lib64/libc.so.6:libc:lll_lock_wait_private
        usdt:/lib64/libc.so.6:libc:memory_mallopt_arena_max
        ...
        ```
    -  list uprobe probes available in libc
        ```
        # bpftrace -l uprobe:/lib/x86_64-linux-gnu/libc-2.27.so
        uprobe:/lib64/libc.so.6:_Exit
        uprobe:/lib64/libc.so.6:_IO_adjust_column
        uprobe:/lib64/libc.so.6:_IO_adjust_wcolumn
        uprobe:/lib64/libc.so.6:_IO_cleanup
        uprobe:/lib64/libc.so.6:_IO_cookie_close
        uprobe:/lib64/libc.so.6:_IO_cookie_init
        ...
        ```
- Disk I/O rwbs

    For tracing observability, the kernel provides a way to describe the type of each I/O using a character string named rwbs. This is defined in the kernel blk_fill_rwbs() function and uses the characters:
    - R: Read
    - W: Write
    - M: Metadata
    - S: Synchronous
    - A: Read-ahead
    - F: Flush or force unit access
    - D: Discard
    - E: Erase
    - N: None

- I/O Schedulers
    - Traditional scheduler
        -  Noop: No scheduling (a no-operation)
        -  Deadline:  Enforce a latency deadline, useful for real-time systems
        -  CFQ:  The completely fair queueing scheduler, which allocates I/O time slices to processes, similar to CPU scheduling
    - Multi-queue schedulers (above  5.0)
        -  None:  No queueing
        -  BFQ: The budget fair queueing scheduler, similar to CFQ, but allocates bandwidth as well as I/O time 
        - mq-deadline: A blk-mq version of deadline
        - Kyber: A scheduler that adjusts read and write dispatch queue lengths based on performance, so that target read or write latencies can be met

- Network fundermentals

    - dpdk:  implementing its own network protocols in user-space, and making writes to the network driver via a DPDK library and a kernel user space I/O (UIO) or virtual function I/O (VFIO) driver.
    - xdp: it accesses the raw network Ethernet frame as early as possible via a BPF hook inside the NIC driver, it can make early decisions about forwarding or dropping without the overhead of TCP/IP stack processing. When needed, it can also fall back to regular network stack processing. Use cases include faster DDoS mitigation, and software defined routing.

    - Receive and Transmit Scaling:
    
        Various policies are available for interrupt mitigation and distributing NIC interrupts and packet processing across multiple CPUs, improving scalability and performance

        -  new API (NAPI) interface
        -  Receive Side Scaling (RSS)
        - Receive Packet Steering (RPS)
        - Receive Flow Steering (RFS)
        - Accelerated RFS
        - Transmit Packet Steering (XPS)
    - Socket Accept Scaling

        uses a thread to process the accept(2) calls and then pass the connection to a pool of worker threads

        -  SO_REUSEPORT setsockopt:  allows a pool of processes or threads to bind to the same socket address, where they all can call accept(2);. It is then up to the kernel to balance the new connections across the pool of bound threads
        - . A BPF program can be supplied to steer this balancing via the SO_ATTACH_REUSEPORT_EBPF option

    - TCP Backlog
        - a SYN backlog with minimal metadata that can better survive SYN floods
        -  a listen backlog for completed connections for the application to consume
        - TCP listen path was also made lockless to improve scalability for SYN flood attacks
    - TCP Retransmits
        - Timer-based retransmits 
        - Fast retransmits
        
        Selective acknowledgments (SACK) is a TCP option that allows later packets to be acknowledged then will not be retransmited again

    - TCP Send and Receive Buffers

        TCP data throughput is improved by using socket send and receive buffer accounting; . Linux dynamically sizes the buffers based on connection activity, and allows tuning of their minimum, default, and maximum sizes. Larger sizes improve performance at the cost of more memory per connection.

        - TCP uses generic segmentation offload (GSO) to send packets up to 64 Kbytes in size (“super packets”), which are split into MSS-sized segments just before delivery to the network device
        - If the NIC and driver support TCP segmentation offload (TSO), GSO leaves splitting to the device, further improving network stack throughput
        - There is also a generic receive offload (GRO) complement to GSO
        - GRO and GSO are implemented in kernel software, and TSO is implemented by NIC hardware

    - TCP Congestion Controls

        Linux supports different TCP congestion control algorithms that modify send and receive windows based on detected congestion to keep network connections running optimally
        -  Cubic (the default)
        - Reno
        - Tahoe
        - DCTCP
        - BBR
    - Queueing Discipline

        This optional layer manages traffic classification (tc), scheduling, manipulation, filtering, and shaping of network packets.
        
        Linux provides numerous queueing discipline algorithms, which can be configured using the tc(8) command
        
        BPF can enhance the capabilities of this layer with the programs of type BPF_PROG_TYPE_SCHED_CLS and BPF_PROG_TYPE_SCHED_ACT


    - Other Performance Optimizations
        - Nagle: This reduces small network packets by delaying their transmission, allowing more to arrive and coalesce.
        - Byte Queue Limits (BQL): These automatically size the driver queues large enough to avoid starvation, but also small enough to reduce the maximum latency of queued packets.
        - Pacing: This controls when to send packets, spreading out transmissions (pacing) to avoid bursts that may hurt performance.
        - TCP Small Queues (TSQ): This controls (reduces) how much is queued by the network stack to avoid problems including bufferbloat
        - Early Departure Time (EDT): This uses a timing wheel to order packets sent to the NIC, instead of a queue.

        A TCP sent packet can be processed by any of the congestion controls, TSO, TSQ, Pacing, and queueing disciplines, before it ever arrives at the NIC

    - Latency Measurements
        - Name resolution latency: The time for a host to be resolved to an IP address, usually by DNS resolution—a common source of performance issues.
        - Ping latency: The time from an ICMP echo request to a response. 
        - TCP connection latency: The time from when a SYN is sent to when the SYN,ACK is received
        - TCP first byte latency: Also known as the time-to-first-byte latency (TTFB), this measures the time from when a connection is established to when the first data byte is received by the client
        - Round trip time (RTT): The time for a network packet to make a round trip between endpoints
        - Connection lifespan: The duration of a network connection from initialization to close.




Traditional Tools
---
### Perf To Examine PMC 
- list all PMCs event support in perf ,can be used later with `-e` in CPU/Memory analysis
    ```
    perf list
    ```
- perf counting mode,for If no such arguments are supplied, it defaults to a basic set of PMCs, or it uses an extended set if -d is used,following exampe to counting event for command `cat files`
    ```
    # perf stat -d cat files
    branch-instructions OR branches                    [Hardware event]
    branch-misses                                      [Hardware event]
    cache-misses                                       [Hardware event]
    cache-references                                   [Hardware event]
    cpu-cycles OR cycles                               [Hardware event]
    instructions                                       [Hardware event]
    ref-cycles                                         [Hardware event]
    .....

    branch-instructions OR cpu/branch-instructions/    [Kernel PMU event]
    branch-misses OR cpu/branch-misses/                [Kernel PMU event]
    cache-misses OR cpu/cache-misses/                  [Kernel PMU event]
    cache-references OR cpu/cache-references/          [Kernel PMU event]
    cpu-cycles OR cpu/cpu-cycles/                      [Kernel PMU event]
    cstate_core/c3-residency/                          [Kernel PMU event]
    .....


    Performance counter stats for 'cat files':

                5.22 msec task-clock                #    0.367 CPUs utilized          
                    2      context-switches          #    0.383 K/sec                  
                    0      cpu-migrations            #    0.000 K/sec                  
                100      page-faults               #    0.019 M/sec                  
            14,431,594      cycles                    #    2.765 GHz                      (16.10%)
            8,600,140      stalled-cycles-frontend   #   59.59% frontend cycles idle     (31.72%)
            5,913,864      stalled-cycles-backend    #   40.98% backend cycles idle      (50.72%)
            10,080,164      instructions              #    0.70  insn per cycle         
                                                    #    0.85  stalled cycles per insn  (69.74%)
            3,243,330      branches                  #  621.422 M/sec                    (88.73%)
                39,495      branch-misses             #    1.22% of all branches          (83.90%)
            2,704,032      L1-dcache-loads           #  518.092 M/sec                    (68.28%)
                64,063      L1-dcache-load-misses     #    2.37% of all L1-dcache hits    (49.28%)
                36,173      LLC-loads                 #    6.931 M/sec                    (11.27%)
        <not counted>      LLC-load-misses                                               (0.00%)

        0.014212267 seconds time elapsed

        0.000000000 seconds user
        0.005931000 seconds sys

    ```
### Perf Tracing For Various Aspects
- perf to use PMCs in CPU counting mode,  count specific events on all CPUs (using -a, which recently became the default) and print output with an interval of 1000 milliseconds (-I 1000):
    ```
    perf stat -e mem_load_retired.l3_hit -e mem_load_retired.l3_miss -a -I 1000
    ```
- PMCs in a Hardware sampling mode, records the stack trace (-g) for L3 cache-miss events (-e ...) on all CPUs (-a) for 10 seconds (sleep 10, a dummy command used to set the duration)
    ```
    perf record -e mem_load_retired.l3_miss -c 50000 -a -g -- sleep 10
    ```

- PMC in Timed Sampling,capturing stacks across all CPUs at 99 Hertz (samples per second per CPU) for 30 seconds:
    ```
    perf record -F 99 -a -g -- sleep 30
    ```

    > - use `perf report -n --stdio` to view it


- page status, use `sar -B` to show page status 
    ```
    sar -B 1
    
    Linux 4.18.0-257.el8.x86_64 (dev.lmy.com) 	12/16/2020 	_x86_64_	(4 CPU)

    11:20:44 AM  pgpgin/s pgpgout/s   fault/s  majflt/s  pgfree/s pgscank/s pgscand/s pgsteal/s    %vmeff
    11:20:45 AM      0.00      0.00     12.00      0.00     93.00      0.00      0.00      0.00      0.00
    11:20:46 AM      0.00     44.00      3.00      0.00     89.00      0.00      0.00      0.00      0.00
    11:20:47 AM      0.00    188.00      4.00      0.00     26.00      0.00      0.00      0.00      0.00
    11:20:48 AM      0.00      0.00      8.00      0.00     58.00      0.00      0.00      0.00      0.00
    11:20:49 AM      0.00      0.00      6.00      0.00     20.00      0.00      0.00      0.00      0.00
    11:20:50 AM      0.00      0.00      4.00      0.00     18.00      0.00      0.00      0.00      0.00
    11:20:51 AM      0.00      0.00      5.00      0.00   1041.00      0.00      0.00      0.00      0.00
    11:20:52 AM      0.00   2700.00      8.00      0.00    153.00      0.00      0.00      0.00      0.00
    11:20:53 AM      0.00     12.00      7.00      0.00     17.00      0.00      0.00      0.00      0.00
    11:20:54 AM      0.00      0.00      6.00      0.00     16.00      0.00      0.00      0.00      0.00
    ```

- counting mode to measure last-level cache (LLC) loads and misses, system-wide (-a), with interval output every 1 second (-I 1000):
    ```
    perf stat -e LLC-loads,LLC-load-misses -a -I 1000
    ```
- in sampling mode to record details from every one in one hundred thousand L1 data cache misses:,LLC misses are one measure of I/O to main memory, since once a memory load or store misses the LLC, it becomes a main memory access
    ```
    perf record -e L1-dcache-load-misses -c 100000 -a -- sleep 10
    perf report -n --stdio
    ```
- perf used to check if there is short-lived process while top has no findings,it achieves this by instrumenting tracepoints, kprobes, uprobes, and (as of recently) USDT probes. These can provide some logical context for why CPU resources were consumed.
    ```
     perf stat -e sched:sched_process_exec -I 1000
     ```
     then recorded for a later analysis
     ```
     # perf record -e sched:sched_process_exec -a
     ```
     and perf(1) has a special subcommand for CPU scheduler analysis called `perf sched`. so we can also use this to sample it
     ```
     perf sched record -- sleep 1
    ```
    and use `perf sched timehist` to check the result
    ```
    perf sched timehist
    ```
- strace to track the syscalls for a command
    ```
    # strace -tttT ls
    1608105107.541667 execve("/usr/bin/ls", ["ls"], 0x7fffc7e61a88 /* 66 vars */) = 0 <0.000415>
    1608105107.542372 brk(NULL)             = 0x5573d132c000 <0.000015>
    1608105107.542466 arch_prctl(0x3001 /* ARCH_??? */, 0x7ffe00bb4250) = -1 EINVAL (Invalid argument) <0.000128>
    1608105107.542735 access("/etc/ld.so.preload", R_OK) = -1 ENOENT (No such file or directory) <0.000024>
    1608105107.542852 openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3 <0.000029>
    1608105107.542949 fstat(3, {st_mode=S_IFREG|0644, st_size=141112, ...}) = 0 <0.000015>
    1608105107.543032 mmap(NULL, 141112, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f198f8c7000 <0.000022>
    1608105107.543109 close(3)              = 0 <0.000015>
    1608105107.543187 openat(AT_FDCWD, "/lib64/libselinux.so.1", O_RDONLY|O_CLOEXEC) = 3 <0.000079>
    1608105107.543318 read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\200z\0\0\0\0\0\0"..., 832) = 832 <0.000017>
    1608105107.543382 lseek(3, 157168, SEEK_SET) = 157168 <0.000015>
    1608105107.546943 read(3, "\4\0\0\0 \0\0\0\5\0\0\0GNU\0\1\0\0\300\4\0\0\0\30\0\0\0\0\0\0\0"..., 48) = 48 <0.000039>
    1608105107.547107 fstat(3, {st_mode=S_IFREG|0755, st_size=168536, ...}) = 0 <0.000018>
    1608105107.547194 mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f198f8c5000 <0.000027>
    1608105107.547304 lseek(3, 157168, SEEK_SET) = 157168 <0.000016>
    1608105107.547539 read(3, "\4\0\0\0 \0\0\0\5\0\0\0GNU\0\1\0\0\300\4\0\0\0\30\0\0\0\0\0\0\0"..., 48) = 48 <0.000021>
    ```
    and perf can also do this 
    ```
    # perf trace ls
     ....
     0.105 ( 0.002 ms): ls/25265 arch_prctl(option: 0x3001, arg2: 0x7ffcfdee9420)                      = -1 EINVAL (Invalid argument)
     0.131 ( 0.008 ms): ls/25265 access(filename: 0xe4205b40, mode: R)                                 = -1 ENOENT (No such file or directory)
     0.148 ( 0.009 ms): ls/25265 openat(dfd: CWD, filename: 0xe4202f02, flags: RDONLY|CLOEXEC)         = 3
     0.159 ( 0.004 ms): ls/25265 fstat(fd: 3, statbuf: 0x7ffcfdee8610)                                 = 0
     0.164 ( 0.006 ms): ls/25265 mmap(len: 141112, prot: READ, flags: PRIVATE, fd: 3)                  = 0x7f55e43e6000
     0.172 ( 0.002 ms): ls/25265 close(fd: 3)                                                          = 0
     0.187 ( 0.008 ms): ls/25265 openat(dfd: CWD, filename: 0xe440bd20, flags: RDONLY|CLOEXEC)         = 3
     0.197 ( 0.003 ms): ls/25265 read(fd: 3, buf: 0x7ffcfdee87c8, count: 832)                          = 832
     0.203 ( 0.002 ms): ls/25265 lseek(fd: 3, offset: 157168, whence: SET)                             = 157168
     0.206 ( 0.002 ms): ls/25265 read(fd: 3, buf: 0x7ffcfdee8690, count: 48)                           = 48
     0.210 ( 0.002 ms): ls/25265 fstat(fd: 3, statbuf: 0x7ffcfdee8660)                                 = 0
     0.213 ( 0.003 ms): ls/25265 mmap(len: 8192, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS)           = 0x7f55e43e4000
     0.222 ( 0.001 ms): ls/25265 lseek(fd: 3, offset: 157168, whence: SET)                             = 157168
     0.225 ( 0.002 ms): ls/25265 read(fd: 3, buf: 0x7ffcfdee8370, count: 48)                           = 48
     0.229 ( 0.007 ms): ls/25265 mmap(len: 2266608, prot: READ|EXEC, flags: PRIVATE|DENYWRITE, fd: 3)  = 0x7f55e3fb7000
     0.237 ( 0.010 ms): ls/25265 mprotect(start: 0x7f55e3fde000, len: 2093056)                         = 0
     0.249 ( 0.009 ms): ls/25265 mmap(addr: 0x7f55e41dd000, len: 8192, prot: READ|WRITE, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x26000) = 0x7f55e41dd000
     0.265 ( 0.004 ms): ls/25265 mmap(addr: 0x7f55e41df000, len: 5616, prot: READ|WRITE, flags: PRIVATE|FIXED|ANONYMOUS) = 0x7f55e41df000
     0.277 ( 0.002 ms): ls/25265 close(fd: 3)                                                          = 0
     0.294 ( 0.008 ms): ls/25265 openat(dfd: CWD, filename: 0xe43e44d0, flags: RDONLY|CLOEXEC)         = 3
     0.304 ( 0.003 ms): ls/25265 read(fd: 3, buf: 0x7ffcfdee87a8, count: 832)                          = 832
     0.308 ( 0.001 ms): ls/25265 lseek(fd: 3, offset: 15728, whence: SET)                              = 15728
     0.310 ( 0.002 ms): ls/25265 read(fd: 3, buf: 0x7ffcfdee8680, count: 32)                           = 32
     0.314 ( 0.002 ms): ls/25265 fstat(fd: 3, statbuf: 0x7ffcfdee8640)                                 = 0
     0.318 ( 0.001 ms): ls/25265 lseek(fd: 3, offset: 15728, whence: SET)                              = 15728
     0.320 ( 0.002 ms): ls/25265 read(fd: 3, buf: 0x7ffcfdee8390, count: 32)                           = 32
     0.323 ( 0.007 ms): ls/25265 mmap(len: 2117944, prot: READ|EXEC, flags: PRIVATE|DENYWRITE, fd: 3)  = 0x7f55e3db1000
     0.332 ( 0.011 ms): ls/25265 mprotect(start: 0x7f55e3db5000, len: 2097152)                         = 0
    ```
    counting ext4 calls system-wide via ext4 tracepoints:
    ```
    # perf stat -e 'ext4:*' -a -- sleep 3 
     Performance counter stats for 'system wide':

                 0      ext4:ext4_other_inode_update_time                                   
                 0      ext4:ext4_free_inode                                        
                 0      ext4:ext4_request_inode                                     
                 0      ext4:ext4_allocate_inode                                    
                 0      ext4:ext4_evict_inode                                       
                 0      ext4:ext4_drop_inode                                        
                 0      ext4:ext4_nfs_commit_metadata                                   
                91      ext4:ext4_mark_inode_dirty                                   
                 0      ext4:ext4_begin_ordered_truncate                                   
                 0      ext4:ext4_write_begin                                       
                53      ext4:ext4_da_write_begin                                    
                 0      ext4:ext4_write_end                                         
                 0      ext4:ext4_journalled_write_end                                   
                53      ext4:ext4_da_write_end                                      
                 8      ext4:ext4_writepages                                        
                11      ext4:ext4_da_write_pages                                    
    ```        
    or 
    ```
    # perf record -e ext4:ext4_da_write_begin -a
    # perf report -n --stdio 
    ......
    # Overhead       Samples  Command          Shared Object  Symbol                 
    # ........  ............  ...............  .............  .......................
    #
        99.99%        883804  perf             [ext4]         [k] ext4_da_write_begin
        0.00%            26  ThreadPoolForeg  [ext4]         [k] ext4_da_write_begin
        0.00%            20  baidunetdisk     [ext4]         [k] ext4_da_write_begin
    .....
    ```
- use perf to trace the queuing of requests (block_rq_insert), their issue to a storage device (block_rq_issue), and their completions (block_rq_complete):
    ```
    perf record -e block:block_rq_insert,block:block_rq_issue,block:block_rq_complete -a
    ```
- set and view  SCSI event logging
    ```
    # sysctl -w dev.scsi.logging_level=0x1b6db6db 
    or 
    # echo 0x1b6db6db > /proc/sys/dev/scsi/logging_level
    or  sg3-utils provide command scsi_logging_level to set this 
    scsi_logging_level -s --all 3
    ```
    we can view the scsi logs via `dmesg`, This can be used to help debug errors and timeouts.

BCC
---
###  BCC CPU analysis
1. Trace new processes with arguments
    ```
    execsnoop
    ```
2. Show who is executing what:
    ```
    trace 't:syscalls:sys_enter_execve "-> %s", args->filename'
    ```

3. Show the syscall count by process:
    ```
    syscount -P
    ```
4. Show the syscall count by syscall name:
    ```
    syscount
    ```
5. Sample user-level stacks at 49 Hertz, for PID 2019:
    ```
    profile -F 49 -U -p 2019
    ```
6. Sample all stack traces and process names:
    ```
    profile
    ```
7. Count kernel functions beginning with "vfs_":
    ```
    funccount 'vfs_*'
    ```
8. Trace new threads via pthread_create():
    ```
    trace /lib/x86_64-linux-gnu/libpthread-2.27.so:pthread_create
    ```
###  BCC Memory analysis
1. Count process heap expansion (brk()) by user-level stack trace:
    ```
    stackcount -U t:syscalls:sys_enter_brk
    ```
2. Count user page faults by user-level stack trace:
    ```
    stackcount -U t:exceptions:page_fault_user
    ```
3. Count vmscan (kswapd operations) operations by tracepoint:
    ```
    funccount 't:vmscan:*'
    ```
4. Show hugepage_madvise() calls by process:
    ```
    trace hugepage_madvise
    ```
5. Count page migrations(in NUMA systems)
    ```
    funccount t:migrate:mm_migrate_pages
    ```
6. Trace compaction events:
    ```
    trace t:compaction:mm_compaction_begin
    ```
### BCC Filesystem Analysis
1. Trace files opened via open(2) with process name:
    ```
    opensnoop
    ```
2. Trace files created via creat(2) with process name:
    ```
    trace 't:syscalls:sys_enter_creat "%s", args->pathname'
    ```
3. Count newstat(2) calls by filename:
    ```
    argdist -C 't:syscalls:sys_enter_newstat():char*:args->filename'
    ```
4. Count read syscalls by syscall type:
    ```
    funccount 't:syscalls:sys_enter_*read*'
    ```
4. Count write syscalls by syscall type:
    ```
    funccount 't:syscalls:sys_enter_*write*'
    ```
5. Show the distribution of read() syscall request sizes:
    ```
    argdist -H 't:syscalls:sys_enter_read():int:args->count'
    ```
6. Show the distribution of read() syscall read bytes (and errors):
    ```
    argdist -H 't:syscalls:sys_exit_read():int:args->ret'
    ```
7. Count read() syscall errors by error code:
    ```
    argdist -C 't:syscalls:sys_exit_read():int:args->ret:args->ret<0'
    ```
8. Count VFS calls:
    ```funccount 'vfs_*'
    ```
9. Count ext4 tracepoints:
    ```
    funccount 't:ext4:*'
    ```
10. Count xfs tracepoints:
    ```
    funccount 't:xfs:*'
    ```
11. Count ext4 file reads by process name and stack trace:
    ```
    stackcount ext4_file_read_iter
    ```
12. Count ext4 file reads by process name and user-level stack only:
    ```
    stackcount -U ext4_file_read_iter
    ```
13. Trace ZFS spa_sync() times:
    ```
    trace -T 'spa_sync "ZFS spa_sync()"'
    ```
14. Count FS reads to storage devices via read_pages, with stacks and process names:
    ```
    stackcount -P read_pages
    ```
15. Count ext4 reads to storage devices, with stacks and process names:
    ```
    stackcount -P ext4_readpages
    ```

### BCC Disk I/O Analysis
1. Count block I/O tracepoints:
    ```
    funccount t:block:*
    ```
2. Summarize block I/O size as a histogram:
    ```
    argdist -H 't:block:block_rq_issue():u32:args->bytes'
    ```
3. Count block I/O request user stack traces:
    ```
    stackcount -U t:block:block_rq_issue
    ```
4. Count block I/O type flags:
    ```
    argdist -C 't:block:block_rq_issue():char*:args->rwbs'
    ```
5. Trace block I/O errors with device and I/O type:
    ```
    trace 't:block:block_rq_complete (args->error) "dev %d type %s error %d", args->dev,args->rwbs, args->error'
    ```
6. Count SCSI opcodes:
    ```
    argdist -C 't:scsi:scsi_dispatch_cmd_start():u32:args->opcode'
    ```
7. Count SCSI result codes:
    ```
    argdist -C 't:scsi:scsi_dispatch_cmd_done():u32:args->result'
    ```
8. Count nvme driver functions:
    ```
    funccount 'nvme*'
    ```
bpftrace
---
###  bpftrace CPU analysis
1. Trace new processes with arguments:
    ```
    bpftrace -e 'tracepoint:syscalls:sys_enter_execve { join(args->argv); }'
    ```
2. Show who is executing what:
    ```
    bpftrace -e 'tracepoint:syscalls:sys_enter_execve { printf("%s -> %s\n", comm, str(args->filename)); }'
    ```
3. Show the syscall count by program:
    ```
    bpftrace -e 'tracepoint:raw_syscalls:sys_enter { @[comm] = count(); }'
    ```
4. Show the syscall count by process:
    ```
    bpftrace -e 'tracepoint:raw_syscalls:sys_enter { @[pid, comm] = count(); }'
    ```
5. Show the syscall count by syscall probe name:
    ```
    bpftrace -e 'tracepoint:syscalls:sys_enter_* { @[probe] = count(); }'
    ```
6. Show the syscall count by syscall function:
    ```
    bpftrace -e 'tracepoint:raw_syscalls:sys_enter { @[sym(*(kaddr("sys_call_table") + args->id * 8))] = count(); }'
    ```
7. Sample running process names at 99 Hertz:
    ```
    bpftrace -e 'profile:hz:99 { @[comm] = count(); }'
    ```
8. Sample user-level stacks at 49 Hertz, for PID 189:
    ```
    bpftrace -e 'profile:hz:49 /pid == 189/ { @[ustack] = count(); }'
    ```
9. Sample all stack traces and process names:
    ```
    bpftrace -e 'profile:hz:49 { @[ustack, stack, comm] = count(); }'
    ```
10. Sample the running CPU at 99 Hertz and show it as a linear histogram:
    ```
    bpftrace -e 'profile:hz:99 { @cpu = lhist(cpu, 0, 256, 1); }'
    ```
11. Count kernel functions beginning with vfs_:
    ```
    bpftrace -e 'kprobe:vfs_* { @[func] = count(); }'
    ```
12. Count SMP calls by name and kernel stack:
    ```
    bpftrace -e 'kprobe:smp_call* { @[probe, kstack(5)] = count(); }'
    ```
13. Count Intel x2APIC calls by name and kernel stack:
    ```
    bpftrace -e 'kprobe:x2apic_send_IPI* { @[probe, kstack(5)] = count(); }'
    ```
14. Trace new threads via pthread_create():
    ```
    bpftrace -e 'u:/lib/x86_64-linux-gnu/libpthread-2.27.so:pthread_create { printf("%s by %s (%d)\n", probe, comm, pid); }'
    ```

### bpftrace Memory Analysis
- Count process heap expansion (brk()) by code path:
    ```
    bpftrace -e tracepoint:syscalls:sys_enter_brk { @[ustack, comm] = count(); }
    ```
- Count page faults by process:
    ```
    bpftrace -e 'software:page-fault:1 { @[comm, pid] = count(); }'
    ```
- Count user page faults by user-level stack trace:
    ```
    bpftrace -e 'tracepoint:exceptions:page_fault_user { @[ustack, comm] = count(); }'
    ```
- Count vmscan operations by tracepoint:
    ```
    bpftrace -e 'tracepoint:vmscan:* { @[probe] = count(); }'
    ```
- Show hugepage_madvise() calls by process:
    ```
    bpftrace -e 'kprobe:hugepage_madvise { printf("%s by PID %d\n", probe, pid); }'
    ```
- Count page migrations:
    ```bpftrace -e 'tracepoint:migrate:mm_migrate_pages { @ = count(); }'
    ```
- Trace compaction events:
    ```
    bpftrace -e 't:compaction:mm_compaction_begin { time(); }'
    ```
### bpftrace Filesystem Analysis
1. counting ext4 calls system-wide via ext4 tracepoints:
    ```
    # bpftrace -e 'tracepoint:ext4:ext4_da_write_begin { @ = hist(args->len); }'
    ```
2. Trace files opened via open(2) with process name:
    ```
    bpftrace -e 't:syscalls:sys_enter_open { printf("%s %s\n", comm, str(args->filename)); }'
    ```
3. Trace files created via creat(2) with process name:
    ```
    bpftrace -e 't:syscalls:sys_enter_creat { printf("%s %s\n", comm, str(args->pathname)); }'
    ```
4. Count newstat(2) calls by filename:
    ```
    bpftrace -e 't:syscalls:sys_enter_newstat { @[str(args->filename)] = count(); }'
    ```
5. Count read syscalls by syscall type:
    ```
    bpftrace -e 'tracepoint:syscalls:sys_enter_*read* { @[probe] = count(); }'
    ```
6. Count write syscalls by syscall type: 
    ```
    bpftrace -e 'tracepoint:syscalls:sys_enter_*write* { @[probe] = count(); }'
    ```
7. Show the distribution of read() syscall request sizes:
    ```
    bpftrace -e 'tracepoint:syscalls:sys_enter_read { @ = hist(args->count); }'
    ```
8. Show the distribution of read() syscall read bytes (and errors):
    ```
    bpftrace -e 'tracepoint:syscalls:sys_exit_read { @ = hist(args->ret); }'
    ```
9. Count read() syscall errors by error code:
    ```
    bpftrace -e 't:syscalls:sys_exit_read /args->ret < 0/ { @[- args->ret] = count(); }'
    ```
10. Count VFS calls:
    ```
    bpftrace -e 'kprobe:vfs_* { @[probe] = count(); }'
    ```
11. Count ext4 tracepoints:
    ```
    bpftrace -e 'tracepoint:ext4:* { @[probe] = count(); }'
    ```
12. Count xfs tracepoints:
    ```
    bpftrace -e 'tracepoint:xfs:* { @[probe] = count(); }'
    ```
13. Count ext4 file reads by process name:
    ```
    bpftrace -e 'kprobe:ext4_file_read_iter { @[comm] = count(); }'
    ```
14. Count ext4 file reads by process name and user-level stack:
    ```
    bpftrace -e 'kprobe:ext4_file_read_iter { @[ustack, comm] = count(); }'
    ```
15. Trace ZFS spa_sync() times:
    ```
    bpftrace -e 'kprobe:spa_sync { time("%H:%M:%S ZFS spa_sinc()\n"); }'
    ```
16. Count dcache references by process name and PID:
    ```
    bpftrace -e 'kprobe:lookup_fast { @[comm, pid] = count(); }'
    ```
17. Count FS reads to storage devices via read_pages, with kernel stacks:
    ```
    bpftrace -e 'kprobe:read_pages { @[kstack] = count(); }'
    ```
18. Count ext4 reads to storage devices via read_pages, with kernel stacks:
    ```
    bpftrace -e 'kprobe:ext4_readpages { @[kstack] = count(); }'    
    ```
### bpftrace Disk I/O Analysis
1. Count block I/O tracepoints:
    ```
    bpftrace -e 'tracepoint:block:* { @[probe] = count(); }'
    ```
2.  Summarize block I/O size as a histogram:
    ```
    bpftrace -e 't:block:block_rq_issue { @bytes = hist(args->bytes); }'
    ```
3.  Count block I/O request user stack traces:
    ```
    bpftrace -e 't:block:block_rq_issue { @[ustack] = count(); }'
    ```
4.  Count block I/O type flags:
    ```
    bpftrace -e 't:block:block_rq_issue { @[args->rwbs] = count(); }'
    ```
5.  Show total bytes by I/O type:
    ```
    bpftrace -e 't:block:block_rq_issue { @[args->rwbs] = sum(args->bytes); }'
    ```
6.  Trace block I/O errors with device and I/O type:
    ```
    bpftrace -e 't:block:block_rq_complete /args->error/ { printf("dev %d type %s error %d\n", args->dev, args->rwbs, args->error); }'
    ```
7.  Summarize block I/O plug time as a histogram:
    ```
    bpftrace -e 'k:blk_start_plug { @ts[arg0] = nsecs; } k:blk_flush_plug_list /@ts[arg0]/ { @plug_ns = hist(nsecs - @ts[arg0]);  delete(@ts[arg0]); }'
    ```
8.  Count SCSI opcodes:
    ```
    bpftrace -e 't:scsi:scsi_dispatch_cmd_start { @opcode[args->opcode] = count(); }'
    ```
9.  Count SCSI result codes (all four bytes):
    ```
    bpftrace -e 't:scsi:scsi_dispatch_cmd_done { @result[args->result] = count(); }'
    ```
10. Show CPU distribution of blk_mq requests:
    ```
    bpftrace -e 'k:blk_mq_start_request { @swqueues = lhist(cpu, 0, 100, 1); }'
    ```
11. Count scsi driver functions:
    ```
    bpftrace -e 'kprobe:scsi* { @[func] = count(); }'
    ```
12. Count nvme driver functions:
    ```
    bpftrace -e 'kprobe:nvme* { @[func] = count(); }'
    ```