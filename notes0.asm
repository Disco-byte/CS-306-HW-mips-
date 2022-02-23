# increment address in MIPs
        .data

A:  .space  20  #declared 20 bytes of storage to hold array of 5 int

__start:
       lw          $t0, A   #load base address of array
       li          $t1, 0
loop:  sw          $t1($t0), $t1
       addi        $t1, $t1, 4
       ble         $t1, 20, loop
#continue code or simple exit after this