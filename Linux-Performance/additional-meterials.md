1. wireshark的使用推荐阅读林沛满的《Wireshark网络分析就这么简单》和《Wireshark网络分析的艺术》
2. 五种利用strace查故障的简单方法 https://www.cnblogs.com/youxin/p/8837771.html
    - 找出程序在startup的时候读取的哪个config文件
      ```
      strace -e open php 2>&1 | grep php.ini  
      open("/usr/local/bin/php.ini", O_RDONLY) = -1 ENOENT (No such file or directory)  
      open("/usr/local/lib/php.ini", O_RDONLY) = 4  
      ```
      > -e expr -- a qualifying expression: option=[!]all or option=[!]val1[,val2]...
      > options: trace, abbrev, verbose, raw, signal, read, write
    -  为什么这个程序没有打开我的文件
        是否曾经碰到过一个程序拒绝读取它没有权限的文件，但是你发誓原因是它没有真正找到那个文件？对程序跟踪open,access调用，注意失败的情况
        ```
        strace -e open,access 2>&1 | grep your-filename  
        ```
    - 某个进程现在在做什么
      ```
      strace -p 15427  
      ```

    - 是谁偷走了时间
      ```
      strace -c -p 11084  
      ```
      > -c -- count time, calls, and errors for each syscall and report summary
      > -C -- like -c but also print regular output

    - 为什么 无法连接到服务器
      调试进程无法连接到远端服务器有时候是件非常头痛的事。DNS会失败，connect会挂起，server有可能返回一些意料之外的数据。可以使用tcpdump来分析这些情况，它是一个非常棒的工作。但是有时候你strace可以给你更简单，耿直借的角度，因为strace只返回你的进程相关的系统调用产生的数据。如果你要从100个连接到统一个数据服务器的运行进程里面找出一个连接所做的事情，用strace就比tcpdump简单得多。

      下面是跟踪"nc"连接到www.news.com 80端口的例子
      ```
      strace -e poll,select,connect,recvfrom,sendto nc www.news.com 80  

      ```
  
    - strace -e expresssions
      - format expr is：  [qualifier=][!]value1[,value2]
         qualifier is one of  trace,  abbrev, verbose, raw, signal, read, write, fault, or inject
         value is a qualifier-dependent symbol or number
      -  trace
          - -e trace=open,close,rean,write
          - -e trace=process 
          - -e trace=network 
          - -e strace=signal 
          - -e trace=ipc 
      - abbrev
          - -e abbrev=, Abbreviate the output from printing each member of large structures.  The default is abbrev=all.  The -v option has the effect of abbrev=none.
      - raw 
          - -e raw=  Print raw, undecoded arguments for the specified set of system calls.  This option has the effect of causing all arguments to be printed in hexadecimal.  
      - singal
          - -e signal= Trace only the specified subset of signals.  The default is signal=all.
      - read
        - -e read=set
              Perform  a  full  hexadecimal  and ASCII dump of all the data read from file descriptors listed in the specified set.
        - -e read=3,5  to see all input activity on file descriptors 3 and 5
      - write 
        - -e write=set
        - -e write=3,5 to see all output activity on file descriptors 3 and  5
      - -T  Show the time spent in system calls




