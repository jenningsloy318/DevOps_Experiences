**auditd** is a audit service running on most linux, based on pre-configured rules, Audit generates log entries to record as much information about the events that are happening on your system as possible

---
audit.rules: is a file containing audit rules that will be loaded by the audit daemon's init script whenever the daemon is started. The audit rules come in 3 varieties: control, file, and syscall.

- Control

    Control commands generally involve configuring the audit system rather than telling it what to watch for. These commands typically include deleting all rules, setting the size of the kernel's backlog queue, setting the failure mode, setting the event rate limit, or to tell auditctl to ignore syntax errors in the rules and continue loading. Generally, these rules are at the top of the rules file.

- File System

    File System rules are sometimes called watches, The syntax of these rules generally follow this format: 
    ```rukes
    -w path-to-file -p permissions -k keyname
    ```
    * path_to_file:  is the file or directory that is audited.
    * permissions are the permissions that are logged:
        - r: read of the file
        - w： write to the file
        - x: execute the file
        - a:  change in the file's attribute
    * key_name: is an optional string that helps you identify which rule or a set of rules generated a particular log entry.

- System Call
    
    The Linux kernel has 4 rule matching lists or filters as they are sometimes called. They are: **task, exit, user, and exclude**

    - The **task** list:  is checked only during the fork or clone syscalls. It is rarely used in practice.
    - The **exit** filter: is the place where all syscall and file system audit requests are evaluated.
    - The **user** filter: is used to filter (remove) some events that originate in user space. By default, any event originating in user space is allowed. So, if there are some events that you do not want to see, then this is a place where some can be removed
    - The **exclude** filter： is used to exclude certain events from being emitted


    Syscall rules take the general form of:
    ```rules
    -a action,list -S syscall -F field=value -k keyname
    ```

    - The **-a** option tells the kernel's rule matching engine that we want to append a rule at the end of the rule list(task,exit,user,exclude).
        * always:  always create an event
        * never: never create an event
    - Replacing -a with -A in the above command will insert the rule at the top instead of at the bottom.
    - The **-S** option. This field can either be the syscall name or number,For readability, the name is almost always used, You may give more than one syscall in a rule by specifying another -S option. we can get all syscall from http://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/ and https://github.com/torvalds/linux/tree/master/arch/x86/entry/syscalls and https://github.com/thevivekpandey/syscalls-table-64bit
    - The **-F** options that fine tune what to match against. field=value specifies additional options that furthermore modify the rule to match events based on a specified architecture, group ID, process ID, and others. For a full listing of all available field types and their values, see the auditctl(8) man page. ` -F [n=v | n!=v | n<v | n>v | n<=v | n>=v | n&v | n&=v]`



        Fields | Description
        ---------------|-----------
        |a0, a1, a2, a3 | Respectively, the first 4 arguments to a syscall. Note that    string arguments are not supported. This  is  because  the  kernel  is      passed    apointer  to the string. Triggering on a pointer address value is     not likely to   work. So, when using this, you should only use on numeric   values. This is most    likely to be used on platforms that multiplex socket  or IPC operations.
        |arch        |The CPU architecture of the syscall. The arch can be found doing   'uname -m'. If you do not know the arch of your machine but you want to  use    the     32  bit syscall table and your machine supports 32 bit, you can also   use b32 for   the arch. The same applies to the 64 bit syscall table,you can  use b64.  In this  way, you can write rules that are somewhat arch independent   because the family   type will be auto detected. However,syscalls  can  be    arch specific and what is   available on x86_64, may not be available on ppc.  The arch directive should   precede the -S option so that auditctl knows which   internal table to use to look  up the syscall numbers.
        |auid        |The original ID the user logged in with. Its an abbreviation of    audit uid. Sometimes its referred to as loginuid.  Either  the  user  account   text    or number may be used.
        |devmajor    |Device Major Number
        |devminor    |Device Minor Number
        |dir         |Full  Path of Directory to watch. This will place a recursive     watch   on the directory and its whole subtree. It can only be used on exit     list. 
        |egid        |Effective Group ID. May be numeric or the groups name.
        |euid        |Effective User ID. May be numeric or the user account name.
        |exe         |Absolute path to application that while executing this rule will   apply to. This can only be used on the exit list.
        |exit        |Exit value from a syscall. If the exit code is an errno, you may  use  the text representation, too.
        |fsgid       |Filesystem Group ID. May be numeric or the groups name.
        |fsuid      |Filesystem User ID. May be numeric or the user account name.
        |filetype    |The target file's type. Can be either file, dir, socket, link,     character, block, or fifo.
        |gid         |Group ID. May be numeric or the groups name.
        |inode      | Inode Number
        |key        | This is another way of setting a filter key. See discussion   above     for -k option.
        |msgtype     |This is used to match the event's record type. It should only be   used on the exclude or user filter lists.
        |obj_uid     |Object's UID
        |obj_gid     |Object's GID
        |obj_user    |Resource's SE Linux User
        |obj_role    |Resource's SE Linux Role
        |obj_type   | Resource's SE Linux Type
        |obj_lev_low |Resource's SE Linux Low Level
        |obj_lev_high |Resource's SE Linux High Level
        |path        |Full Path of File to watch. It can only be used on exit list.
        |perm        |Permission filter for file operations. See "-p". It can only be   used  on exit list. You can use this without specifying a syscall and the     kernel will  select the syscalls that satisfy the permissions being requested.
        |pers        |OS Personality Number
        |pid        | Process ID
        |ppid       | Parent's Process ID
        |subj_user   |Program's SE Linux User
        |subj_role  | Program's SE Linux Role
        |subj_type  | Program's SE Linux Type
        |subj_sen   | Program's SE Linux Sensitivity
        |subj_clr   | Program's SE Linux Clearance
        |sgid       | Saved Group ID. See getresgid(2) man page.
        |success    | If the exit value is >= 0 this is true/yes otherwise its  false/no.    When writing a rule, use a 1 for true/yes and a 0 for false/no
        |suid        |Saved User ID. See getresuid(2) man page.
        |uid        | User ID. May be numeric or the user account name.


        if the filed is msgtype, the type lists are: 

        Event Type| 	Explanation
        ------------|-------------
        |ADD_GROUP	|Triggered when a user-space group is added.
        |ADD_USER	|Triggered when a user-space user account is added.
        |ANOM_ABEND	|Triggered when a processes ends abnormally (with a signal that could cause a core dump, if enabled).
        |ANOM_ACCESS_FS	|Triggered when a file or a directory access ends abnormally.
        |ANOM_ADD_ACCT	|Triggered when a user-space account addition ends abnormally.
        |ANOM_AMTU_FAIL	|Triggered when a failure of the Abstract Machine Test Utility (AMTU) is detected.
        |ANOM_CRYPTO_FAIL	|Triggered when a failure in the cryptographic system is detected.
        |ANOM_DEL_ACCT	|Triggered when a user-space account deletion ends abnormally.
        |ANOM_EXEC	|Triggered when an execution of a file ends abnormally.
        |ANOM_LOGIN_ACCT	|Triggered when an account login attempt ends abnormally.
        |ANOM_LOGIN_FAILURES	|Triggered when the limit of failed login attempts is reached.
        |ANOM_LOGIN_LOCATION	|Triggered when a login attempt is made from a forbidden location.
        |ANOM_LOGIN_SESSIONS	|Triggered when a login attempt reaches the maximum amount of concurrent sessions.
        |ANOM_LOGIN_TIME	|Triggered when a login attempt is made at a time when it is prevented by, for example, pam_time.
        |ANOM_MAX_DAC	|Triggered when the maximum amount of Discretionary Access Control (DAC) failures is reached.
        |ANOM_MAX_MAC	|Triggered when the maximum amount of Mandatory Access Control (MAC) failures is reached.
        |ANOM_MK_EXEC	|Triggered when a file is made executable.
        |ANOM_MOD_ACCT	|Triggered when a user-space account modification ends abnormally.
        |ANOM_PROMISCUOUS	|Triggered when a device enables or disables promiscuous mode.
        |ANOM_RBAC_FAIL	|Triggered when a Role-Based Access Control (RBAC) self-test failure is detected.
        |ANOM_RBAC_INTEGRITY_FAIL	|Triggered when a Role-Based Access Control (RBAC) file integrity test failure is detected.
        |ANOM_ROOT_TRANS	|Triggered when a user becomes root.
        |AVC	|Triggered to record an SELinux permission check.
        |AVC_PATH	|Triggered to record the dentry and vfsmount pair when an SELinux permission check occurs.
        |BPRM_FCAPS	|Triggered when a user executes a program with a file system capability.
        |CAPSET	|Triggered to record any changes in process-based capabilities.
        |CHGRP_ID	|Triggered when a user-space group ID is changed.
        |CHUSER_ID	|Triggered when a user-space user ID is changed.
        |CONFIG_CHANGE	|Triggered when the Audit system configuration is modified.
        |CRED_ACQ	|Triggered when a user acquires user-space credentials.
        |CRED_DISP	|Triggered when a user disposes of user-space credentials.
        |CRED_REFR	|Triggered when a user refreshes their user-space credentials.
        |CRYPTO_FAILURE_USER	|Triggered when a decrypt, encrypt, or randomize cryptographic operation fails.
        |CRYPTO_KEY_USER	|Triggered to record the cryptographic key identifier used for cryptographic purposes.
        |CRYPTO_LOGIN	|Triggered when a cryptographic officer login attempt is detected.
        |CRYPTO_LOGOUT	|Triggered when a crypto officer logout attempt is detected.
        |CRYPTO_PARAM_CHANGE_USER	|Triggered when a change in a cryptographic parameter is detected.
        |CRYPTO_REPLAY_USER	|Triggered when a replay attack is detected.
        |CRYPTO_SESSION	|Triggered to record parameters set during a TLS session establishment.
        |CRYPTO_TEST_USER	|Triggered to record cryptographic test results as required by the FIPS-140 standard.
        |CWD	|Triggered to record the current working directory.
        |DAC_CHECK	|Triggered to record DAC check results.
        |DAEMON_ABORT	|Triggered when a daemon is stopped due to an error.
        |DAEMON_ACCEPT	|Triggered when the auditd daemon accepts a remote connection.
        |DAEMON_CLOSE	|Triggered when the auditd daemon closes a remote connection.
        |DAEMON_CONFIG	|Triggered when a daemon configuration change is detected.
        |DAEMON_END	|Triggered when a daemon is successfully stopped.
        |DAEMON_RESUME	|Triggered when the auditd daemon resumes logging.
        |DAEMON_ROTATE	|Triggered when the auditd daemon rotates the Audit log files.
        |DAEMON_START	|Triggered when the auditd daemon is started.
        |DEL_GROUP	|Triggered when a user-space group is deleted
        |DEL_USER	|Triggered when a user-space user is deleted
        |DEV_ALLOC	|Triggered when a device is allocated.
        |DEV_DEALLOC	|Triggered when a device is deallocated.
        |EOE	|Triggered to record the end of a multi-record event.
        |EXECVE	|Triggered to record arguments of the execve(2) system call.
        |FD_PAIR	|Triggered to record the use of the pipe and socketpair system calls.
        |FS_RELABEL	|Triggered when a file system relabel operation is detected.
        |GRP_AUTH	|Triggered when a group password is used to authenticate against a user-space group.
        |INTEGRITY_DATA[b]	|Triggered to record a data integrity verification event run by the kernel.
        |INTEGRITY_HASH[b]	|Triggered to record a hash type integrity verification event  run by the kernel.
        |INTEGRITY_METADATA[b]	|Triggered to record a metadata integrity verification event run by the kernel.
        |INTEGRITY_PCR[b]	|Triggered to record Platform Configuration Register (PCR) invalidation messages.
        |INTEGRITY_RULE[b]	|Triggered to record a policy rule.
        |INTEGRITY_STATUS[b]	|Triggered to record the status of integrity verification.
        |IPC	|Triggered to record information about a Inter-Process Communication object referenced by a system call.
        |IPC_SET_PERM	|Triggered to record information about new values set by an IPC_SET control operation on an IPC object.
        |KERNEL	|Triggered to record the initialization of the Audit system.
        |KERNEL_OTHER	|Triggered to record information from third-party kernel modules.
        |LABEL_LEVEL_CHANGE	|Triggered when an object's level label is modified.
        |LABEL_OVERRIDE	|Triggered when an administrator overrides an object's level label.
        |LOGIN	|Triggered to record relevant login information when a user log in to access the system.
        |MAC_CIPSOV4_ADD	|Triggered when a Commercial Internet Protocol Security Option (CIPSO) user adds a new Domain of Interpretation (DOI). Adding DOIs is a part of the packet labeling capabilities of the kernel provided by NetLabel.
        |MAC_CIPSOV4_DEL	|Triggered when a CIPSO user deletes an existing DOI. Adding DOIs is a part of the packet labeling capabilities of the kernel provided by    NetLabel.
        |MAC_CONFIG_CHANGE	|Triggered when an SELinux Boolean value is changed.
        |MAC_IPSEC_EVENT	|Triggered to record information about an IPSec event, when one is detected, or when the IPSec configuration changes.
        |MAC_MAP_ADD	|Triggered when a new Linux Security Module (LSM) domain mapping is added. LSM domain mapping is a part of the packet labeling capabilities of the   kernel provided by NetLabel.
        |MAC_MAP_DEL	|Triggered when an existing LSM domain mapping is added. LSM domain mapping is a part of the packet labeling capabilities of the kernel      provided by NetLabel.
        |MAC_POLICY_LOAD	|Triggered when a SELinux policy file is loaded.
        |MAC_STATUS	|Triggered when the SELinux mode (enforcing, permissive, off) is changed.
        |MAC_UNLBL_ALLOW	|Triggered when unlabeled traffic is allowed when using the packet labeling capabilities of the kernel provided by NetLabel.
        |MAC_UNLBL_STCADD	|Triggered when a static label is added when using the packet labeling capabilities of the kernel provided by NetLabel.
        |MAC_UNLBL_STCDEL	|Triggered when a static label is deleted when using the packet labeling capabilities of the kernel provided by NetLabel.
        |MMAP	|Triggered to record a file descriptor and flags of the mmap(2) system call.
        |MQ_GETSETATTR	|Triggered to record the mq_getattr(3) and mq_setattr(3) message queue attributes.
        |MQ_NOTIFY	|Triggered to record arguments of the mq_notify(3) system call.
        |MQ_OPEN	|Triggered to record arguments of the mq_open(3) system call.
        |MQ_SENDRECV	|Triggered to record arguments of the mq_send(3) and mq_receive(3) system calls.
        |NETFILTER_CFG	|Triggered when Netfilter chain modifications are detected.
        |NETFILTER_PKT	|Triggered to record packets traversing Netfilter chains.
        |OBJ_PID	|Triggered to record information about a process to which a signal is sent.
        |PATH	|Triggered to record file name path information.
        |RESP_ACCT_LOCK[c]	|Triggered when a user account is locked.
        |RESP_ACCT_LOCK_TIMED[c]	|Triggered when a user account is locked for a specified period of time.
        |RESP_ACCT_REMOTE[c]	|Triggered when a user account is locked from a remote  session.
        |RESP_ACCT_UNLOCK_TIMED[c]	|Triggered when a user account is unlocked after a configured period of time.
        |RESP_ALERT[c]	|Triggered when an alert email is sent.
        |RESP_ANOMALY[c]	|Triggered when an anomaly was not acted upon.
        |RESP_EXEC[c]	|Triggered when an intrusion detection program responds to a threat originating from the execution of a program.
        |RESP_HALT[c]	|Triggered when the system is shut down.
        |RESP_KILL_PROC[c]	|Triggered when a process is terminated.
        |RESP_SEBOOL[c]	|Triggered when an SELinux Boolean value is set.
        |RESP_SINGLE[c]	|Triggered when the system is put into single-user mode.
        |RESP_TERM_ACCESS[c]	|Triggered when a session is terminated.
        |RESP_TERM_LOCK[c]	|Triggered when a terminal is locked.
        |ROLE_ASSIGN	|Triggered when an administrator assigns a user to an SELinux role.
        |ROLE_MODIFY	|Triggered when an administrator modifies an SELinux role.
        |ROLE_REMOVE	|Triggered when an administrator removes a user from an SELinux role.
        |SELINUX_ERR	|Triggered when an internal SELinux error is detected.
        |SERVICE_START	|Triggered when a service is started.
        |SERVICE_STOP	|Triggered when a service is stopped.
        |SOCKADDR	|Triggered to record a socket address.
        |SOCKETCALL	|Triggered to record arguments of the sys_socketcall system call (used to multiplex many socket-related system calls).
        |SYSCALL	|Triggered to record a system call to the kernel.
        |SYSTEM_BOOT	|Triggered when the system is booted up.
        |SYSTEM_RUNLEVEL	|Triggered when the system's run level is changed.
        |SYSTEM_SHUTDOWN	|Triggered when the system is shut down.
        |TEST	|Triggered to record the success value of a test message.
        |TRUSTED_APP	The record of this type can be used by third party application that require auditing.
        |TTY	|Triggered when TTY input was sent to an administrative process.
        |USER_ACCT	|Triggered when a user-space user account is modified.
        |USER_AUTH	|Triggered when a user-space authentication attempt is detected.
        |USER_AVC	|Triggered when a user-space AVC message is generated.
        |USER_CHAUTHTOK	|Triggered when a user account attribute is modified.
        |USER_CMD	|Triggered when a user-space shell command is executed.
        |USER_END	|Triggered when a user-space session is terminated.
        |USER_ERR	|Triggered when a user account state error is detected.
        |USER_LABELED_EXPORT	|Triggered when an object is exported with an SELinux label.
        |USER_LOGIN	|Triggered when a user logs in.
        |USER_LOGOUT	|Triggered when a user logs out.
        |USER_MAC_POLICY_LOAD	|Triggered when a user-space daemon loads an SELinux  policy.
        |USER_MGMT	|Triggered to record user-space management data.
        |USER_ROLE_CHANGE	|Triggered when a user's SELinux role is changed.
        |USER_SELINUX_ERR	|Triggered when a user-space SELinux error is detected.
        |USER_START	|Triggered when a user-space session is started.
        |USER_TTY	|Triggered when an explanatory message about TTY input to an administrative process is sent from user-space.
        |USER_UNLABELED_EXPORT	|Triggered when an object is exported without SELinux  label.
        |USYS_CONFIG	|Triggered when a user-space system configuration change is detected.
        |VIRT_CONTROL	|Triggered when a virtual machine is started, paused, or stopped.
        |VIRT_MACHINE_ID	|Triggered to record the binding of a label to a virtual machine.
        |VIRT_RESOURCE	|Triggered to record resource assignment of a virtual machine.
    - The **key_name** is an optional string that helps you identify which rule or a set of rules generated a particular log entry.

---

Scenario:
1. audit all command list

    ```
    -a exit,always -F arch=b64,audit.kernel.action=executed  -S execve 
    -a exit,always -F arch=b32,audit.kernel.action=executed  -S execve
    ```

2. use auditbeat to achieve the same function
    
    2.1 install auditbeat
    ```shell
    curl -L -O https://artifacts.elastic.co/downloads/beats/auditbeat/auditbeat-6.0.1-amd64.deb
    dpkg -i auditbeat-6.0.1-amd64.deb
    ```
    2.2 configure auditbeat in /etc/auditbeat/auditbeat.yml,example is [auditbeat.yml](./auditbeat.yml)
    
    2.3 be aware to stop auditd when use auditbeat to gather the audit info



