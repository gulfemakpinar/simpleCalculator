############################################
# Data Segment
# messages 
############################################  

	.data
input_msg:
	.asciiz	" Expression: \n "

input_msg1:
	.asciiz	"Enter the number and operators seperated with space and put = at the end of the expression. \n"


input_str:
	.space 48

############################################
# Text Segment
############################################  
############################################
# Main Routine 		   	
############################################  
	.text
main:
	
	la	$a0, input_msg1		# load input message into register
	jal	print_str		# prints the input
	
	la	$a0, input_msg		# load input message into register
	jal	print_str		# prints the input

	la	$a0, input_str		# load the space for the expression into register	
	addi 	$a1, $zero, 48  	# the length of the string is 48
	jal	read_str		# read the input
	add	$s0, $a0, $zero	
		
	
	jal toPrefix			# toPrefix method called
	addi $a0,$v0,0			# return value of the toPrefix added in argument 0
		
	jal evaluate			# evaluate method called
	lw $a0,0($v0)			# loads return value of evaluate in arg0
	jal print_int			# print_int method called
	
	

exit:
 addi $v0, $zero, 10 			# system code for exit
 syscall 				# exit main routine
############################################
 # if the input value is + or -, return 0, else if value is * or /, return 1, else return 2
 Precedence:
 # used registers in this method added to stack
 addi $sp, $sp, -4			
 sw $ra, 0($sp)				
 addi $sp, $sp, -4
 sw $t0, 0($sp)
 addi $sp, $sp, -4
 sw $t1, 0($sp)
 addi $sp, $sp, -4
 sw $t2, 0($sp)
 addi $sp, $sp, -4
 sw $t3, 0($sp)
 addi $t0, $0,43			#(+)
 addi $t1, $0,45			#(-)
 addi $t2, $0,42			#(*)
 addi $t3, $0,47			#(/)
 addi $v0, $0, 2
 bne $t0,$a0,lab1			#if $ao is equal to + return 0
 addi $v0, $0, 0
 lab1: 
 bne $t1,$a0,lab2			#if $ao is equal to - return 0
 addi $v0, $0, 0
 lab2:
 bne $t2,$a0,lab3			#if $ao is equal to * return 1
 addi $v0, $0, 1
 lab3:
 bne $t3,$a0,lab4			#if $ao is equal to / return 1
 addi $v0, $0, 1
 lab4:


# register values which added in stack, stored in corresponding registers
 lw $t3, 0($sp)
 addi $sp, $sp, 4
 lw $t2, 0($sp)
 addi $sp, $sp, 4
 lw $t1, 0($sp)
 addi $sp, $sp, 4
 lw $t0, 0($sp)
 addi $sp, $sp, 4
 lw $ra, 0($sp)
 addi $sp, $sp, 4
 
 #return to previous location of this method
 jr $ra
############################################
# if the input value is an operator, return 1, else return 0
isOperator:
# used registers in this method added to stack
 addi $sp, $sp, -4
 sw $ra, 0($sp)
 addi $sp, $sp, -4
 sw $t0, 0($sp)
 addi $sp, $sp, -4
 sw $t1, 0($sp)
 addi $sp, $sp, -4
 sw $t2, 0($sp)
 addi $sp, $sp, -4
 sw $t3, 0($sp)
 
 
 addi $t0, $0,43		#(+)
 addi $t1, $0,45		#(-)
 addi $t2, $0,42		#(*)
 addi $t3, $0,47		#(/)
 addi $v0, $0, 0
 bne $t0,$a0,label1		#if $ao is equal to + return 1
 addi $v0, $0, 1
 label1: 
 bne $t1,$a0,label2		#if $ao is equal to - return 1
 addi $v0, $0, 1
 label2:
  bne $t2,$a0,label3		#if $ao is equal to * return 1
 addi $v0, $0, 1
 label3:
  bne $t3,$a0,label4		#if $ao is equal to / return 1
 addi $v0, $0, 1
 label4:

# register values which added in stack, stored in corresponding registers
 lw $t3, 0($sp)
 addi $sp, $sp, 4
 lw $t2, 0($sp)
 addi $sp, $sp, 4
 lw $t1, 0($sp)
 addi $sp, $sp, 4
 lw $t0, 0($sp)
 addi $sp, $sp, 4
 lw $ra, 0($sp)
 addi $sp, $sp, 4
 
 #return to previous location of this method
 jr $ra
