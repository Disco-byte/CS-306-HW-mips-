# Compute first twelve Fibonacci numbers and put in array, then print
.data
space:.asciiz " " # space to insert between numbers
head: .asciiz "The Fibonacci numbers are:\n"
prompt1: .asciiz "Enter the number between 1 to 45 : "
prompt2: .asciiz "Error, Number is out of range"
fibs: .word 0 : 50 # "array" of 50 words to contain fib values
.text
la $t0, fibs # load address of array
li $v0, 4
la $a0, prompt1
syscall

# Read string
li $v0, 5
syscall
move $t5,$v0 #move index value

bltz $t5,error
bgt $t5,45,error

jal fib
jal print # call print routine.
addiu $v0,$0,0x0000000a # system call for exit
syscall # we are out of here.
fib:

addiu $t2,$0,0x00000001 # 1 is first and second Fib. number
sw $t2, 0($t0) # F[0] = 1
sw $t2, 4($t0) # F[1] = F[0] = 1
addi $t1, $t5, -2 # Counter for loop, will execute (size-2) times
loop: lw $t3, 0($t0) # Get value from array F[n]
lw $t4, 4($t0) # Get value from array F[n+1]
add $t2, $t3, $t4 # $t2 = F[n] + F[n+1]
sw $t2, 8($t0) # Store F[n+2] = F[n] + F[n+1] in array
addi $t0, $t0, 4 # increment address of Fib. number source
addi $t1, $t1, -1 # decrement loop counter
bgtz $t1, loop # repeat if not finished yet.
jr $ra

print:
li $s0,1 #index
la $a0, fibs # first argument for print (array)
add $a1, $zero, $t5 # second argument for print (size)
add $t0, $zero, $a0 # starting address of array
add $t1, $zero, $a1 # initialize loop counter to array size
la $a0, head # load address of print heading
li $v0, 4 # specify Print String service
syscall # print heading
out:
li $v0,11
li $a0,'F'
syscall
li $v0,11
li $a0,'['
syscall

li $v0,1
move $a0,$s0
syscall

li $v0,11
li $a0,']'
syscall
li $v0,11
li $a0,'='
syscall
lw $a0, 0($t0) # load fibonacci number for syscall
li $v0, 1 # specify Print Integer service
syscall # print fibonacci number
la $a0, space # load address of spacer for syscall
li $v0, 4 # specify Print String service
syscall # output string
addi $t0, $t0, 4 # increment address


add $s0,$s0,1
addi $t1, $t1, -1 # decrement loop counter
li $v0,11
li $a0,'\n'
syscall
bgtz $t1, out # repeat if not finished
jr $ra # return


error:
li $v0, 4
la $a0, prompt2
syscall