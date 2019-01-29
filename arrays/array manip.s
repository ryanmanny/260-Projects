#PA2 for CptS 260
#Ryan Manny

.data #initializes some data

array:		.word 11, 12, -10, 13, 9, 12, 14, 15, -20, 0 #declares ye array
size:		.word 40 #number of bytes in array
string_max:	.asciiz "The maximum is "
string_sum:	.asciiz "The summation is "
string_change:	.asciiz "Changing max...\n"
newline:	.asciiz	"\n"

.text 
#actual instructions
#does not require any user input

main:	j MAX
return:	j SUM
MAX:	#VARIABLE DECLARATIONS
	#SIZE S0
	la	$t0, size
	lw	$s0, 0($t0)		#stores array size in $s0

	#ARRAY ADDRESS S1, MAX S3
	la	$s1, array
	lw	$s3, 0($s1)		#start by assuming max is a[0]

	#ARRAY ITERATOR S2
	add	$s2, $zero, $zero	#array iterator

MLOOP:	#LOAD NEXT NUMBER
	addi	$s2, $s2, 4		#increments iterator by one position
	beq	$s0, $s2, PRINTM	#if reaches array end, stop
	add	$t0, $s1, $s2
	lw	$s4, 0($t0)		#loads next number

	li	$v0, 1			#for printing an integer
	move	$a0, $s4		#copies max into $a0 for printing
	syscall

	li	$v0, 4
	la	$a0, newline        
	syscall         		#print newline

	#CHECK MAX
	blt	$s4, $s3, MLOOP		#branch cur < max

	li	$v0, 4
	la	$a0, string_change        
	syscall         		#print "changing max"

	move	$s3, $s4

	j	MLOOP

SUM:	#VARIABLE DECLARATIONS
	#SIZE S0
	la	$t0, size
	lw	$s0, 0($t0)		#stores array size in $s0

	#ARRAY ADDRESS S1, SUM S3
	la	$s1, array
	lw	$s3, 0($s1)		#sum starts at the first number I guess

	#ARRAY ITERATOR S2
	add	$s2, $zero, $zero	#array iterator

SLOOP:	#LOAD NEXT NUMBER
	addi	$s2, $s2, 4		#increments iterator by one position
	beq	$s0, $s2, PRINTS	#if reaches array end, stop
	add	$t0, $s1, $s2
	lw	$s4, 0($t0)		#loads next number

	li	$v0, 1			#for printing an integer
	move	$a0, $s4		#copies sum into $a0 for printing
	syscall

	li	$v0, 4
	la	$a0, newline        
	syscall         		#print newline
	
	add	$s3, $s3, $s4

	j	SLOOP

PRINTM:	li	$v0, 4
	la	$a0, string_max        
	syscall         		#print string_max
	
	li	$v0, 1		#for printing an integer
	move	$a0, $s3	#copies max into $a0 for printing
	syscall

	li	$v0, 4
	la	$a0, newline        
	syscall         		#print newline

	j 	return		#there's a better way to do this stop yelling at me
PRINTS:	li	$v0, 4
	la	$a0, string_sum        
	syscall         		#print string_sum
	
	li	$v0, 1		#for printing an integer
	move	$a0, $s3	#copies sum into $a0 for printing
	syscall

	li	$v0, 10
        syscall			#this part is like return 0 in main (I think)
