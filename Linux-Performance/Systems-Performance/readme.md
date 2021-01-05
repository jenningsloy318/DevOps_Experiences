Systems Performance 2nd Edition
---
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
