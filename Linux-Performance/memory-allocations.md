Memory Management
---


### Memory allocation for application
![application-memory-allocation](./images/application-memory-allocation-process.png)

1. The application begins with an allocation request for memory (e.g., libc malloc()).

2. The allocation library can either service the memory request from its own free lists, or it may need to expand virtual memory to accommodate. Depending on the allocation library, it will either:
    - a. Extend the size of the heap by calling a brk() syscall and using the heap memory for the allocation.
    - b. Create a new memory segment via the mmap() syscall.

3. Sometime later, the application tries to use the allocated memory range through store and load instructions, which involves calling in to the processor memory management unit (MMU) for virtual-to-physical address translation. At this point, the lie of virtual memory is revealed: There is no mapping for this address! This causes an MMU error called a page fault.

4. The page fault is handled by the kernel, which establishes a mapping from its physical memory free lists to virtual memory and then informs the MMU of this mapping for later lookups. The process is now consuming an extra page of physical memory. The amount of physical memory in use by the process is called its resident set size (RSS).

5. When there is too much memory demand on the system, the kernel page-out daemon (kswapd) may look for memory pages to free. It will free one of three types of memory (though only (c) is pictured in Figure 7-2, as it is showing a user memory page life cycle):
    - a. File system pages that were read from disk and not modified (termed "backed by disk"): These can be freed immediately and simply reread back when needed. These pages are application-executable text, data, and file system metadata.

    - b. File system pages that have been modified: These are “dirty” and must be written to disk before they can be freed.

    - c. Pages of application memory: These are called anonymous memory because they have no file origin. If swap devices are in use, these can be freed by first being stored on a swap device. This writing of pages to a swap device is termed swapping (on Linux).


### Memory allocation for kernel process
There are two  strategies for managing free memory that is assigned to kernel processes:
- Buddy system: Buddy allocation system is an algorithm in which a larger memory block is divided into small parts to satisfy the request. The two smaller parts of block are of equal size and called as buddies. In the same manner one of the two buddies will further divide into smaller parts until the request is fulfilled

    Four Types of Buddy System:
    - Binary buddy system
    - Fibonacci buddy system
    - Weighted buddy system
    - Tertiary buddy system

    Binary buddy system: The buddy system maintains a list of the free blocks of each size (called a free list), so that it is easy to find a block of the desired size; and each block are devided into two equal smaller blocks
    
    Fibonacci buddy system: This is the system in which blocks are divided into sizes which are fibonacci numbers. It satisfy the following relation:
    ```
    Zi = Z(i-1)+Z(i-2)
    ```
    drawback: The main drawback in buddy system is internal fragmentation as larger block of memory is acquired then required. For example if a 36 kb request is made then it can only be satisfied by 64 kb segment and reamining memory is wasted.


- Slab Allocation
    
    This method is used to retain allocated memory that contains a data object of a certain type for reuse upon subsequent allocations of objects of the same type.

    In slab allocation memory chunks suitable to fit data objects of certain type or size are preallocated

    Cache does not free the space immediately after use although it keeps track of data which are required frequently so that whenever request is made the data will reach very fast. Two terms required are:
    - Slab – A slab is made up of one or more physically contiguous pages. The slab is the actual container of data associated with objects of the specific kind of the containing cache.
    
    - Cache – Cache represents a small amount of very fast memory. A cache consists of one or more slabs. There is a single cache for each unique kernel data structure.

    ![kernel-slab-cache](./images/kernel-slab-cache.jpg)

    - Implementation

        slab allocation algorithm uses caches to store kernel objects. When a cache is created a number of objects which are initially marked as free are allocated to the cache. The number of objects in the cache depends on size of the associated slab.

        for examle: a 12 kb slab (made up of three contiguous 4 kb pages) could store six 2 kb objects. Initially all objects in the cache are marked as free. When a new object for a kernel data structure is needed, the allocator can assign any free object from the cache to satisfy the request. The object assigned from the cache is marked as used.

        The slab allocator first attempts to satisfy the request with a free object in a partial slab. If none exists, a free object is assigned from an empty slab. If no empty slabs are available, a new slab is allocated from contiguous physical pages and assigned to a cache.

