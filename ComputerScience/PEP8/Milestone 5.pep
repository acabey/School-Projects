; Program entry point
main:	lda	0,i		; resets values
	sta	sum,d
	sta	rawinput,d
	sta	decinp1,d
	sta	decinp2,d
	sta	fininp1,d
	sta	fininp2,d
	lda	1,i
	sta	isneg,d
	sta	isvalid,d
	
	call	getraw 
	br	main

;__________________________________________________________________________________________________________________________________
; Gets user input and validates
getraw:	ldx	inpstack,i	;Initialize stack
rawtop:	chari	0,x
	ldbytea	0,x
	brv	invalid
	cpa	10,i
	breq	rawtop
inplop:	call	validate
	lda	isvalid,d
	breq	invinp	;Invalid input 
	ldbytea	0,x
	sta	0,x
	addx	2,i
	chari	0,x
	ldbytea	0,x
	brv	invalid	;Check for overflow
	cpa	10,i
	breq	endinp
	br	inplop

invinp:	call	invalid
	ret0
endinp:	call	rawintrp
	br	main

;__________________________________________________________________________________________________________________________________
; Verifies if input is a valid operation or number
validate:	cpa	48,i
	breq	retvalid
	cpa	49,i
	breq	retvalid
	cpa	50,i
	breq	retvalid
	cpa	51,i
	breq	retvalid
	cpa	52,i
	breq	retvalid
	cpa	53,i
	breq	retvalid
	cpa	54,i
	breq	retvalid
	cpa	55,i
	breq	retvalid
	cpa	56,i
	breq	retvalid
	cpa	57,i
	breq	retvalid
	
	cpa	42,i
	breq	retvalid
	cpa	43,i
	breq	retvalid
	cpa	45,i
	breq	retvalid
	cpa	47,i
	breq	retvalid
	lda	0,i
	sta	isvalid,d
	ret0
retvalid:	lda	1,i
	sta	isvalid,d
	ret0

;__________________________________________________________________________________________________________________________________
; Interprets the stack data, casts to decimal values and calls operations
rawintrp:	cpx	inpstack,i 
	brle	empty
	ldx	inpstack,i	;start from the stop
intrplop:	lda	0,x
	cpa	2560,i
	breq	complete
	sta	inpcache,d
	
	lda	fininp1,d
	brgt	stinp2
stinp1:	lda	inpcache,d
	call	checkdec
	brlt	intrpch
	sta	decinp1,d
	lda	1,i
	sta	fininp1,d
stinp2:	lda	inpcache,d
	call	checkdec
	brlt	intrpch
	sta	decinp2,d
	lda	1,i
	sta	fininp2,d

intrpch:	lda	inpcache,d
	call	checkch
	brlt	intrpnxt
	sta	charin,d

intrpnxt:	addx	2,i
	br	intrplop
empty:	ret0
complete:	call	interp
	ret0

;__________________________________________________________________________________________________________________________________
; Checks if input1 is a number 
checkdec: 	cpa 	48,i
	breq 	is0 
	cpa 	49,i
	breq 	is1
	cpa 	50,i
	breq 	is2
	cpa 	51,i
	breq 	is3
	cpa 	52,i
	breq 	is4
	cpa 	53,i
	breq 	is5
	cpa 	54,i
	breq 	is6
	cpa 	55,i
	breq 	is7
	cpa 	56,i
	breq 	is8
	cpa 	57,i
	breq 	is9
	lda 	-1,i
	ret0

is1: 	lda 	1,i
	ret0
is2: 	lda 	2,i
	ret0
is3: 	lda 	3,i
	ret0
is4: 	lda 	4,i
	ret0
is5: 	lda 	5,i
	ret0
is6: 	lda 	6,i
	ret0
is7: 	lda 	7,i
	ret0
is8: 	lda 	8,i
	ret0
is9: 	lda 	9,i
	ret0
is0: 	lda 	0,i
	ret0

;__________________________________________________________________________________________________________________________________
; Checks if input is a character
checkch:	cpa	42,i
	breq	ischar
	cpa	43,i
	breq	ischar
	cpa	45,i
	breq	ischar
	cpa	47,i
	breq	ischar
	lda	-1,i
	ret0
