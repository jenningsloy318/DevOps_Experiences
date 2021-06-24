Records on real issue 
---

1. HANA HA crash very offten 
  - environment: SLES 12 SP1  with SLE HA + HANA 1.0 
  - symptom : the HANA HA will crash very offten, and the whole system will failover very quickly
  - proceedure to investigate:
    - first we suspect the network issue, check the network services, and switches, but not found
    - occasional we found the disk write is slow, suspect the disk has issue, but still no clu
    - check dmesg and /var/log/message again, some lines attract my attention, seems the audit service produced too many audit logs
      ```
      [1429444.479956] audit_log_start: 34 callbacks suppressed
      [1429444.479960] audit: audit_backlog=8193 > audit_backlog_limit=8192
      [1429444.479962] audit: audit_lost=3222452 audit_rate_limit=0 audit_backlog_limit=8192
      [1429444.481387] audit: audit_backlog=8193 > audit_backlog_limit=8192
      [1429444.481390] audit: audit_lost=3222453 audit_rate_limit=0 audit_backlog_limit=8192
      [1429444.481468] audit: audit_backlog=8193 > audit_backlog_limit=8192
      [1429444.481471] audit: audit_lost=3222454 audit_rate_limit=0 audit_backlog_limit=8192
      [1429444.483452] audit: audit_backlog=8193 > audit_backlog_limit=8192
      [1429444.483455] audit: audit_lost=3222455 audit_rate_limit=0 audit_backlog_limit=8192
      [1429444.484452] audit: audit_backlog=8193 > audit_backlog_limit=8192
      [1429444.484455] audit: audit_lost=3222456 audit_rate_limit=0 audit_backlog_limit=8192
      ``` 
    - further checking, it may be caused by the audit send too much events to kernel which may exhausted the kernel buffer
    - two autdit process found on the system
      ```
      # ps -ef | grep audit
      root      1483     1  0 10:11 ?        00:00:00 /sbin/auditd
      root      1486     2  0 10:11 ?        00:00:00 [kauditd]
      ```

      The `/sbin/auditd` daemon is the user-space audit daemon, It registers itself with the Linux kernel audit subsystem (through the audit netlink system), which responds with spawning the `kauditd` kernel thread/process

      generated audit event messages are not directly relayed to the audit daemon - they are first `queued in a sort-of backlog`, which is where the backlog-related messages above come from.
    - details about Audit backlog queue

      In the kernel-level audit subsystem, a socket buffer queue is used to hold audit events.Whenever a new audit event is received, it is logged and prepared to be added to this queue. Adding to this queue can be controlled through a few parameters.
      - The first parameter is the backlog limit
        Be it through a kernel boot parameter (`audit_backlog_limit=N`) or through a message relayed by the user-space audit daemon (`auditctl -b N`),this limit will ensure that a queue cannot grow beyond a certain size
      - The second parameter is the rate limit
        When more audit events are logged within a second than set through this parameter (which can be controlled through a message relayed by the user-space audit system, using auditctl -r N) then those audit events are not added to the queue
      - If an audit event cannot be logged, then this failure needs to be resolved.
        The Linux audit subsystem can be configured do either silently discard the message, switch to the kernel log subsystem, or panic. This can be configured through the audit user-space (auditctl -f [0..2]), but is usually left at the default (which is 1, being to switch to the kernel log subsystem).  
        
        if the system is not configured to silently discard it, or to panic the system, then the "dropped" messages are sent to the kernel log subsystem. The calls however are also governed through a configurable limitation: it uses a rate limit which can be set through sysctl:
        ```
        # sysctl -a | grep kernel.printk_rate
        kernel.printk_ratelimit = 5
        kernel.printk_ratelimit_burst = 10
        ```
        his system allows one message every 5 seconds, but does allow a burst of up to 10 messages at once. When the rate limitation kicks in, then the kernel will log (at most one per second) the number of suppressed events:`audit_log_start: 34 callbacks suppressed`
      - backlog queue is a memory queue,
      - the kenel handle the error via 
        ```
        Records can be lost in several ways:
        0) [suppressed in audit_alloc]
        1) out of memory in audit_log_start [kmalloc of struct audit_buffer]
        2) out of memory in audit_log_move [alloc_skb]
        3) suppressed due to audit_rate_limit
        4) suppressed due to audit_backlog_limit
        ```
        We hitted the second situation, the out of memory in audit_log_start.
        so the kernle memoy buffer is full with audit event, which impact the system heavily, as indicated earlier, network may be lost and network connection establishment need kernel memory, and page cache also need(result in disk performance decrease)
    - solutions
      1. config `backpressure_strategy` in auditbeat, but this kernel too old, that don't support this parameter
        ```
        The possible values are:

        auto (default): Auditbeat uses the kernel strategy, if supported, or falls back to the userspace strategy.
        kernel: Auditbeat sets the backlog_wait_time in the kernel’s audit framework to 0. This causes events to be discarded in the kernel if the audit backlog queue fills to capacity. Requires a 3.14 kernel or newer.
        userspace: Auditbeat drops events when there is backpressure from the publishing pipeline. If no rate_limit is set, Auditbeat sets a rate limit of 5000. Users should test their setup and adjust the rate_limit option accordingly.
        both: Auditbeat uses the kernel and userspace strategies at the same time.
        none: No backpressure mitigation measures are enabled.
        ```
      2. disable audit service
      3. upgrade os to new version -- done this






