#PA1 for CptS 260
#Ryan Manny

.data #initializes some data

string_1:	.asciiz "Enter the first number "
string_2:	.asciiz "Enter the second number "
string_3:	.asciiz "Enter the operation type (Add - 0, Sub - 1, Mult - 2) "
string_4:	.asciiz "The result is "

.text #actual instructions

main:	li 	$v0, 4       	#when $v0 is, syscall prints string
        la 	$a0, string_1	#syscall prints whatever is in $a0
        syscall         	#"Enter the first number"

	#now we get input from user

	li	$v0, 5		#now syscall will get input
	syscall			#now $v0 stores the integer from user
	move 	$t0, $v0	#$t0 = scanned integer

	li	$v0, 4		
	la	$a0, string_2 
        syscall         	#"Enter the second number"

	li	$v0, 5		
	syscall
	move	$t1, $v0	#$t1 = scanned integer

INPUT:	li	$v0, 4
	la	$a0, string_3	
	syscall			#tells user to input operator

	li	$v0, 5
	syscall
	move	$t2, $v0	#$t2 = operator type

	#now we have everything we need to do some logic

	beq 	$t2, $zero, ADD	#user entered 0, add
	li	$t3, 1
	beq	$t2, $t3, SUB	#user entered 1, subtract
	li	$t3, 2
	beq	$t2, $t3, MULT	#user entered 2, multiply
	j	INPUT		#none were chose, try again

ADD:	add 	$t4, $t0, $t1
	j	PRINT
SUB:	sub	$t4, $t0, $t1
	j	PRINT
MULT:	mul	$t4, $t0, $t1
	j	PRINT

PRINT:	li	$v0, 4
	la	$a0, string_4        
	syscall         	#print string_4
	
	li	$v0, 1		#for printing an integer
	move	$a0, $t4	#copies result into $a0
	syscall

	li	$v0, 10
        syscall			#this part is like return 0 in main (I think)
