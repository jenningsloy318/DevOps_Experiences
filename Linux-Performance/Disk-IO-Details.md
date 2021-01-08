Disk I/O

- process of a IO request to finish


![disk-io](./images/disk-io-process.png)

- Request time is combine of `Wait Time` and `Service Time`
- Wait Time is combine of `OS scheduler queue` and `Disk Dispatch queue` 
- Service Time include following parts
    - time used in `Disk issue the request`
    - Then to search in the `On-Disk cache`
        - if hit, return the content, and this I/O request completed; the amount time here is seeking and returning the content ;
        - if not, add request to I/O queue, and return the result; so amount time inlude seeking cache, and request to the I/O queue and finally return the result