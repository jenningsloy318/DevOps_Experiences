# Flame Graphs for performance analysis

Performance issues can be categorized into one of two types:

- On-CPU: where threads are spending time running on-CPU.
- Off-CPU: where time is spent waiting while blocked on I/O, locks, timers, paging/swapping, etc.



## On-CPU-Analysis
Link: 
- http://www.brendangregg.com/FlameGraphs/cpuflamegraphs.html

multiple tools can be used 
- perf
    ```
    # git clone https://github.com/brendangregg/FlameGraph  # or download it from github
    # cd FlameGraph
    # perf record -F 99 -a -g -- sleep 60
    # perf script | ./stackcollapse-perf.pl > out.perf-folded
    # ./flamegraph.pl out.perf-folded > perf-kernel.svg
    ```
- dtrace 
    ```
    # git clone https://github.com/brendangregg/FlameGraph  # or download it from github
    # cd FlameGraph
    # dtrace -x ustackframes=100 -n 'profile-99 /execname == "mysqld" && arg1/ {
        @[ustack()] = count(); } tick-60s { exit(0); }' -o out.stacks
    # ./stackcollapse.pl out.stacks > out.folded
    # ./flamegraph.pl out.folded > out.svg
    ```
- SystemTap
    ```
    # stap -s 32 -D MAXBACKTRACE=100 -D MAXSTRINGLEN=4096 -D MAXMAPENTRIES=10240 \
        -D MAXACTION=10000 -D STP_OVERLOAD_THRESHOLD=5000000000 --all-modules \
        -ve 'global s; probe timer.profile { s[backtrace()] <<< 1; } 
        probe end { foreach (i in s+) { print_stack(i);
        printf("\t%d\n", @count(s[i])); } } probe timer.s(60) { exit(); }' \
        > out.stap-stacks
    # ./stackcollapse-stap.pl out.stap-stacks > out.stap-folded
    # cat out.stap-folded | ./flamegraph.pl > stap-kernel.svg
    ```
- ktap
    ```
    # ktap -e 's = ptable(); profile-1ms { s[backtrace(12, -1)] <<< 1 }
        trace_end { for (k, v in pairs(s)) { print(k, count(v), "\n") } }
        tick-30s { exit(0) }' -o out.kstacks
    # sed 's/	//g' out.kstacks | stackcollapse.pl > out.kstacks.folded
    # ./flamegraph.pl out.kstacks.folded > out.kstacks.svg
    ```

## Off-CPU-Analysis
Link:
- http://www.brendangregg.com/offcpuanalysis.html



To start with, I'll show total off-CPU time from a tool that may already be familiar to you. The time(1) command. Eg, timing tar(1):
```
$ time tar cf backup.tar /data

real	0m50.798s
user	0m1.048s
sys	0m11.627s
```

-  it only spent 1.0 seconds of user-mode CPU time,
-  11.6 seconds of kernel-mode CPU time
-  missing 38.2 seconds which is the time the tar command was blocked off-CPU, no doubt doing storage I/O as part of its archive generation.



- Measuring tar's off-CPU time:
```
/usr/share/bcc/tools/cpudist -O -p `pgrep -nx tar`
Tracing off-CPU time... Hit Ctrl-C to end.
^C
     usecs               : count     distribution
         0 -> 1          : 0        |                                        |
         2 -> 3          : 69       |*******                                 |
         4 -> 7          : 362      |****************************************|
         8 -> 15         : 204      |**********************                  |
        16 -> 31         : 293      |********************************        |
        32 -> 63         : 170      |******************                      |
        64 -> 127        : 52       |*****                                   |
       128 -> 255        : 14       |*                                       |
       256 -> 511        : 3        |                                        |
       512 -> 1023       : 1        |                                        |
```

This shows that most of the blocking events were between 64 and 255 microseconds, which is consistent with flash storage I/O latency.


