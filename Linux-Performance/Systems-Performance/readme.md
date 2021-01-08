Systems Performance 2nd Edition
---


- [Chapter 3 Operating System](#Chapter-3-Operating-System)
- [Chapter 4 Observability Tools](#Chapter-4-Observability-Tools)
- [Chapter 5 Applications](#Chapter-5-Applications)
- [Chapter 6 CPUs](#Chapter-6-CPUs)
- [Chapter 7 Memory](#Chapter-6-Memory)


### Chapter 3 Operating System
- 3.2.2  Kernel and user mode
  - mode switch (kernel mode and user), and all system calls mode switch
  - contex switch (switch between thread/process running)
- 3.2.3 System Calls
  - key system calls 
    - read()
    - write()
    - open()
    - close()
    - fork()
    - clone()
    - exec()
    - connect()
    - accept()
    - ioctl()
    - mmap()
    - brk()
    - futex()
  - error code number for system calls are defined in `/usr/include/asm/errno.h` or `/usr/include/asm-generic/errno.h`
  - perf command implemented `perf_event_open()` syscall which is a wapper of `ioctl()` syscall with different arguments(defined in `/usr/include/linux/perf_event.h`), then be further used with different tracers , monitoring tools or perf sub-commands

- 3.2.4 Interrupts
  - hardware interrupts ---> asynchronous 
  - software interrupts ---> synchronous 

- 3.2.6 Process
  a process is an excution evironment
  - memory address space
  - file descriptor
  - thread stacks
  - register 
    
  a process may contain one or more threads
  - running in shared address space
  - share same file desicriptor 
  - its own stack,register and instruction point

- 3.2.7 stacks
  stacks consisted of 
  - data (less important that fits in the cpu register set)
  - function + return address 
  - registers whose values may be used after call
  
  to reader a stack, 
  - each line consists of function and instruction offset 
  - from top-to-bottom, it is currently execution function to its parent function and more



### Chapter 4 Observability Tools

4.1.2  Crisis tool 
  - packages
        - procps-ng
        - util-linux
        - sysstat
        - iproute
        - numactl
        - perf
        - kernel-tools
        - bcc-tools
        - bpftrace
        - trace-cmd
        - ethtool
        - msr-tools
        - strace
        - showboost,cpuhot,cputemp -- from https://github.com/brendangregg/msr-cloud-tools
        - pmcarch,cpucache,icache,tlbstat,resstalls -- from https://github.com/brendangregg/pmc-cloud-tools
        - tiptop -- https://github.com/FeCastle/tiptop http://tiptop.gforge.inria.fr/
        - nicstat -- https://github.com/scotte/nicstat  https://sourceforge.net/projects/nicstat/
  
    for `sysstat`, need to enable service `systemctl start sysstat`
  - enable `CONFIG_FTRACE` and `CONFIG_BPF`

4.3 oberservability sources
- Sources
    |Type | Source |
    |----|----|
    |Per-process counters| /proc|
    |System-wide counters| /sys, /proc|
    |Device configuration and counters| /sys|
    |Cgroup statistics|/sys/fs/cgroup|
    |Per-process tracing| ptrace|
    |Hardware counters(PMCs)|perf_event|
    |Network statistics| netlink|
    |Network packet capture |libpcap|
    |Per-thread latency metrics|Delay Accounting|
    |System-wide tracing|Function profiling(ftrace),tracepoints,software events,kprobes,uprobes,perf_event|
     
- 4.3.1 `/proc`
  - per-process `/proc/[PID]/`
  - system-wide `/proc/[a-z]*`
  - `vmstat` will explore `/proc` to print the output, can be verified via `strace -p $(pidof vmstat)`
  - `schedstats` under `/proc` is enabled via `CONFIG_SCHEDSTATS`
  - `sched` under `/proc` is enabled via `CONFIG_SCHED_DEBUG`
  
- 4.3.3 Delay Accounting
  - with enable `CONFIG_TASK_DELAY_ACCT` option, following ware enabled 
    - Scheduler latency: waiting for a turn on-CPU ---- `/proc/[PID]/schedstat`
    - Block I/O: waiting for a block I/O  to complete 
    - Swapping: waiting for paging(memory pressure)
    - Memory reclaim: waiting for the memory reclaim routine
- 4.3.4 netlink
  netlink is a special socket address familay(AF_NETLINK) for fetching kernel information;
  - open networking socket with AF_NETLINK address family
  - send() syscall to pass request
  - recv() syscall to receiving information in binary structure


- 4.3.5 Tracepoints
  tracepoints are a **linux kernel event source based on static instrumentation**, and are hard-coded instrumentation points placed at logical location in kernel code.

  - list all available tracepoint via `perf list tracepoint`
  - tracepoint interfaces:
    -  tracefs resides under directory `/sys/kernel/debug/tracing/`, when debugfs mounted under `/sys/kernel/debug`
    - exposed via `per_event_open()` system call which is the interface to kernel `perf_events` system call
  - tracepoints are defined in files under `/usr/src/kernels/[kernel-version]/include/trace/events/`

- 4.3.6 kprobes 

  kprobes(kernel probes) is a **linux kernel event source for tracer based on dynamic instrumentation**, can trace any kernel function or instruction; considered as unstable API because they **expose raw kernel functions and arguments** that may change between kernel versions.  
    
  kretprobes traces the return from kernel functions and their return value, similar to kprobes

  kprobes interface:
  - via /sys 
  - via perf_event_open() system call  ---- prefered way
  - via register_kprobe() kernel api


- 4.3.7 uprobes
  uprobes(user-space probes) are similar to kprobes but for user-space probes, dynamically instrument functions in applications and libraries, provide an unstable API for diving deep into software internals
  
  uretprobes traces the return from kernel functions and their return value, similar to uprobes


  uprobes interface:
  - via /sys 
  - via perf_event_open() system call  ---- prefered way

  list all uprobes in `/bin/bash` via `bpftrace -l 'uprobe:/bin/bash:*'`

- 4.3.8 USDT
   User-level statically-defined tracing(USDT) is the user-space version of tracepoints, some applicaions added USDT to their code, providing a stable API for tracing application-level events

- 4.3.9 Hardware Counters(PMCs)

  The procsssor and other devices commonly support hardware counters for observing activity, main sources are the processors, called performance monitoring counters(PMCs)

  - measure efficiency of CPU instruction
  - hit ratio of CPU caches
  - utilization of memory and device buses
  - interconnect utilization
  - stall cycles 
  - ....

  PMCs interface
  - perf_event_open()


  use `perf stat` to get the PMC counters 
  ```sh
  # perf stat ls /tmp
   Performance counter stats for 'ls /tmp':

              1.48 msec task-clock                #    0.807 CPUs utilized
                 0      context-switches          #    0.000 K/sec
                 0      cpu-migrations            #    0.000 K/sec
               293      page-faults               #    0.198 M/sec
         4,721,490      cycles                    #    3.188 GHz
         3,706,022      instructions              #    0.78  insn per cycle
           795,367      branches                  #  536.973 M/sec
            25,314      branch-misses             #    3.18% of all branches

       0.001834756 seconds time elapsed

       0.001910000 seconds user
       0.000000000 seconds sys
  ```

  PMC are not accurate, an improvement is precise event-based  sampling(PEBS)

- 4.3.10 Other event sources 
  - MSRs: as PMCs are vendor-specific, MSR showing the configuration and health of the system, includeing CPU clock rate,usate,temperatures and power consumption
  - ptrace(): it is breakpoint-based and can slow the target over one hundred-fold; and it is used by gdb for process debugging and strace for tracing syscalls
  - ...

- 4.4 SAR 
  - prequisites: install sysstat and enable sysstat service


### Chapter 5 Applications

- 5.2.5 concurrency and parallelism

  - synchronization primitives 
    - Mutex(Mutually exclusive) locks
    - Spine locks
    - RW locks 
    - Semaphores

  - hash table to deal with locks 
    - a bucket of locks for several input data structures
    - hash algorithm to choose which lock based on the input
    - eliminate the creation and destroy lock overhead frequently 


- 5.4 Methodology

  Available methodologies:
  - CPU profiling
  - Off-CPU profiling
  - Syscall analysis
  - USE method 
  - Thread state analysis
  - lock analysis 
  - static performance tuning
  - distribute tracing


  thread state analysis
  - User: pidstat -- "%user"
  - Kernel: pidstat -- "%system"
  - runnable: vmstat -- "r"
  - swapping: vmstat -- "si" and "so"
  - disk I/O: pidstat -d -- "iodelay"
  - Network I/O: sar -n DEV -- "rxKB/S" "txKB/s"
  - sleeping: not easily available
  - lock: perf top 
  - idle: not easily available


### Chapter 6 CPUs
- 6.4 Architecture
  - 6.4.1 Hardware
    - P-states and C-states

      P-states: processor performance state, providing different levels of performance during normal excution by varying the CPU frequency
      
      P0 is the highest frequency, P1...PN are lower frequency states

      C-states: processor power states,providing different idle states for when execution is halted, saving power

      C0 is for normal operation, and C1 and above are for idle states 


    - CPU caches 

      all kinds of caches:
      - Level 1 instruction cache
      - Level 1 data cache 
      - Translation lookaside buffer 
      - level 2 cache 
      - level 3 cache 

      for intel processor, Level 3 cache are called last-level-cache(LLC)


    - MMU

      - Translation lookaside buffer(TLB) is used by MMU to cache the translation of address between virtual and main memory mapping 
      - if TLB is hit, just return the mapping
      - if TLB miss, MMU will try to mapping new memory pages with virtual memory


    - Hardware Counters(PMCs)

      PMCs are processor registers implemented in hardware that can be programmed to count low-level CPU activity

      - CPU cycles: including stall cycles and types of stall cycles
      - CPU instructions: retired(excuted)
      - Level 1,2,3 cache accesses: hits,misses
      - Floating-point unit: opertion
      - Memory I/O: reads,writes,stall cycles
      - Resource I/O: reads,writes,stall cycles
  
  - 6.4.2 Software
    - Scheduler
      
      functions of the scheduler:
      - time sharing
      - preemtion
      - loadbalancing

    - scheduling class

      it manages the behavior of runnable threads' priorities, whether on-CPU time  is time sliced, and the duration of those time slices

      scheduling policies, can work within a scheduling class to control scheduling between threads of the same priority


      List of scheduling class
      - RT
      - O(1)
      - CFS
      - Idle
      - Deadline

      List of scheduling policies
      - RR: round-robin
      - FIFO: first-in, first-out
      - Normal: time-sharing scheduling and is the default for user processes
      - Batch:
      - IDLE
      - DEADLINE
- 6.5 Methodology

    amoung all the moethodologies, suggested methodology order is: performance monitoring ---> USE method ---> profiling ---> micro-benchmarking ---> static performance tuning

    - Tools method 
      - uptime/top: check load average
      - vmstat 1: check system-wide CPU utilization(us+sy)
      - mpstat :check individual hot CPU(busy)
      - top: check wich process and user use most CPU
      - pidstat -p : upon above result, check the corresponding process cpu us+sy 
      - perf/profile: profile cpu usage stack trace 
      - perf: measure IPC as an indicator of cycle-based inefficiencies
      - showboost/turboboost: check current CPU clock rate
      - demsg: check if has stall message "cpu clock throttled"

    - USE mothod 


      - check error firstly 
        - check ECC error 
    - Workload characterization
      - CPU load average
      - user-time to system-time ratio
      - syscall rate
      - voluntary context switch rate
      - interrupt rate 

    - profiling 
      
      flame graph excerpt
      - top-down: to find wide plateau 
      - bottom-up: understand code hirachy and find potential syscall or problems
      - look more carefully top-down for scattered but common cpu usage, especially for lock contentaion,


    - cycle analysis
      
      via PMC conters

    - Performance monitoring

      key Metrics:
      - utilization: percent busy
      - saturation: either run-queue length or scheduler latency

- 6.6 Obersvability Tools

  - uptime

    - load average 
    - pressure stall information(PSI)

      uptime show system-wide resource demand as a whole indicator while PSI can provide indivual resource demand
      ```
      # cat /proc/pressure/cpu
      some avg10=0.00 avg60=0.00 avg300=0.00 total=400731449
      # cat /proc/pressure/io
      some avg10=0.00 avg60=0.00 avg300=0.00 total=26018468
      full avg10=0.00 avg60=0.00 avg300=0.00 total=24924185
      ```

      echo value represent the percentage of time is stall
  - vmstat 

    ```
    vmstat 1
    ```
  - mpstat
  
    ```
    mpstat -P ALL 1
    ```
  - sar

    options 
    - -P ALL: same with mpstat -P ALL 1
    - -u same as mpstat default system-wide average only 
    - -q indlues run-queue size as runq-sz
  
  - ps 
  - top 
  - pidstat

    ```
    pidstat 1 
    ```
    - -t print per-thread statistic
    - -p ALL print all processors
    - -w Report task switching(conext switch) activity
  - interrupts
    -  /proc/interrupts

  - showboost 
    - show CPU clock rate with a per-interval summary
    ```
    # showboost
    Base CPU MHz : 2600
    Set CPU MHz  : 2311
    Turbo MHz(s) : 3200 3300 3500
    Turbo Ratios : 123% 126% 134%
    CPU 0 summary every 1 seconds...

    TIME       C0_MCYC      C0_ACYC        UTIL  RATIO    MHz
    16:29:52   9641272      8683994          0%    90%   2341
    16:29:53   12874461     10854433         0%    84%   2192
    16:29:54   14157863     13560414         0%    95%   2490
    16:29:55   18678820     21028192         0%   112%   2927
    16:29:56   82741629     102457385        3%   123%   3219
    ```


  - pmarch from https://github.com/brendangregg/pmc-cloud-tools
    - show high-levle of CPU cycle performance
    ```
    #pmcarch
    K_CYCLES   K_INSTR      IPC BR_RETIRED   BR_MISPRED  BMR% LLCREF      LLCMISS     LLC%
    911925     40550       0.04 9952661      1870799    18.80 27653893    102351     99.63
    884772     46939       0.05 10364167     1878520    18.13 27944804    132226     99.53
    902134     48183       0.05 9926387      1900407    19.15 28464200    98894      99.65
    ```
      - K_CYCLES: CPU cycle X 1000
      - K_INSTR: CPU instruction X 1000
      - IPC: instructions-per-cycle
      - BMR%: branch mispreditciton ratio
      - LLC%: last level cache hit ratio
  - tlbstat
  
  - perf 
    ```
    # perf sched record -- sleep 10 
    # perf sched latency 

    -----------------------------------------------------------------------------------------------------------------
      Task                  |   Runtime ms  | Switches | Average delay ms | Maximum delay ms | Maximum delay at       |
    -----------------------------------------------------------------------------------------------------------------
      ksoftirqd/48:251      |      0.011 ms |        2 | avg:    3.531 ms | max:    6.068 ms | max at: 867303.405547 s
      ksoftirqd/20:111      |      0.032 ms |        6 | avg:    1.845 ms | max:    6.139 ms | max at: 867303.363621 s
      kworker/26:2:4901     |      0.135 ms |        9 | avg:    0.219 ms | max:    1.506 ms | max at: 867302.043965 s
      kworker/5:0:12042     |      0.185 ms |        5 | avg:    0.210 ms | max:    0.496 ms | max at: 867300.543921 s
      kworker/4:1:36354     |      0.182 ms |        6 | avg:    0.137 ms | max:    0.620 ms | max at: 867297.213990 s
      kworker/7:0:17127     |      0.109 ms |        5 | avg:    0.132 ms | max:    0.448 ms | max at: 867297.267816 s
      kworker/31:2:2214     |      0.166 ms |        7 | avg:    0.119 ms | max:    0.535 ms | max at: 867299.115942 s
      kworker/6:0:14875     |      0.496 ms |       16 | avg:    0.089 ms | max:    0.575 ms | max at: 867298.526970 s
      kworker/27:0:15334    |      0.064 ms |        5 | avg:    0.075 ms | max:    0.217 ms | max at: 867298.621615 s
      kworker/25:1:26119    |      0.074 ms |        4 | avg:    0.071 ms | max:    0.269 ms | max at: 867301.036713 s
      kworker/34:1:26353    |      0.068 ms |        1 | avg:    0.061 ms | max:    0.061 ms | max at: 867303.581665 s
      kworker/21:0:28886    |      0.080 ms |        3 | avg:    0.059 ms | max:    0.164 ms | max at: 867296.680536 s
      kworker/1:0:20214     |      0.146 ms |        2 | avg:    0.052 ms | max:    0.059 ms | max at: 867297.171473 s
      lsmd:1420             |      0.071 ms |        1 | avg:    0.048 ms | max:    0.048 ms | max at: 867298.302523 s
      vmx-vthread-315:31585 |      0.114 ms |        1 | avg:    0.048 ms | max:    0.048 ms | max at: 867300.577119 s
      mate-settings-d:(2)   |      0.403 ms |        2 | avg:    0.047 ms | max:    0.054 ms | max at: 867297.643407 s
      rtkit-daemon:(2)      |      0.149 ms |        2 | avg:    0.043 ms | max:    0.052 ms | max at: 867298.302531 s
      kworker/36:1:627      |      0.050 ms |        1 | avg:    0.042 ms | max:    0.042 ms | max at: 867297.105675 s
      kworker/12:0:50022    |      0.186 ms |        4 | avg:    0.038 ms | max:    0.052 ms | max at: 867299.268881 s
      kworker/10:0:13183    |      0.238 ms |        9 | avg:    0.037 ms | max:    0.067 ms | max at: 867303.487560 s
      kworker/11:2:56105    |      0.304 ms |        6 | avg:    0.036 ms | max:    0.054 ms | max at: 867299.268881 s
      pickup:50659          |      0.211 ms |        1 | avg:    0.036 ms | max:    0.036 ms | max at: 867299.998892 s
      kworker/13:1:49557    |      0.134 ms |        3 | avg:    0.035 ms | max:    0.044 ms | max at: 867303.581610 s
    # perf sched timehist
      Samples do not have callchains.
                time    cpu  task name                       wait time  sch delay   run time
                              [tid/pid]                          (msec)     (msec)     (msec)
      --------------- ------  ------------------------------  ---------  ---------  ---------
        867295.398131 [0000]  perf[52210]                         0.000      0.000      0.000
        867295.398142 [0000]  migration/0[7]                      0.000      0.004      0.010
        867295.398179 [0001]  perf[52210]                         0.000      0.000      0.000
        867295.398187 [0001]  migration/1[13]                     0.000      0.002      0.007
        867295.398259 [0002]  perf[52210]                         0.000      0.000      0.000
        867295.398270 [0002]  migration/2[19]                     0.000      0.003      0.010
        867295.398320 [0001]  <idle>                              0.000      0.000      0.132
        867295.398328 [0001]  rcu_sched[9]                        0.000      0.002      0.008
        867295.398352 [0003]  perf[52210]                         0.000      0.000      0.000
        867295.398362 [0003]  migration/3[24]                     0.000      0.002      0.010
    
    ...
    ```
  - softirqs
  - hardirqs

  

### Chapter 7 Memory

- 7.2 Concetps 

  - 7.2.2 paging
    - file system paging
      - file memory mapping involves files on the filesystem and files in the page cache (memory page)
      - if page in the memory are modified(dirty), call page-out to write to filesystem 
      - page-in will load data from filesystem to page cache

    - anonymous paging(aka swapping)
      - process private data (stack and heap which don't have mapping to filesystem so called anonymous paging)  are write to swap device or swap file

  - 7.2.7 Utilization and satruation

    - how to measure satruation
      - check if there is `page scanning/page-out`  ----> `sar -B` check `pgscank/s`or `pgscand/s` column
      - check if there is `anonymous paging(swapping)`
      - check if there is `OOM killer`

- 7.3 Architeture

  - 7.3.1 Hardware
    
    - MMU
      - TLB(tranlation lookaside buffer): used by MMU to store info about virtual-to-phsical translation, this is first level of such cache
      - page table: if TLB is full, the page table store the virtual-to-physical mapping called page table can be stored in main memory
    - page size
      - modern processor  support muliple page sizes
      - 4k 2M
      - huge page (1G)

    - TLB
      - Can be devided into separate caches fro instruction and data pages
      - if use larger page size, TLB may support wide range of memory mapping
      - TLB can be also devided into separate caches for each of these page sizes
  
  - 7.3.2 Software

    - Free list
      - pages freed via page-out will be added to the tail fo the free list, it can be reclaimed before it is allocated and reused to other process if it requests 
      - completely freed pages are added to the head of the free list that can be allocated and reused immediately

      allocator 
      - slab for kernel process, pick the pages from free list head
      - libc (malloc()) for user space process, pick the pages from free list head
      - buddy allocator (a page allocator)is used to manage pages only, will provides multiple free lists for different-sized memory allocation
       
    - reaping:  mechnism to free slab caches 
    - page scaning: page-out daemon(kswapd) starts page scanning


    - process virtual address space

      - virtual address spaces is a range of virual pages that are mapped to physical pages 
      - it is composed of several segments
        - stacks
          - stacks of the running threads, mapped read/write
        - process excutable
          - executable text: contains the executable CPU instructions for the process
          - executable data: contains initialized variables mapped from the data segment of the binary program, the variables has read/wirte so it can be update when program is running
        - libraries
          - executable text: contains the executable CPU instructions for the process
          - executable data: contains initialized variables mapped from the data segment of the binary program, the variables has read/wirte so it can be update when program is running
        - heap: the working memory for the program and is anonymous memory(no filesystem location), and grows as needed which is allocated with malloc()
    - Allocator

      - kernel allocators
        - slab allocator 
            - array of fixed size(magzine) contains page references per CPU
            - the mazine don't need be full all the time
            - each reference may map to a page 
            - CPU will first to search for the the pages referenced in the magzine, if not mapped, trigger to allocate
        - SLUB (now as default)
          - improvement based on slab
          - remove object queue
          - remove per-CPU caches, leave NUMA optimization to page allocator
      - user-level allocator
        - glibc(malloc)
          - glibc malloc is chunk-oriented
          - its behavior depends on the allocation request size and certain parameters
          - allocation through Arenas ----> heap ----> linked-list of free chunks 
          -  Arena: A structure that is shared among one or more threads which contains references to one or more heaps, as well as linked lists of chunks within those heaps which are "free". Threads assigned to each arena will allocate memory from that arena's free lists.
          - Heap: A contiguous region of memory that is subdivided into chunks to be allocated. Each heap belongs to exactly one arena.
          - Chunk: A small range of memory that can be allocated (owned by the application), freed (owned by glibc), or combined with adjacent chunks into larger ranges; Each chunk exists in one heap and belongs to one arena; chunks can be various sizes
          - Neighboring chunks can be coalesced on a free linked list, no matter what their size is
          - very large allocation use mmap 
            > - https://sourceware.org/glibc/wiki/MallocInternals
            > - https://www.gnu.org/software/libc/manual/html_node/The-GNU-Allocator.html
        - tcmalloc
          - thread caching malloc, uses a small per-thread cache for small allocation, reducing lock contentation and improving performance

        - jemalloc 
          - multiple arenas
          - per-thread caching
          - small object slabs
          - can use mmap and sbrk
          
- 7.4 Methodology

  amoung various mothods, suggested order to use them: performance monitoring  ----> USE mothod  ---> characterizing usage

  - 7.4.1 Tools method 
    - page scanning 
      - `sar -B` to check columns about `pgscan`
      ```
      #  sar -B 1
      Linux 4.18.0-240.el8.x86_64 (centos8-builder.lmy.com)   01/07/2021      _x86_64_        (16 CPU)

      09:26:42 PM  pgpgin/s pgpgout/s   fault/s  majflt/s  pgfree/s pgscank/s pgscand/s pgsteal/s    %vmeff
      09:26:43 PM      0.00      0.00 158656.00      0.00  93551.00      0.00      0.00      0.00      0.00
      09:26:44 PM      0.00      0.00 141477.00      0.00  84958.00      0.00      0.00      0.00      0.00
      09:26:45 PM      0.00     52.00 145182.00      0.00  87636.00      0.00      0.00      0.00      0.00
      ```
    - pressure stall information(PSI)
      -  content in `/proc/pressure/memory`
      ```
      # cat /proc/pressure/memory
      some avg10=0.00 avg60=0.00 avg300=0.00 total=0
      full avg10=0.00 avg60=0.00 avg300=0.00 total=0
      ```
    - swapping(only if swap is configured) 
      - `vmstat` to check `si` and `so` columns
    - free memory 
      - `vmstat` to check `free` column for available memory
    - oom killer 
      - check log for oom killer

    - top
      - check which process ans user are the top physical memory consumers(resident) and virutal memory consumer

    - perf/bcc/bpftrace:
      - trace memory allocation with stack traces to indentify the cause of memory usage
  - 7.4.2 USE method 
    - utilization: physical and virtual memory utilization
    - saturation:
      - pagescanning
        - `sar -B`
      - paging
        - `/proc/pressure/memory`
      - swapping 
        - vmstat 
        - sar 
      - oom killer
        - dmesga
    - Error
      - software and hardware error 
      - allocation error ?
    - kernel cache 
      - slabtop 
      - slabinfo
      - /proc/slabinfo
    - also consider to check if file system cache can be reclaimed 
      - [pcstat](https://github.com/tobert/pcstat) get page cache statistics for files
      - [vmtouch](https://github.com/hoytech/vmtouch) is a tool for learning about and controlling the file system cache of unix and unix-like systems, refer to its [docs](https://hoytech.com/vmtouch/).
        - Telling the OS to cache or evict certain files or regions of files
        - Locking files into memory so the OS won't evict them
        - Preserving virtual memory profile when failing over servers
        - Keeping a "hot-standby" file-server
        - Plotting filesystem cache usage over time
        - Maintaining "soft quotas" of cache usage
        - Speeding up batch/cron jobs
        - And much more...
      - fincore:  counts  pages  of file contents being resident in memory(in core), and reports the numbers.
        ```
        fincore  ./*
        RES PAGES  SIZE FILE
        4K     1  3.7K ./CHANGES
        4K     1  1.4K ./LICENSE
        4K     1  661B ./Makefile
        4K     1  1.1K ./README.md
        4K     1  876B ./TODO
        4K     1  3.1K ./TUNING.md
        84K    21 83.4K ./vmtouch
        16K     4 13.1K ./vmtouch.8
        28K     7 26.8K ./vmtouch.c
        8K     2    8K ./vmtouch.pod
        ```
      - tracepoint `filemap:mm_filemap_add_to_page_cache` can shwo  files added in  page cache
        
        ```
        # perf record -a -e filemap:mm_filemap_add_to_page_cache -- sleep 10
        # perf script
          in:imjournal 3174804 [005] 778175.220246: filemap:mm_filemap_add_to_page_cache: dev 259:2 ino 24009a page=0x361356 pfn=3543894 ofs=0
          in:imjournal 3174804 [005] 778175.220577: filemap:mm_filemap_add_to_page_cache: dev 259:2 ino 240089 page=0x361356 pfn=3543894 ofs=0
          in:imjournal 3174804 [005] 778175.220801: filemap:mm_filemap_add_to_page_cache: dev 259:2 ino 24009a page=0x361356 pfn=3543894 ofs=0
          in:imjournal 3174804 [005] 778175.221078: filemap:mm_filemap_add_to_page_cache: dev 259:2 ino 240089 page=0x361356 pfn=3543894 ofs=0
          in:imjournal 3174804 [005] 778175.221332: filemap:mm_filemap_add_to_page_cache: dev 259:2 ino 24009a page=0x361356 pfn=3543894 ofs=0
          in:imjournal 3174804 [005] 778175.221529: filemap:mm_filemap_add_to_page_cache: dev 259:2 ino 240089 page=0x361356 pfn=3543894 ofs=0
          in:imjournal 3174804 [005] 778175.474158: filemap:mm_filemap_add_to_page_cache: dev 259:2 ino 24009a page=0x361356 pfn=3543894 ofs=0
          in:imjournal 3174804 [005] 778175.474471: filemap:mm_filemap_add_to_page_cache: dev 259:2 ino 240089 page=0x361356 pfn=3543894 ofs=0
          in:imjournal 3174804 [005] 778175.474666: filemap:mm_filemap_add_to_page_cache: dev 259:2 ino 24009a page=0x361356 pfn=3543894 ofs=0
          in:imjournal 3174804 [005] 778175.474877: filemap:mm_filemap_add_to_page_cache: dev 259:2 ino 240089 page=0x361356 pfn=3543894 ofs=0
          in:imjournal 3174804 [005] 778175.475092: filemap:mm_filemap_add_to_page_cache: dev 259:2 ino 24009a page=0x361356 pfn=3543894 ofs=0
          perf 3696180 [001] 778175.635365: filemap:mm_filemap_add_to_page_cache: dev 259:2 ino 4467e page=0x293240 pfn=2699840 ofs=909312
          perf 3696180 [001] 778175.635374: filemap:mm_filemap_add_to_page_cache: dev 259:2 ino 4467e page=0x293241 pfn=2699841 ofs=913408
          perf 3696180 [001] 778175.635381: filemap:mm_filemap_add_to_page_cache: dev 259:2 ino 4467e page=0x60e382 pfn=6349698 ofs=917504
          perf 3696180 [001] 778175.635386: filemap:mm_filemap_add_to_page_cache: dev 259:2 ino 4467e page=0x5586ca pfn=5605066 ofs=921600
        ```
        `dev 259:2` can be checked via `lsblk`, which is `nvme0n1p2` mounted at `/`
        ```
        # lsblk
        NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
        sr0          11:0    1  1024M  0 rom
        nvme0n1     259:0    0   300G  0 disk
        ├─nvme0n1p1 259:1    0   200M  0 part /boot
        └─nvme0n1p2 259:2    0 185.1G  0 part /
        ```

        inode number in `ino 4467e` can be fetched via `find / -mount -inum <inumber>`, 
        > - `4467e` is Hexadecimal  number, so use `0x4467e`
        > - convert Hexadecimal decimal via ` echo $[0x4467e]` results `280190`
        ```
        # find / -mount -inum $((0x4467e)) 
        /root/vmtouch/perf.data

        or 

        # echo $[0x4467e] 
        280190
        # find / -mount -inum 280190 
        /root/vmtouch/perf.data
        ```
  - 7.4.3 Characterizing Usage       

  - 7.4.6 leak detection
    - use bcc tool `memleak`


- 7.5 Observability Tools
  - vmstat
    - -S change unit to Megabyte
      - SM:  1048576 (M) bytes
      - Sm:  1000000 (m)
      - Sk: 1000 (k),
      - SK:  1024 (K),
    - -m Displays slabinfo. 
    - -a breakdown of inactive and active memory for the page cache/ and buffer
  - PSI 
    - /proc/pressure/memory
  - swapon
  - sar 
    - -B: paging statistics
    - -H: Hugepage statistics
    - -r: memory utilization
      - `sar -r ALL 1`: will also show slab info 
    - -S: swap space statistics
    - -W: swaping statistics
  - slabtop
    - -sc : sort by cache size
  - numstat from numactl
    - show statistics for non-uniform memory access(NUMA)
  - ps 
  - top
  - pmap list memory mappings of a process
    -  -x Show the extended format.
    - -X  Show even more details than the -x option
    - -XX  Show everything the kernel provides
  - perf
  - drsnoop
    - tracing the direct reclaim approach to freeing memory, showing hte process affected and the latency: the time taken for the reclaim

  - wss
    - experimental tool to show how a procees working set size(WSS) can be measured using the page table entry "access" bit
    - [wss docs](http://www.brendangregg.com/wss.html)
    - [wss tool](https://github.com/brendangregg/wss)