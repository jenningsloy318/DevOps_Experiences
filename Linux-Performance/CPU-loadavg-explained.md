## CPU LOAD AVERAGES
cpu 提供的饱和度，是Unix的平均负载。**平均负载是正在运行的进程数加上正在等待运行的进程数**。同样，布伦丹·格雷格（Brendan Greg）在Linux平均负载方面有「很长的论述](http://www.brendangregg.com/blog/2017-08-08/linux-load-averages.html)。


The original load averages show only CPU demand: the number of processes running plus those waiting to run



```
$ uptime
 16:48:24 up  4:11,  1 user,  load average: 25.25, 23.40, 23.46

top - 16:48:42 up  4:12,  1 user,  load average: 25.25, 23.14, 23.37

$ cat /proc/loadavg 
25.72 23.19 23.35 42/3411 43603
````


Some interpretations:

- If the averages are 0.0, then your system is idle.
- If the 1 minute average is higher than the 5 or 15 minute averages, then load is increasing.
- If the 1 minute average is lower than the 5 or 15 minute averages, then load is decreasing.
- If they are higher than your CPU count, then you might have a performance problem (it depends).



Linux load averages:
 - runnable tasks
 - tasks in the uninterruptible state,includes tasks blocked on disk I/O and some locks,  it shows up as the "D" state in the output `ps` and `top`


 Adding the uninterruptible state means that Linux load averages can increase due to a disk (or NFS) I/O workload, not just CPU demand; reflect demand for other system resources, not just CPUs. Linux changed from "CPU load averages" to what one might call "system load averages".

- On Linux, load averages are (or try to be) "system load averages", for the system as a whole, measuring the number of threads that are working and waiting to work (CPU, disk, uninterruptible locks). Put differently, it measures the number of threads that aren't completely idle. Advantage: includes demand for different resources.
- On other OSes, load averages are "CPU load averages", measuring the number of CPU running + CPU runnable threads. Advantage: can be easier to understand and reason about (for CPUs only).


most systems will be suffering with a load/CPU ratio of just 2.

## Better Metrics
When Linux load averages increase, you know you have higher demand for resources (CPUs, disks, and some locks), but you aren't sure which. You can use other metrics for clarification. For example, for CPUs:

Utilization metrics are useful for workload characterization, and saturation metrics useful for identifying a performance problem

- utilization metrics
    - **per-CPU utilization**: eg, using `mpstat -P ALL 1`  
    - **per-process CPU utilization**: eg, `top`, `pidstat 1`, etc.
- saturation metrics
    - **per-thread run queue (scheduler) latency**: eg, in `/proc/PID/schedstats`, `delaystats`, `perf` `sched`
    - **CPU run queue latency**: eg, in `/proc/schedstat`, `perf sched`, my `runqlat bcc tool`.
    - **CPU run queue length**: eg, using `vmstat 1` and the` 'r' `column, or my runqlen bcc tool.


rule:
- The best CPU saturation metrics are measures of `run queue (or scheduler) latency`: the time a task/thread was in a runnable state, but had to wait its turn
- Measuring the run queue length instead can suggest that there is a problem, but it's more difficult to estimate the magnitude
- scraping the wait-time (scheduler latency) metric from the (undocumented) /proc/sched_debug output:
    ``
    awk 'NF > 7 { if ($1 == "task") { if (h == 0) { print; h=1 } } else { print } }' /proc/sched_debug
    ```