############################################
toPrefix: 
# used registers in this method added to stack
 addi $sp, $sp, -4
 sw $ra, 0($sp)
 addi $sp, $sp, -4
 sw $t0, 0($sp)
 addi $sp, $sp, -4
 sw $t1, 0($sp)
 addi $sp, $sp, -4
 sw $t2, 0($sp)
 addi $sp, $sp, -4
 sw $t3, 0($sp)
 addi $sp, $sp, -4
 sw $t4, 0($sp)
 addi $sp, $sp, -4
 sw $s0, 0($sp)
 addi $sp, $sp, -4
 sw $s1, 0($sp)
 addi $sp, $sp, -4
 sw $s2, 0($sp)
 addi $sp, $sp, -4
 sw $s3, 0($sp)
 addi $sp, $sp, -4
 sw $s4, 0($sp)
 addi $sp, $sp, -4
 sw $s5, 0($sp)

jal reverse		# callls reverse function to start right part of the expression
addi $a0,$v0,0

addi $s2, $sp, -48
addi $s5, $sp, -48 	# creating new stack, this stack holds the operators
addi $s3, $sp, -96	
addi $s4, $sp, -96	# creating new stack, this stack holds the integers
addi $t0, $0, 61	# (=)
addi $s4, $s4,-1	# adds = into the stack
sb $t0, 0($s4)		
addi $t1,$0,1 		# increment
add $t2,$a0,$zero 	#charAt
add $s1,$a0,$zero 	#topOfString

back: 

lb $s0, 0($t2) 		# getChar
addi $t0, $0, 61 	#(=)
beq $s0, $t0,EXIT 	#(not equal to =)
addi $a0,$s0,0 		#add char to argument
jal isOperator 		# call isOperator
beq $v0,$0, else 	#getReturn and compare


bne $s5, $s2,else2 	#if the satck is Empty, adds character
addi $s5, $s5,-1 	#decremnet address
sb $s0, 0($s5)		# store byte
j exit2
else2:

lb $a0, 0($s5)		#if stack is not empty, then controls the precendence of the characters one from stack and another one from expression
jal Precedence		
addi $t3, $v0,0

addi $a0, $s0, 0
jal Precedence
addi $t4, $v0,0

slt $t3, $t4, $t3	#it compares characters' precedences

beq $t3, $0, else3	#if the expression's  precedence less than the expression in the stack, then adds this into integer stack
lb $t3, 0($s5)		#store byte
addi $s5, $s5,1 	#increment address
addi $s4, $s4,-1 	#increment address
sb $t3, 0($s4)

addi $s5, $s5,-1 	#increment address
sb $s0, 0($s5)		#character from expression added into operator stack

j exit3
else3:
addi $s5, $s5,-1 	#decremnet address
sb $s0, 0($s5)		#store byte, character from expression added into operator stack

exit3:
exit2:
j exit4
else:

addi $s4, $s4,-1 	#increment address
sb $s0, 0($s4)		#value added to the integer stack


exit4:
add $t2, $t1, $t2 	#incrementAddress
j back
EXIT:

back2:
beq $s5, $s2, exit5	#if operator stack is not empty, then adds operator values in the operator stack into integer stack
lb $t3, 0($s5)		#store byte
addi $s5, $s5,1 	#incremnet address
addi $s4, $s4,-1 	#incremnet address
sb $t3, 0($s4)
j back2
exit5:

addi $v0, $s4,0		#returns the address of the integer stack

# register values which added in stack, stored in corresponding registers
 lw $s5, 0($sp)
 addi $sp, $sp, 4
 lw $s4, 0($sp)
 addi $sp, $sp, 4
 lw $s3, 0($sp)
 addi $sp, $sp, 4
 lw $s2, 0($sp)
 addi $sp, $sp, 4
 lw $s1, 0($sp)
 addi $sp, $sp, 4
 lw $s0, 0($sp)
 addi $sp, $sp, 4
 lw $t4, 0($sp)
 addi $sp, $sp, 4
 lw $t3, 0($sp)
 addi $sp, $sp, 4
 lw $t2, 0($sp)
 addi $sp, $sp, 4
 lw $t1, 0($sp)
 addi $sp, $sp, 4
 lw $t0, 0($sp)
 addi $sp, $sp, 4
 lw $ra, 0($sp)
 addi $sp, $sp, 4

