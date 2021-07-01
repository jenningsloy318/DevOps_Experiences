How to deal with high CPU usage of kernel threads
---

process:
- pid 1: `systemd` process, manage all userspace processes and threads
- pid 2: `kthreadd` process, mange all kernel processes and threads


  all kernel threads are children of `kthreadd`

- show all kernel threads
  ```
  ps -f --ppid 2 -p 2
  ```
  - kswapd0: swaps processes to disk
  - kworker: Execute workqueue requests, `kworker/%u:%d%s (cpu, id, priority)`, two categories binded-CPU(`[kworker/0:2-eve]`) and unbound(`[kworker/u8:1-ev]`)
  - migration: Used to move processes between CPUs - for load balancing
  - ksoftirqd: Kernel healper thread to handle softirqs that can't be handled immediately
  - watchdogd: Notices if the system appears to be hung
  - kdmflush: used by Device Mapper to process deferred work that it has queued up from other contexts where doing immediately so would be problematic.
  - irq: deal with hardware interrupts
  - jbd2: kernel journaling thread which is responsible for scheduling updates to the log.
  - kauditd: kernel thread for handling audit events
  - kblockd: used for running low-level disk operations
- use top to check cpu usage
  - ksoftirqd/0 and ksoftirqd/1 used much more cpu resource
  - this indicates network issue, too much network connections ? 
- use perf to check the ksoftirq/1, whose pid is 9
  ```
  perf record -a -g -p 9 -- sleep 30
  ```
  then 
  ```
  perf report
  ```

- use flameGraph to identify  which function used the cpu resource