- use bcc/eBPF offcputime to measure blocking stacks for the tar program
```
 /usr/share/bcc/tools/offcputime -K -p `pgrep -nx tar`
Tracing off-CPU time (us) of PID 550188 by kernel stack... Hit Ctrl-C to end.
^C
    b'finish_task_switch'
    b'__schedule'
    b'_cond_resched'
    b'down_read_killable'
    b'iterate_dir'
    b'ksys_getdents64'
    b'__x64_sys_getdents64'
    b'do_syscall_64'
    b'entry_SYSCALL_64_after_hwframe'
    -                tar (550188)
        5

    b'finish_task_switch'
    b'__schedule'
    b'_cond_resched'
    b'down_read'
    b'xfs_ilock_data_map_shared'
    b'xfs_dir2_block_getdents'
    b'xfs_readdir'
    b'iterate_dir'
    b'ksys_getdents64'
    b'__x64_sys_getdents64'
    b'do_syscall_64'
    b'entry_SYSCALL_64_after_hwframe'
    -                tar (550188)
        14

    b'finish_task_switch'
    b'__schedule'
    b'_cond_resched'
    b'kmem_cache_alloc'
    b'kmem_zone_alloc'
    b'xfs_trans_alloc'
    b'xfs_vn_update_time'
    b'file_update_time'
    b'xfs_file_aio_write_checks'
    b'xfs_file_buffered_aio_write'
    b'new_sync_write'
    b'vfs_write'
    b'ksys_write'
    b'do_syscall_64'
    b'entry_SYSCALL_64_after_hwframe'
    -                tar (550188)
        36

    b'finish_task_switch'
    b'__schedule'
    b'_cond_resched'
    b'kmem_cache_alloc'
    b'getname_flags.part.0'
    b'user_path_at_empty'
    b'do_readlinkat'
    b'__x64_sys_readlinkat'
    b'do_syscall_64'
    b'entry_SYSCALL_64_after_hwframe'
    -                tar (550188)
        49

    b'finish_task_switch'
    b'__schedule'
    b'_cond_resched'
    b'down_read'
    b'xfs_log_commit_cil'
    b'__xfs_trans_commit'
    b'xfs_vn_update_time'
    b'file_update_time'
    b'xfs_file_aio_write_checks'
    b'xfs_file_buffered_aio_write'
    b'new_sync_write'
    b'vfs_write'
    b'ksys_write'
    b'do_syscall_64'
    b'entry_SYSCALL_64_after_hwframe'
    -                tar (550188)
        76

    b'finish_task_switch'
    b'__schedule'
    b'_cond_resched'
    b'dput'
    b'fsnotify_parent'
    b'vfs_read'
    b'ksys_read'
    b'do_syscall_64'
    b'entry_SYSCALL_64_after_hwframe'
    -                tar (550188)
        80

    b'finish_task_switch'
    b'__schedule'
    b'_cond_resched'
    b'down_write'
    b'xfs_ilock'
    b'xfs_file_buffered_aio_write'
    b'new_sync_write'
    b'vfs_write'
    b'ksys_write'
    b'do_syscall_64'
    b'entry_SYSCALL_64_after_hwframe'
    -                tar (550188)
        87

    b'finish_task_switch'
    b'__schedule'
    b'_cond_resched'
    b'__sb_start_write'
    b'vfs_write'
    b'ksys_write'
    b'do_syscall_64'
    b'entry_SYSCALL_64_after_hwframe'
    -                tar (550188)
        106

    b'finish_task_switch'
    b'__schedule'
    b'_cond_resched'
    b'down_write'
    b'xfs_buffered_write_iomap_begin'
    b'iomap_apply'
    b'iomap_file_buffered_write'
    b'xfs_file_buffered_aio_write'
    b'new_sync_write'
    b'vfs_write'
    b'ksys_write'
    b'do_syscall_64'
    b'entry_SYSCALL_64_after_hwframe'
    -                tar (550188)
        113

    b'finish_task_switch'
    b'__schedule'
    b'_cond_resched'
    b'dput'
    b'path_put'
    b'do_readlinkat'
    b'__x64_sys_readlinkat'
    b'do_syscall_64'
    b'entry_SYSCALL_64_after_hwframe'
    -                tar (550188)
        116

    b'finish_task_switch'
    b'__schedule'
    b'_cond_resched'
    b'__fput'
    b'task_work_run'
    b'prepare_exit_to_usermode'
    b'entry_SYSCALL_64_after_hwframe'
    -                tar (550188)
        144

    b'finish_task_switch'
    b'__schedule'
    b'_cond_resched'
    b'kmem_cache_alloc'
    b'__alloc_file'
    b'alloc_empty_file'
    b'path_openat'
    b'do_filp_open'
    b'do_sys_openat2'
    b'__x64_sys_openat'
    b'do_syscall_64'
    b'entry_SYSCALL_64_after_hwframe'
    -                tar (550188)
        173

    b'finish_task_switch'
    b'__schedule'
    b'_cond_resched'
    b'down_read'
    b'xfs_ilock_data_map_shared'
    b'xfs_dir_open'
    b'do_dentry_open'
    b'path_openat'
    b'do_filp_open'
    b'do_sys_openat2'
    b'__x64_sys_openat'
    b'do_syscall_64'
    b'entry_SYSCALL_64_after_hwframe'
    -                tar (550188)
        173

    b'finish_task_switch'
    b'__schedule'
    b'_cond_resched'
    b'down_read'
    b'xfs_free_eofblocks'
    b'xfs_release'
    b'__fput'
    b'task_work_run'
    b'prepare_exit_to_usermode'
    b'entry_SYSCALL_64_after_hwframe'
    -                tar (550188)
        244

    b'finish_task_switch'
    b'__schedule'
    b'_cond_resched'
    b'kmem_cache_alloc'
    b'getname_flags.part.0'
    b'user_path_at_empty'
    b'vfs_statx'
    b'__do_sys_newfstatat'
    b'do_syscall_64'
    b'entry_SYSCALL_64_after_hwframe'
    -                tar (550188)
        260

    b'finish_task_switch'
    b'__schedule'
    b'_cond_resched'
    b'kmem_cache_alloc'
    b'getname_flags.part.0'
    b'do_sys_openat2'
    b'__x64_sys_openat'
    b'do_syscall_64'
    b'entry_SYSCALL_64_after_hwframe'
    -                tar (550188)
        269

    b'finish_task_switch'
    b'__schedule'
    b'_cond_resched'
    b'down_read'
    b'xfs_ilock_data_map_shared'
    b'xfs_dir2_leaf_getdents'
    b'xfs_readdir'
    b'iterate_dir'
    b'ksys_getdents64'
    b'__x64_sys_getdents64'
    b'do_syscall_64'
    b'entry_SYSCALL_64_after_hwframe'
    -                tar (550188)
        307

    b'finish_task_switch'
    b'__schedule'
    b'_cond_resched'
    b'task_work_run'
    b'prepare_exit_to_usermode'
    b'entry_SYSCALL_64_after_hwframe'
    -                tar (550188)
        436

    b'finish_task_switch'
    b'__schedule'
    b'_cond_resched'
    b'dput'
    b'__fput'
    b'task_work_run'
    b'prepare_exit_to_usermode'
    b'entry_SYSCALL_64_after_hwframe'
    -                tar (550188)
        465

    b'finish_task_switch'
    b'__schedule'
    b'_cond_resched'
    b'pagecache_get_page'
    b'grab_cache_page_write_begin'
    b'iomap_write_begin'
    b'iomap_write_actor'
    b'iomap_apply'
    b'iomap_file_buffered_write'
    b'xfs_file_buffered_aio_write'
    b'new_sync_write'
    b'vfs_write'
    b'ksys_write'
    b'do_syscall_64'
    b'entry_SYSCALL_64_after_hwframe'
    -                tar (550188)
        507

    b'finish_task_switch'
    b'__schedule'
    b'schedule'
    b'rwsem_down_write_slowpath'
    b'xfs_buffered_write_iomap_begin'
    b'iomap_apply'
    b'iomap_file_buffered_write'
    b'xfs_file_buffered_aio_write'
    b'new_sync_write'
    b'vfs_write'
    b'ksys_write'
    b'do_syscall_64'
    b'entry_SYSCALL_64_after_hwframe'
    -                tar (550188)
        508

    b'finish_task_switch'
    b'__schedule'
    b'_cond_resched'
    b'kmem_cache_alloc'
    b'security_file_alloc'
    b'__alloc_file'
    b'alloc_empty_file'
    b'path_openat'
    b'do_filp_open'
    b'do_sys_openat2'
    b'__x64_sys_openat'
    b'do_syscall_64'
    b'entry_SYSCALL_64_after_hwframe'
    -                tar (550188)
        868

    b'finish_task_switch'
    b'__schedule'
    b'_cond_resched'
    b'copy_page_to_iter'
    b'generic_file_read_iter'
    b'xfs_file_buffered_aio_read'
    b'xfs_file_read_iter'
    b'new_sync_read'
    b'vfs_read'
    b'ksys_read'
    b'do_syscall_64'
    b'entry_SYSCALL_64_after_hwframe'
    -                tar (550188)
        1005

    b'finish_task_switch'
    b'__schedule'
    b'_cond_resched'
    b'down_read'
    b'xfs_ilock'
    b'xfs_file_buffered_aio_read'
    b'xfs_file_read_iter'
    b'new_sync_read'
    b'vfs_read'
    b'ksys_read'
    b'do_syscall_64'
    b'entry_SYSCALL_64_after_hwframe'
    -                tar (550188)
        1019

    b'finish_task_switch'
    b'__schedule'
    b'schedule'
    b'schedule_hrtimeout_range_clock'
    b'do_sys_poll'
    b'__x64_sys_poll'
    b'do_syscall_64'
    b'entry_SYSCALL_64_after_hwframe'
    -                tar (550188)
        1247

    b'finish_task_switch'
    b'__schedule'
    b'_cond_resched'
    b'dput'
    b'terminate_walk'
    b'path_openat'
    b'do_filp_open'
    b'do_sys_openat2'
    b'__x64_sys_openat'
    b'do_syscall_64'
    b'entry_SYSCALL_64_after_hwframe'
    -                tar (550188)
        1767

    b'finish_task_switch'
    b'__schedule'
    b'_cond_resched'
    b'dput'
    b'path_put'
    b'vfs_statx'
    b'__do_sys_newfstatat'
    b'do_syscall_64'
    b'entry_SYSCALL_64_after_hwframe'
    -                tar (550188)
        2320

    b'finish_task_switch'
    b'__schedule'
    b'_cond_resched'
    b'__alloc_pages_nodemask'
    b'pagecache_get_page'
    b'grab_cache_page_write_begin'
    b'iomap_write_begin'
    b'iomap_write_actor'
    b'iomap_apply'
    b'iomap_file_buffered_write'
    b'xfs_file_buffered_aio_write'
    b'new_sync_write'
    b'vfs_write'
    b'ksys_write'
    b'do_syscall_64'
    b'entry_SYSCALL_64_after_hwframe'
    -                tar (550188)
        3043

    b'finish_task_switch'
    b'__schedule'
    b'_cond_resched'
    b'generic_file_read_iter'
    b'xfs_file_buffered_aio_read'
    b'xfs_file_read_iter'
    b'new_sync_read'
    b'vfs_read'
    b'ksys_read'
    b'do_syscall_64'
    b'entry_SYSCALL_64_after_hwframe'
    -                tar (550188)
        3115

    b'finish_task_switch'
    b'__schedule'
    b'schedule'
    b'prepare_exit_to_usermode'
    b'swapgs_restore_regs_and_return_to_usermode'
    -                tar (550188)
        4384

    b'finish_task_switch'
    b'__schedule'
    b'schedule'
    b'prepare_exit_to_usermode'
    b'entry_SYSCALL_64_after_hwframe'
    -                tar (550188)
        5418

    b'finish_task_switch'
    b'__schedule'
    b'_cond_resched'
    b'iomap_write_actor'
    b'iomap_apply'
    b'iomap_file_buffered_write'
    b'xfs_file_buffered_aio_write'
    b'new_sync_write'
    b'vfs_write'
    b'ksys_write'
    b'do_syscall_64'
    b'entry_SYSCALL_64_after_hwframe'
    -                tar (550188)
        11059
```
- now include user-level stacks:

