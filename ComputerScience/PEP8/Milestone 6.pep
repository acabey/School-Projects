; Program entry point
main:	call	reset	
	call	getraw 
	br	main

;__________________________________________________________________________________________________________________________________
; Gets user input, validates and stores into input stack
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
validate:	cpa	'0',i
	breq	retvalid
	cpa	'1',i
	breq	retvalid
	cpa	'2',i
	breq	retvalid
	cpa	'3',i
	breq	retvalid
	cpa	'4',i
	breq	retvalid
	cpa	'5',i
	breq	retvalid
	cpa	'6',i
	breq	retvalid
	cpa	'7',i
	breq	retvalid
	cpa	'8',i
	breq	retvalid
	cpa	'9',i
	breq	retvalid
	
	cpa	'*',i
	breq	retvalid
	cpa	'+',i
	breq	retvalid
	cpa	'-',i
	breq	retvalid
	cpa	'/',i
	breq	retvalid
	lda	0,i
	sta	isvalid,d
	ret0
retvalid:	lda	1,i
	sta	isvalid,d
	ret0

;__________________________________________________________________________________________________________________________________
; Interprets the stack data, 'casts' to decimal values and calls operations
rawintrp:	cpx	inpstack,i 
	brle	empty
	ldx	inpstack,i	;start from the stop
intrplop:	lda	0,x
	cpa	2560,i
	breq	complete
	sta	inpcache,d	;temporary variable for ease of use

	lda	fininp1,d
	cpa	0,i
	breq	stinp1

	lda	finchin,d	;heh 
	breq	stchar

	lda	fininp2,d
	breq	stinp2

	br	complete	;TODO ?


stinp1:	lda	inpcache,d
	call	checksn	; Handle a sign as an input
	lda	issign,d
	brgt	intrpnxt
	
	lda	inpcache,d	; Handle a number as an input	
	call	checkdec
	brlt	invalid
	sta	decinp1,d
	
	lda	inpsign,d 
	brgt	endinp1	; Implement the starting sign into the stored value
	lda	decinp1,d
	nega
	sta	decinp1,d

endinp1:	lda	1,i
	sta	fininp1,d
	sta	inpsign,d	; Resets sign coefficient for stinp2
	br	intrpnxt

stchar:	lda	inpcache,d
	call	checkch
	brlt	invalid
	sta	charin,d
	lda	1,i
	sta	finchin,d
	br	intrpnxt

stinp2:	lda	inpcache,d
	call	checksn	; Handle a sign as an input
	lda	issign,d
	brgt	intrpnxt
	
	lda	inpcache,d	; Handle a number as an input	
	call	checkdec
	brlt	invalid
	sta	decinp2,d
	
	lda	inpsign,d
	brgt	endinp2	; Implement the starting sign into the stored value
	lda	decinp2,d
	nega
	sta	decinp2,d

endinp2:	lda	1,i
	sta	fininp2,d
	br	intrpnxt


intrpnxt:	lda	0,i
	sta	issign,d	;resets sign variable
	addx	2,i
	br	intrplop

empty:	ret0
complete:	call	interp
	ret0

;__________________________________________________________________________________________________________________________________
; Checks if input1 is a number 
checkdec: 	cpa 	'0',i
	breq 	is0 
	cpa 	'1',i
	breq 	is1
	cpa 	'2',i
	breq 	is2
	cpa 	'3',i
	breq 	is3
	cpa 	'4',i
	breq 	is4
	cpa 	'5',i
	breq 	is5
	cpa 	'6',i
	breq 	is6
	cpa 	'7',i
	breq 	is7
	cpa 	'8',i
	breq 	is8
	cpa 	'9',i
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
checkch:	cpa	'*',i
	breq	ischar
	cpa	'+',i
	breq	ischar
	cpa	'-',i
	breq	ischar
	cpa	'/',i
	breq	ischar
	lda	-1,i
	ret0
ischar:	ret0

;__________________________________________________________________________________________________________________________________
; Checks if input is a sign character
checksn:	cpa	'-',i
	breq	isnegsn
	cpa	'+',i
	breq	ispossn
	ret0
isnegsn:	lda	inpsign,d
	nega
	sta	inpsign,d		; This is supposed to happen swag money $$$
ispossn:	lda	1,i
	sta	issign,d
	ret0
;__________________________________________________________________________________________________________________________________
;Interprets input (deprecated)
interp:	lda	charin,d
	cpa	'+',i		; compare to +
	breq	add
	cpa	'-',i		; compare to -
	breq	sub
	cpa	'*',i		; compare to *
	breq	multi
	cpa	'/',i		; compare to /
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
	ret0

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
	ret0

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

; Resets values to defaults
reset:	lda	0,i	; resets values
	sta	sum,d
	sta	rawinput,d
	sta	decinp1,d
	sta	decinp2,d
	sta	fininp1,d
	sta	fininp2,d
	sta	finchin,d
	sta	issign,d

	lda	1,i
	sta	isneg,d
	sta	isvalid,d
	sta	inpsign,d
	ret0

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
finchin:	.word	0

isneg:	.word	1	;Sign coefficient
isvalid:	.word	1	;Valid input boolean

issign:	.word	0	;Sign boolean (for milestone 6 input interpretation)
inpsign:	.word	1	;Input sign coeffecient

charin:	.ASCII	"\x00"	;Operation character input
	.byte	0	;0 byte for safety
dby0msg: 	.ASCII 	"Error: cannot divide by zero\n\x00"
invmsg:	.ASCII	"Error: invalid expression\n\x00"
ovrflwm:	.ASCII	"Error: overflow\n\x00"
inpcache:	.word	0
inpstack:	.block	256	;Large memory allocation for input
.end