#return to previous location of this method
jr $ra
############################################
evaluate:
# used registers in this method added to stack
 addi $sp, $sp, -4
 sw $ra, 0($sp)
 addi $sp, $sp, -4
 sw $t0, 0($sp)
 addi $sp, $sp, -4
 sw $t1, 0($sp)
 addi $sp, $sp, -4
 sw $t2, 0($sp)
 addi $sp, $sp, -4
 sw $t3, 0($sp)
 addi $sp, $sp, -4
 sw $t4, 0($sp)
 addi $sp, $sp, -4
 sw $t5, 0($sp)
 addi $sp, $sp, -4
 sw $t6, 0($sp)
 addi $sp, $sp, -4
 sw $t7, 0($sp)
 addi $sp, $sp, -4
 sw $s0, 0($sp)
 addi $sp, $sp, -4
 sw $s2, 0($sp)
 addi $sp, $sp, -4
 sw $s5, 0($sp)

jal reverse		# callls reverse function to start right part of the expression
addi $a0,$v0,0

addi $t2, $a0,0
addi $s2, $sp, -336	# creating new stack, this stack holds the integers
addi $s5, $sp, -336	# creating new stack, this stack holds the integers
addi $t1,$0,1 		#increment

back3: 

lb $s0, 0($t2) 		#getChar
addi $t0, $0, 61 	#(=)
beq $s0, $t0,EXIT2 	#(not equal to =)
addi $t0, $0, 32 	#(space)
beq $s0, $t0, ex	#if expression is not space do the following codes
addi $a0,$s0,0 		#add char to argument
jal isOperator 		#call isOperator
beq $v0,$0, else5	#if it is an operator, pop 2 integers from integer stack and find the operation and perform it

lw $t3, 0($s5)
addi $s5, $s5, 4
lw $t4, 0($s5)
addi $s5, $s5, 4
 
 
addi $t5, $0, 43	#(+)
bne $s0, $t5, LB1
add $t3, $t3, $t4
LB1:

addi $t5, $0, 45	#(-)
bne $s0, $t5, LB2
sub $t3, $t3, $t4
LB2:

addi $t5, $0, 42	#(*)
bne $s0, $t5, LB3
mul $t3, $t3, $t4
LB3:

addi $t5, $0, 47	#(/)
bne $s0, $t5, LB4
div $t3, $t3, $t4
LB4:
 
 addi $s5, $s5, -4
 sw $t3, 0($s5)		#the result of the operation puhed to the integer stack
 

j exit9
else5:
#if the caharacter is integer and the character after that integer is space then, call toInteger method and change it in integer, else do nothing
addi $t0, $0, 32 	#(space)
addi $t7, $t2,1
lb $t6, 0($t7)
bne $t6,$t0,LL

addi $a0,$t2,0
jal toInteger
addi $s5, $s5, -4
sw $v0, 0($s5)


LL:
exit9:


ex:
add $t2, $t1, $t2 #incrementAddress
j back3
EXIT2:
#return the integer
addi $v0,$s5,0
# register values which added in stack, stored in corresponding registers
lw $s5, 0($sp)
 addi $sp, $sp, 4
lw $s2, 0($sp)
 addi $sp, $sp, 4
lw $s0, 0($sp)
 addi $sp, $sp, 4
 lw $t7, 0($sp)
 addi $sp, $sp, 4
 lw $t6, 0($sp)
 addi $sp, $sp, 4
 lw $t5, 0($sp)
 addi $sp, $sp, 4
 lw $t4, 0($sp)
 addi $sp, $sp, 4
 lw $t3, 0($sp)
 addi $sp, $sp, 4
 lw $t2, 0($sp)
 addi $sp, $sp, 4
 lw $t1, 0($sp)
 addi $sp, $sp, 4
 lw $t0, 0($sp)
 addi $sp, $sp, 4
 lw $ra, 0($sp)
 addi $sp, $sp, 4

#return to previous location of this method
jr $ra
############################################
toInteger:
# used registers in this method added to stack
 addi $sp, $sp, -4
 sw $ra, 0($sp)
 addi $sp, $sp, -4
 sw $s0, 0($sp)
 addi $sp, $sp, -4
 sw $s1, 0($sp)
 addi $sp, $sp, -4
 sw $t0, 0($sp)
 addi $sp, $sp, -4
 sw $t1, 0($sp)
 addi $sp, $sp, -4
 sw $t2, 0($sp)
 addi $sp, $sp, -4
 sw $t3, 0($sp)
 addi $sp, $sp, -4
 sw $t4, 0($sp)

