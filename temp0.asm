.data
	prompt: .asciiz "Enter your age: "
	message: .asciiz "Your age is: "
.text
	# Prompt the user
	li $v0, 4 # load immediate in v0
	la $a0, prompt # load address at $a0, the value of prompt
	syscall 
	
	# Get user's input
	li $v0, 5 # obtain integer from user
	syscall
	
	# Store results in $t0
	move $t0, $v0 # store age value from $v0 into temporary register $t0
	
	# Display message
	li $v0, 4 
	la $a0, message # loading message onto argument $a0
	syscall
	
	# Print or show age
	li $v0, 1 # 1 in order to print an integer
	addi $t0, $t0, -1
	move $a0, $t0 
	syscall
	
