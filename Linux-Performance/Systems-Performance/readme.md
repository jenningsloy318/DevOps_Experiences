Systems Performance 2nd Edition
---


- [Chapter 3 Operating System](#Chapter-3-Operating-System)
- [Chapter 4 Observability Tools](#Chapter-4-Observability-Tools)
- [Chapter 5 Applications](#Chapter-5-Applications)
- [Chapter 6 CPUs](#Chapter-6-CPUs)


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
        - showboost,cpuhot,cputemp
        - pmcarch,cpucache,icache,tlbstat,resstalls
        - tiptop
        - nicstat
  
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
      
      # cat /proc/pressure/memory
      some avg10=0.00 avg60=0.00 avg300=0.00 total=0
      full avg10=0.00 avg60=0.00 avg300=0.00 total=0
      
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