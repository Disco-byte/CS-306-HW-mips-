
#Author: Daniel Menasce
#Date: 08.31.2015
.data

silly_str: .asciiz "Hello World, Fall 2015 is going to be fun."
.text
main:

li $v0, 4

la $a0, silly_str

syscall
# To exit off main

li $v0, 10

syscall