ischar:	ret0

;__________________________________________________________________________________________________________________________________
;Interprets input (deprecated)
interp:	lda	charin,d
	cpa	43,i		; compare to +
	breq	add
	cpa	45,i		; compare to -
	breq	sub
	cpa	42,i		; compare to *
	breq	multi
	cpa	47,i		; compare to /
	breq	divi
	call 	invalid 
	ret0
;__________________________________________________________________________________________________________________________________
; Does addition, returns output to sum and resets
add:	lda	decinp1,d
	adda	decinp2,d
	sta	sum,d
	call	print
	ret0
;__________________________________________________________________________________________________________________________________
; Does subtraction, returns output to sum and resets
sub:	lda	decinp1,d
	suba	decinp2,d
	sta	sum,d
	call	print
	ret0
;__________________________________________________________________________________________________________________________________
; Does multiplcation, returns output to sum and resets
multi:	call 	hnegs 	;Handle negatives
	call    	mult 	;Call multiplication
	call	print 	;Print product
	br	main

mult: 	lda 	sum,d	;do {sum += imp1; --inp2} while !(inp2==0)
	adda 	decinp1,d
	sta 	sum,d
	lda 	decinp2,d
	suba 	1,i
	breq 	endmp 
	sta 	decinp2,d
	br 	mult
endmp: 	ret0

;__________________________________________________________________________________________________________________________________
; Does division, returns output to sum and resets
divi: 	call	hnegs
	call 	div 	;Call division 
	call 	print 	;Print product
	br 	main

div:	lda 	decinp2,d
	breq 	divby0 	; * Assumes that the sum (output of subroutine) is preset to zero
	lda 	decinp1,d
	breq 	enddiv 
	brle 	divdec
	suba	decinp2,d
	sta 	decinp1,d
	call	divinc
	br 	div

divinc: 	lda 	sum,d
	adda 	1,i
	sta 	sum,d
	ret0

divdec: 	lda 	sum,d
	suba 	1,i
	sta 	sum,d
	br 	enddiv

enddiv: 	ret0

divby0: 	stro 	dby0msg,d 
	ret0

;__________________________________________________________________________________________________________________________________
;Global functions/ subs

; Handles negative inputs for operations
hnegs:	br	hneg1	;TODO improve This is super janky and there is a better way to do it, but whatevs
hneg1:	lda	decinp1,d
	brlt	invert1
hneg2:	lda	decinp2,d
	brlt	invert2
	ret0
invert1:	nega
	sta	decinp1,d
	lda	isneg,d
	nega
	sta	isneg,d
	br	hneg2
invert2:	nega
	sta	decinp2,d
	lda	isneg,d
	nega
	sta	isneg,d
	ret0

; Prints invalid input message
invalid:	stro	invmsg,d
	ret0

; Prints overflow message
ovrflw:	stro	ovrflwm,d
	br	main

; Verifies and prints the output using the 3 global variables
print:	lda	isneg,d 
	brlt	invsum
rawprint:	lda 	sum,d
	brv	ovrflw
	charo	'=',i
	deco	sum,d
	charo	'\n',i
	ret0
invsum:	lda	sum,d
	nega
	sta	sum,d
	br	rawprint

;__________________________________________________________________________________________________________________________________
;Variables
rawinput:	.word	0
	.byte	0	;0 byte for safety
decinp1:	.word	0 	;First decimal input
decinp2:	.word	0	
sum:	.word	0	;Output of operation

fininp1:	.word	0
fininp2:	.word	0
isneg:	.word	1	;Sign coefficient
isvalid:	.word	1	;Valid input boolean
charin:	.ASCII	"\x00"	;Operation character input
dby0msg: 	.ASCII 	"Error: cannot divide by zero\n\x00"
invmsg:	.ASCII	"Error: invalid expression\n\x00"
ovrflwm:	.ASCII	"Error: overflow\n\x00"
inpcache:	.word	0
inpstack:	.block	256	;Large memory allocation for input
.end