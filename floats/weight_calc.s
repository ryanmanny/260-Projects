#PA3 for CptS 260, HW8
#Ryan Manny

.data

string_foot:	.asciiz "Enter your height in feet     : "
string_inch:	.asciiz "Enter your height in inches   : "
string_meter:	.asciiz	"Your height in meters is      : "
string_centi:	.asciiz	"\nYour height in centimeters is : "

feet_to_meter:	.float	0.3048
inch_to_meter:	.float	0.0254
meter_to_centi:	.float	100.0

.text

main:

#$s0 stores feet, $s1 stores inches

li	$v0, 4
la	$a0, string_foot
syscall					#print "Type height feet"

li	$v0, 5
syscall
move	$s0, $v0			#stores feet in $s0
mtc1	$s0, $f0			#move to float register
cvt.s.w $f0, $f0			#convert to float for later multiplication

li	$v0, 4
la	$a0, string_inch
syscall					#print "Type inch feet"

li	$v0, 5
syscall
move	$s1, $v0			#stores inch in $s1
mtc1	$s1, $f1			#move to float register
cvt.s.w $f1, $f1			#convert to float for later multiplication

l.s	$f2, feet_to_meter
l.s	$f3, inch_to_meter

mul.s	$f0, $f0, $f2			#converts feet to meters
mul.s	$f1, $f1, $f3			#converts inches to meters

add.s	$f4, $f0, $f1			#f4 now stores the height in meters

l.s	$f5, meter_to_centi
mul.s	$f6, $f4, $f5

#printing time

li	$v0, 4
la	$a0, string_meter
syscall					#print "Your height in meters"

li	$v0, 2
mov.s	$f12, $f4
syscall

li	$v0, 4
la	$a0, string_centi
syscall					#print "Your height in centimeters"

li	$v0, 2
mov.s	$f12, $f6
syscall

li	$v0, 10				#quit
syscall
