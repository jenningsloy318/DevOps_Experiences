how to use dynamic tracing
---
1. list of dynamic tracing technology
  - uprobes
  - kprobes
2. list of dynamic tracing tools
  - ftrace/trace-cmd 
  - perf
  - ebpf/bcc-tools
  - SystemTap: only working properly on RHEL based systems
  - sysdig
  - ptrace/strace: will heavily impact the system performance

3. list of static tracing technology
  - tracepoints
  - usdt(Userland Statically Defined Tracing)

4. example
- to trace `ls` command, which invoke the kernel function `do_sys_open`, we need to enable `funcgraph-proc` and  track the function calling path `function_graph` in `trace-cmd`
  ```
  trace-cmd record -p function_graph -g do_sys_open -O funcgraph-proc ls
  ```

  this will trace `ls` call path
- use perf 
  ```
  perf probe --add 'do_sys_open filename:string' # add probe
  perf record -e probe:do_sys_open -aR ls
  perf script
  perf probe --del probe:do_sys_open # remove probe
  ```
- we can also use `perf trace ls` to achieve same goal

- trace `/bin/bash` to call `function readline`
  ```
  perf probe --del probe:do_sys_open # add probe
  perf record -e probe_bash:readline__return -aR sleep 5
  perf script
  perf probe --del probe_bash:readline__return #  remove probe
  ```
  if not sure the exact function name , use `perf probe -x /bin/bash —funcs` to list and  `perf probe -x /bin/bash -V readline` to check the function  parameter

- sysdig = strace + tcpdump + htop + iftop + lsof + docker inspect
4. notes
  - difference of dynamic tracing tool
    - ftrace: tracing every syscall, thus collect many data
    - perf: using sampling analysis, it may lost some details, but with flamegraph we can identify the hot functions