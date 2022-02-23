.data
	# Makes an array by first finding the correct values using array A, int N, and int i
	# loop1 and power are used to calculate and store values into A[i]
	# power is a loop that is used to calculate 2^i, as there is no power function in MIP
	# loop2 that loads values from A[i], and prints the sum of each of its components
	A: .space 1000		# space for array A
	ask: .asciiz "Input value of N: " # ask for user prompt
	space: .asciiz " "	# add a space when printing
	
	info: .asciiz "\nvalue of i is: "
	info2: .asciiz "\nvalue at A[i] is: "
	
.text
	# ask for user input
	li $v0, 4 	 # load immediate in v0
	la $a0, ask 	 # load address at $a0, the value of prompt
	syscall 
	
	# set user's input
	li $v0, 5 	 # obtain integer from user
	syscall
	
	move $s0, $v0 	 # store value of N in $s0
	li $s1, 0 	 # set $s1 to 1; int i = 0
	li $t0, 1 
	sw $t0, A($zero) # set A[0] = 1
	
	li $s7, 2 	 # to be used to find 2^i
	#li $s6, 0 	 # to be used to find sum of array
	
	# A[i] = i * a + b
	# A is array, N = $s0, i = $s1, pointer to A is $s2
	loop1:
	addi $s1, $s1, 1 	# increment i, is 1 at start of looping
	
	mul $t1, $s1, 4 	# $t1 = value of i in array A
	sub $t2, $t1, 4 	# $t2 = value of i-1 in array A
	lw $t3, A($t2) 		# $t3 = A[i-1]
	mul $t4, $s1, $t3 	# $t4 = i * A[i-1]
	
	li $s5, 1
	li $t9, 1
	power:
	mul $t9, $t9, 2		# $t9 *= 2
	addi $s5, $s5, 1	# increment $s5
	ble $s5, $s1, power	# if $s5 < i, go to power
	
	# $t9 = 2^i
	add $t4, $t4, $t9	# $t4 = i * A[i-1] + 2^i
	sw $t4, A($t1) 		# saves $t4 into A[i]
	
	blt $s1, $s0, loop1	# if i < N, go back to loop1
	#--------------------
	li $s1, 0		# i = 0 again for the next loop
	li $s6, 0 		# to be used to find sum of array
	
	loop2:
	mul $t1, $s1, 4		# $t1 = value of i in array A
	lw $t2, A($t1)		# $t2 = A[i]
	add $s6, $s6, $t2	# $s6 += A[i]
	
	li $v0,1
	move $a0,$t2
	syscall
	
	li $v0,4
	la $a0,space		# prints a space
	syscall
	
	addi $s1, $s1, 1	# increment i
	blt $s1, $s0, loop2	# if i < N, go back to loop2
	#--------------------
	sw $t0, A($zero) # set A[0] = 1
	
	li $s1, 6	# set i = 4
	mul $t1, $s1, 4		# $t1 = value of i in array A
	lw $t2, A($t1)		# $t2 = A[i]
	
	li $v0, 4 	 # load immediate in v0
	la $a0, info 	 # print
	syscall
	
	li $v0, 1
	move $a0, $s1	# print i, which is 4
	syscall
	
	li $v0, 4 	 # load immediate in v0
	la $a0, info2 	 # print the value of A[i]
	syscall
	
	li $v0, 1
	move $a0, $t1	# print i, which is 4
	syscall