addi $s0,$a0,0		
addi $t0, $0,-1		#to iterate on string
addi $s1, $0, 0
addi $t3,$0,10		
Back:

lb $t1, 0($s0) 		#getting character from input string
addi $t4, $0,32		#space

beq  $t1,$t4,Exit	#iterate the input string while character is not equal to space
mul $s1, $s1,$t3	#multiplies the interger by 10 to increment digit of the integer

#compares the ASCII  table values of the numbers(0-9) and adds to the integer.
addi $t2, $0, 48	
bne $t1, $t2, LBL1
addi $s1, $s1, 0
LBL1:

addi $t2, $0, 49
bne $t1, $t2, LBL2
addi $s1, $s1, 1
LBL2:

addi $t2, $0, 50
bne $t1, $t2, LBL3
addi $s1, $s1, 2
LBL3:

addi $t2, $0, 51
bne $t1, $t2, LBL4
addi $s1, $s1, 3
LBL4:

addi $t2, $0, 52
bne $t1, $t2, LBL5
addi $s1, $s1, 4
LBL5:

addi $t2, $0, 53
bne $t1, $t2, LBL6
addi $s1, $s1, 5
LBL6:

addi $t2, $0, 54
bne $t1, $t2, LBL7
addi $s1, $s1, 6
LBL7:

addi $t2, $0, 55
bne $t1, $t2, LBL8
addi $s1, $s1, 7
LBL8:

addi $t2, $0, 56
bne $t1, $t2, LBL9
addi $s1, $s1, 8
LBL9:

addi $t2, $0, 57
bne $t1, $t2, LBL10
addi $s1, $s1, 9
LBL10:

add $s0,$s0,$t0		#iterates on string
j Back
Exit:

addi $v0, $s1,0		#returns the integer value
# register values which added in stack, stored in corresponding registers
lw $t4, 0($sp)
addi $sp, $sp, 4
lw $t3, 0($sp)
addi $sp, $sp, 4
lw $t2, 0($sp)
addi $sp, $sp, 4
lw $t1, 0($sp)
addi $sp, $sp, 4
lw $t0, 0($sp)
addi $sp, $sp, 4
lw $s1, 0($sp)
addi $sp, $sp, 4
lw $s0, 0($sp)
addi $sp, $sp, 4
lw $ra, 0($sp)
addi $sp, $sp, 4
 
#return to previous location of this method
jr $ra
############################################
reverse:
# used registers in this method added to stack
 addi $sp, $sp, -4
 sw $ra, 0($sp)
 addi $sp, $sp, -4
 sw $s0, 0($sp)
 addi $sp, $sp, -4
 sw $s1, 0($sp)
 addi $sp, $sp, -4
 sw $t0, 0($sp)
 addi $sp, $sp, -4
 sw $t1, 0($sp)
 addi $sp, $sp, -4
 sw $t2, 0($sp)
 addi $sp, $sp, -4
 sw $t3, 0($sp)


addi $t3, $sp, -144	# creating new stack, this stack holds the reverse of the expression
addi $t0, $0, 61 	#(=)
addi $t3, $t3,-1	# adds = to the begining of the expression, to find the end of the for-loop
sb $t0, 0($t3)
addi $t1, $0, 32 	#(space)
addi $t3, $t3,-1	# adds space between expression and the =
sb $t1, 0($t3)

addi $t1,$0,1 		# increment
add $t2,$a0,$zero 	# gets cahracter from the expression
add $s1,$a0,$zero 	# topOfString
back1: 

lb $s0, 0($t2) 		# getChar
beq $s0, $t0,EXIT1 	# while character is not equal to =, adds to reverse stack
addi $t3, $t3,-1
sb $s0, 0($t3)

add $t2, $t1, $t2 	#incrementAddress
j back1
EXIT1:
addi $v0, $t3,0		#returns the top of the reverse stack
# register values which added in stack, stored in corresponding registers
 lw $t3, 0($sp)
 addi $sp, $sp, 4
 lw $t2, 0($sp)
 addi $sp, $sp, 4
 lw $t1, 0($sp)
 addi $sp, $sp, 4
 lw $t0, 0($sp)
 addi $sp, $sp, 4
 lw $s1, 0($sp)
 addi $sp, $sp, 4
 lw $s0, 0($sp)
 addi $sp, $sp, 4
 
 lw $ra, 0($sp)
 addi $sp, $sp, 4
 #return to previous location of this method
 jr $ra
