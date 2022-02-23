# https://answers.yahoo.com/question/index;_ylt=AwrC3CO0q0teRBcAYBkPxQt.;_ylu=X3oDMTBybGY3bmpvBGNvbG8DYmYxBHBvcwMyBHZ0aWQDBHNlYwNzcg--?qid=20121025130105AANn11B&guccounter=1&guce_referrer=aHR0cHM6Ly9zZWFyY2gueWFob28uY29tL3locy9zZWFyY2g_aHNwYXJ0PWF2YXN0JmhzaW1wPXlocy1zZWN1cmVicm93c2VyJnR5cGU9MzEzOCZwYXJhbTE9MzI5NTBkY2UzZjJkNDA0NmIyNzJhZjExYjQ5NTQ4ZGYmcGFyYW0yPTIwMTkwODE1JnBhcmFtMz1BdmFzdCUyMFNlY3VyZSUyMEJyb3dzZXJ8NzkuMC4zMDYwLjgwJnBhcmFtND0xN3xVU3wxLjE4LjE2LjU4OHwxLjE4LjE2LjU4OCZwPW1pcHMraG93K3RvK3ByaW50K2FuK2FycmF5&guce_referrer_sig=AQAAALnpZ7ub_jEzMzlVnz4WDAPq_HgdzSa5Ol6JRVm5Ei3GRKESiwFU6Ji9zLlcDTnlC4cqXJP9FKrZcUiSNExBx8p_L3aY3rxXjUFW2RZXQ0xueMXE7EPiBKFVqRB00aKwGdWLxCP4dVzi0f9LxsCqBW_xw_NQAzZBFYyfjtIU5Gjy
# printArray.asm
# © 2009 Ryan Beckett
# printArray creates a 5 integer array and prints 
# its contents to the console.

.data # variable declarations follow this line

# 20 bytes to hold an array of 5 integers (integers are 4 bytes)
array1: .space 20 

.text # instructions follow

main: # indicates start of code (first instruction to execute)

#lload integers in allocated space

la $t0, array1 #  load base address of array into register $t0
li $t1, 1 #  $t1 = 1  
sw $t1, ($t0) #  first array element set to 1; indirect addressing
li $t1, 2 #   $t1 = 2
sw $t1, 4($t0) #  second array element set to 2
li $t1, 3 #   $t1 = 3
sw $t1, 8($t0) #  third array element set to 3
li $t1, 4 #   $t1 = 4
sw $t1, 12($t0) #  third array element set to 4
li $t1, 5 #   $t1 = 5
sw $t1, 16($t0) #  third array element set to 5

#print all elements (may succeed with indirect addressing)

lw $t0, 0($t0)
li $v0, 1 # load system call (print integer) into syscall register
move $a0, $t0 # load argument for syscall
syscall # print element

# works up until this point, correctly prints out 1, but error afterwards??

lw $t1, 4($t0)
li $v0, 1 # load system call (print integer) into syscall register
move $a0, $t1 # load argument for syscall
syscall # print element

lw $t2, 8($t0)
li $v0, 1 # load system call (print integer) into syscall register
move $a0, $t2 # load argument for syscall
syscall # print element

lw $t3, 12($t0)
li $v0, 1 # load system call (print integer) into syscall register
move $a0, $t3 # load argument for syscall
syscall # print element

lw $t4, 16($t0)
li $v0, 1 # load system call (print integer) into syscall register
move $a0, $t4 # load argument for syscall
syscall # print element

#exit program

li $v0, 10
syscall