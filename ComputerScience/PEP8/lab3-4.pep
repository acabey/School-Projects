; Copyright 2015 by ACabey - all rights reserved	
; Based on the Super Simple Computer GCD example by Mark Meyer

entry:	br        welcome
load:	deci    num1,d      ; read and store first number
	brv     ovrflw     ; check for overflow 
	deci   num2,d
	brv    ovrflw  ; now has both values in memory
	
top:	lda    num1,d
	suba num2,d
	breq fin; check if 0
	brlt  else ; if num2>num1, go to else
	sta   num1,d ; replace num1
	br   top
	
else:	lda   num2,d
	suba num1,d
	sta   num2,d ; replace num2
	br     top

fin:	deco num2,d  ; print num2
	br reset

reset:	lda 0,i
	sta num1,d
	sta num2,d
	br entry	

ovrflw:        STRO overflwm,d
	br entry        	 

welcome:	STRO welcomem,d 
	br load

num1:	.word  0x0000
num2:	.word   0x0000
welcomem:	.ASCII "\nEnter two numbers, this will output the GCF\n" 
buffer:	.word 0x0000
overflwm:   .ASCII "\nValue has exceeded maximum range, program will now restart\n"
	br entry

end:     	stop                ; stop the computer
.end                           ; indicate end of program to assembler