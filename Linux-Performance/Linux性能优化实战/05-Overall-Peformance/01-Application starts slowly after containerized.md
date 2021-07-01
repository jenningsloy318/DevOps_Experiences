Application starts slowly after containerized
---
Proceedure:
1. lower version java don't realize itself inside a container, so need to add a prameter to `JAVA_OPTS`
  - java 8(Java 8u131 up) and 9
    - memory limits,add `-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap`  default is `false` ;  or explictly set `-Xmx512m -Xms512m` to set its maximum heap memory
    - cpu limits, set `-XX:ParallelGCThreads` or  `-XX:CICompilerCount`; or leave them not set and  this version can respect the  docker cpu settings
  - java 10 
    - cpu limit: set `XX:ActiveProcessorCount`, default is `false`
    - memory limit same with java 9 
  - java 11
    - both limits can  use `XX:+UseContainerSupport`, default is `true`
    - also  `XX:ActiveProcessorCount` is also available, but default is `false`

2. check cpu usage with `top` `pidstat`