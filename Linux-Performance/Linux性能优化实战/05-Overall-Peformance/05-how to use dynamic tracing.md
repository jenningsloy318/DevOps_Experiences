how to use dynamic tracing
---
1. list of dynamic tracing
  - ftrace
  - perf
  - ebpf/bcc-tools
  - SystemTap
  - sysdig

2. list of static tracing
  - uprobes
  - kprobes
  - tracepoints

3. example

```
trace-cmd record -p function_graph -g do_sys_open -O funcgraph-proc ls
```

this will trace `ls` call path



4. notes
  - difference of dynamic tracing tool
    - ftrace: tracing every syscall, thus collect many data
    - perf: using sampling analysis, it may lost some details, but with flamegraph we can identify the hot functions