```
/usr/share/bcc/tools/offcputime -p `pgrep -nx tar`


Tracing off-CPU time (us) of PID 763494 by user + kernel stack... Hit Ctrl-C to end.

    b'finish_task_switch'
    b'__schedule'
    b'schedule'
    b'prepare_exit_to_usermode'
    b'swapgs_restore_regs_and_return_to_usermode'
    b'[unknown]'
    b'dump_file0'
    b'dump_file'
    b'dump_dir0'
    b'dump_dir'
    b'dump_file0'
    b'dump_file'
    b'dump_dir0'
    b'dump_dir'
    b'dump_file0'
    b'dump_file'
    b'dump_dir0'
    b'dump_dir'
    b'dump_file0'
    b'dump_file'
    b'create_archive'
    b'main'
    b'__libc_start_main'
    b'[unknown]'
    -                tar (763494)
        2

    b'finish_task_switch'
    b'__schedule'
    b'schedule'
    b'prepare_exit_to_usermode'
    b'entry_SYSCALL_64_after_hwframe'
    b'__GI___openat'
    b'dump_file0'
    b'dump_file'
    b'dump_dir0'
    b'dump_dir'
    b'dump_file0'
    b'dump_file'
    b'dump_dir0'
    b'dump_dir'
    b'dump_file0'
    b'dump_file'
    b'dump_dir0'
    b'dump_dir'
    b'dump_file0'
    b'dump_file'
    b'dump_dir0'
    b'dump_dir'
    b'dump_file0'
    b'dump_file'
    b'dump_dir0'
    b'dump_dir'
    b'dump_file0'
    b'dump_file'
    b'dump_dir0'
    b'dump_dir'
    b'dump_file0'
    b'dump_file'
    b'dump_dir0'
    b'dump_dir'
    b'dump_file0'
    b'dump_file'
    b'create_archive'
    b'main'
    b'__libc_start_main'
    b'[unknown]'
    -                tar (763494)
        2

    ....
```





## Flame Graphs
Link: 
- http://www.brendangregg.com/flamegraphs.html
- https://www.ruanyifeng.com/blog/2017/09/flame-graph.html

火焰图是基于 perf 结果产生的 SVG 图片，用来展示 CPU 的调用栈。


y 轴表示调用栈，每一层都是一个函数。调用栈越深，火焰就越高，顶部就是正在执行的函数，下方都是它的父函数。

x 轴表示抽样数，如果一个函数在 x 轴占据的宽度越宽，就表示它被抽到的次数多，即执行的时间长。注意，x 轴不代表时间，而是所有的调用栈合并后，按字母顺序排列的。


火焰图就是看顶层的哪个函数占据的宽度最大。只要有"平顶"（plateaus），就表示该函数可能存在性能问题。
