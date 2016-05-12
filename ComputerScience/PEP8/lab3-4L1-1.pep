
; Copyright 2015 by ACabey - all rights reserved 
; Based on the Super Simple Computer GCD example by Mark Meyer

entry: 	stro	welcomem,d
	deci 	num1,d 	; read and store first number
	brv 	ovrflw 	; check for overflow 
	breq	end
	brlt	change
inp2:	deci	num2,d
	brv 	ovrflw 	; now has both values in memory
	breq	end 
	brlt	change2

top: 	lda 	num1,d
	suba 	num2,d
	breq 	fin	; check if 0
	brlt 	else 	; if num2>num1, go to else
	sta 	num1,d 	; replace num1
	br 	top

else: 	lda 	num2,d
	suba 	num1,d
	sta 	num2,d 	; replace num2
	br 	top

fin: 	deco 	num2,d 	; print num2
	br 	entry

ovrflw: 	STRO 	overflwm,d	; display overflow error and restart
	br 	entry 

change:	lda	0,i	; convert to positive and return
	suba	num1,d 
	sta	num1,d
	br	inp2

change2:	lda	0,i
	suba	num2,d
	sta	num2,d
	br	top

num1: 	.word 	0x0000
num2: 	.word 	0x0000
welcomem: 	.ASCII 	"\nEnter two numbers, this will output the GCF\nEnter zero to stop\n\x00" 
overflwm: 	.ASCII 	"\nValue has exceeded maximum range, program will now restart\n \x00"
	br 	entry

end: 	stop 		; stop the computer

.end 			; indicate end of program to assembler