############################################
toString:
# used registers in this method added to stack
 addi $sp, $sp, -4
 sw $ra, 0($sp)
 addi $sp, $sp, -4
 sw $s0, 0($sp)
 addi $sp, $sp, -4
 sw $s1, 0($sp)
 addi $sp, $sp, -4
 sw $t0, 0($sp)
 addi $sp, $sp, -4
 sw $t1, 0($sp)
 addi $sp, $sp, -4
 sw $t2, 0($sp)
 addi $sp, $sp, -4
 sw $t3, 0($sp)
 addi $sp, $sp, -4
 sw $t4, 0($sp)
 addi $sp, $sp, -4
 sw $t5, 0($sp)


addi $s0, $a0,0
addi $s1, $sp, -384	# creating new stack, this stack holds the string form of integer
addi $t3,$0,10
slti $t0, $s0,0		
beq $t0,$0,els		#if integer is less than 0, then adds - to t1 register
addi $t1,$0,45		#(-)
mul $s0, $s0, -1	#multiply with -1
j exx
els:
beq $s0,$0,els2		#if  integer is greater than 0, then adds + to t1 register
addi $t1,$0,43		#(+)
els2:
exx:

ba:

slt $t2, $0, $s0	
beq $t2, $0, exx1	#while integer is less than or equal to 0, perform for loop
rem $t4, $s0, $t3	#finds the (integer%10)

#compares the remainder and put corresponding ASCII value to the register
addi $t5, $0, 0
bne $t4, $t5, BL1
addi $t4, $0, 48
BL1:

addi $t5, $0, 1
bne $t4, $t5, BL2
addi $t4, $0, 49
BL2:

addi $t5, $0, 2
bne $t4, $t5, BL3
addi $t4, $0, 50
BL3:

addi $t5, $0, 3
bne $t4, $t5, BL4
addi $t4, $0, 51
BL4:

addi $t5, $0, 4
bne $t4, $t5, BL5
addi $t4, $0, 52
BL5:

addi $t5, $0, 5
bne $t4, $t5, BL6
addi $t4, $0, 53
BL6:

addi $t5, $0, 6
bne $t4, $t5, BL7
addi $t4, $0, 54
BL7:

addi $t5, $0, 7
bne $t4, $t5, BL8
addi $t4, $0, 55
BL8:

addi $t5, $0, 8
bne $t4, $t5, BL9
addi $t4, $0, 56
BL9:

addi $t5, $0, 9
bne $t4, $t5, BL10
addi $t4, $0, 57
BL10:

addi $s1,$s1,-1		#puts the ASCII value to the char stack
sb $t4,0($s1) 
div $s0, $s0,$t3	#divides with the 10

j ba
exx1:



addi $s1,$s1,-1
sb $t1,0($s1) 		#adds the sign 
addi $v0, $s1, 0	#returns the first point of the string

# register values which added in stack, stored in corresponding registers
 lw $t5, 0($sp)
 addi $sp, $sp, 4
 lw $t4, 0($sp)
 addi $sp, $sp, 4
 lw $t3, 0($sp)
 addi $sp, $sp, 4
 lw $t2, 0($sp)
 addi $sp, $sp, 4
 lw $t1, 0($sp)
 addi $sp, $sp, 4
 lw $t0, 0($sp)
 addi $sp, $sp, 4
 lw $s1, 0($sp)
 addi $sp, $sp, 4
 lw $s0, 0($sp)
 addi $sp, $sp, 4
 
 lw $ra, 0($sp)
 addi $sp, $sp, 4
 
 #return to previous location of this method
 jr $ra
############################################
# I/O Routines
############################################
print_str:					# $a0 has string to be printed
	addi	$v0, $zero, 4	# system code for print_str
	syscall					# print it
	jr 	$ra					# return
	
print_int:					# $a0 has number to be printed
	addi	$v0, $zero, 1	# system code for print_int
	syscall
	jr 	$ra

read_str:					# address of str in $a0, 
							# length is in $a1.
	addi	$v0, $zero, 8	# system code for read_str
	syscall
	jr 	$ra
	
	
