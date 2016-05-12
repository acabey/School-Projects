; Program entry point
main:	call	reset	; Resets global variables
	call	getraw 	; Gets raw character input and stores into stack
	call	stackval	; Validates each input in the stack as a posibility
	call	rawintrp	; Interperets the stack data and stores into variables
	call	interp	; Interperets variables and performs operations
	call	print	; Prints the sum
	br	main

;__________________________________________________________________________________________________________________________________
; Gets user input and stores into input stack
getraw:	ldx	inpstack,i	; Initialize stack
rawtop:	chari	0,x	; Store stream into stack
	ldbytea	0,x
	brv	ovrflw	; Checks for overflow
	cpa	10,i	
	breq	rawtop	; If input is empty, try again
inplop:	ldbytea	0,x	; Assure that the raw byte is stored properly
	sta	0,x
	addx	2,i	; Increment stack pointer
	chari	0,x	; Take next input and loop un reaching end
	ldbytea	0,x
	brv	ovrflw	; Check for overflow
	cpa	10,i
	breq	endinp
	br	inplop
endinp:	ret0

;__________________________________________________________________________________________________________________________________
; Validate each stack input
stackval:	cpx	inpstack,i 
	brle	empty
	ldx	inpstack,i	; Start from the stop
vallop:	lda	0,x
	cpa	2560,i	; Checks if loop has reached end of stack input
	breq	complete
	sta	inpcache,d	; Temporary variable for ease of use
; Validation
	lda	inpcache,d
	call	validate
	lda	isvalid,d
	cpa	0,i
	breq	invalid	;Invalid input
	addx	2,i
	br	vallop

;__________________________________________________________________________________________________________________________________
; Interprets the stack data, 'casts' to decimal values and calls operations
rawintrp:	cpx	inpstack,i 
	brle	empty
	ldx	inpstack,i	; Start from the stop
intrplop:	lda	0,x
	cpa	2560,i	; Check if loop has reached end of stack input
	breq	complete
	sta	inpcache,d

	lda	fininp1,d	; Checks if first input variable has been filled
	cpa	0,i
	breq	stinp1

	lda	finchin,d	; Checks if operation character variable has been filled
	breq	stchar

	lda	fininp2,d	; Checks if second input variable has been filled
	breq	stinp2

	br	complete

; Store input 1
stinp1:	lda	inpcache,d
	call	checkch	; Handle an operation as an input 
	cpa	0,i
	brgt	preop	; Do operation with sum before input. Will then use the character input and the second decimal	

	lda	0,i
	sta 	sum,d	; Reset sum
	lda	inpcache,d	; Handle a number as an input	
	call	checkdec
	brlt	invalid
	sta	decinp1,d
	call	inp1mdc 

endinp1:	lda	1,i
	sta	fininp1,d
	sta	inpsign,d	; Resets sign coefficient for stinp2
	br	intrpnxt

; Store operation character
stchar:	lda	inpcache,d
	call	checkch
	brlt	invalid
	sta	charin,d
	lda	1,i
	sta	finchin,d
	br	intrpnxt

; Store input 2
stinp2:	lda	inpcache,d
	call	checksn	; Handle a sign as an input
	lda	issign,d
	brgt	intrpnxt
	
	lda	inpcache,d	; Handle a number as an input	
	call	checkdec
	brlt	invalid
	sta	decinp2,d

	lda	decinp1,d	; Store decinp1 and charin in temporary locations while variables are used for calculation
	sta	dec1cac,d
	lda	charin,d
	sta	charcac,d
	call	inp2mdc

endinp2:	lda	1,i
	sta	fininp2,d
	lda	1,i
	sta	inpsign,d	; Resets sign coefficient
	br	intrpnxt

; Go to next value in stack
intrpnxt:	lda	0,i
	sta	issign,d	;resets sign variable
	addx	2,i
	br	intrplop

empty:	ret0
complete:	ret0

;__________________________________________________________________________________________________________________________________
;Performs preoperation using past sum (milestone 7) ; Will probably deprecate and instead put the operation into a queue
preop:	lda	inpcache,d
	sta	charin,d
	lda	sum,d
	sta	decinp1,d
	
	addx	2,i	; Skip to the first decimal input
	lda	0,x
	sta	inpcache,d	; Temporary variable for ease of use
	
	lda	inpcache,d	; Handle a number as an input	
	call	checkdec
	brlt	invalid
	sta	decinp2,d
	lda	0,i
	sta	sum,d	; Resets sum as 0
	lda	decinp1,d	; Store decinp1 and charin in temporary locations while variables are used for calculation
	sta	dec1cac,d
	lda	charin,d
	sta	charcac,d

	call	inp2mdc
	
	call	interp
	lda	sum,d
	brv	invalid	; Check for overflow
	sta	decinp1,d
	
	lda	0,i
	sta	decinp2,d	; In case there is no second input or operator, set to default add zero
	lda	'+',i
	sta	charin,d
	
	lda	1,i
	sta	fininp1,d	; Will skip over decinput1 
	ldx	inpstack,i
	addx	2,i	; Skips the operation character 
	addx	2,i	; Skips first decimal input *TODO for milestone number 9 this hardcoded value will have to change
	

	br	intrplop

;__________________________________________________________________________________________________________________________________
;Performs multidigit check and input for decinp1 (milestone 8)
inp1mdc:	addx	2,i	; Peek if next input is a number for multidigit inputs
	lda	0,x
	call	checkdec
	brlt	endmd1
	sta	inpcache,d
; Performs multidigit operations
	lda	10,i	; Multiply previous digit by placement value
	sta	decinp2,d
	call	multi
	
	lda	sum,d
	adda	inpcache,d	; Add the next digit and store
	brv	ovrflw	; Check for sum overflow
	sta	decinp1,d
	br	inp1mdc	; Return to top of loop

endmd1:	subx	2,i
	lda	'\x00',i	; Reset all changes for safety
	sta	charin,d
	sta	decinp2,d
	sta	sum,d
	sta	inpcache,d
	ret0

;__________________________________________________________________________________________________________________________________
;Performs multidigit check and input for decinp2 (milestone 8)
inp2mdc:	addx	2,i	; Peek if next input is a number for multidigit inputs
	lda	0,x
	call	checkdec
	brlt	endmd2
	sta	inpcache,d

; Performs multidigit operations
	lda	10,i	; Multiply previous digit by placement value
	sta	decinp1,d
	call	multi
	
	lda	sum,d
	adda	inpcache,d	; Add the next digit and store
	brv	ovrflw	; Check for sum overflow
	sta	decinp2,d
	br	inp2mdc	; Return to top of loop

endmd2:	subx	2,i
	lda	dec1cac,d	; Restore decinp1 and charin from temporary locations
	sta	decinp1,d
	lda	charcac,d
	sta	charin,d
	lda	'\x00',i	; Reset all changes for safety
	sta	sum,d
	sta	dec1cac,d
	sta	charcac,d
	sta	inpcache,d
	
	lda	inpsign,d
	brgt	fendm2	; Implement the starting sign into the stored value
	lda	decinp2,d
	nega
	sta	decinp2,d
fendm2:	ret0
;__________________________________________________________________________________________________________________________________
;Interprets input and performs operation
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
; Checks if input1 is a number and 'casts' to int
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
	sta	inpsign,d
ispossn:	lda	1,i
	sta	issign,d
	ret0

;__________________________________________________________________________________________________________________________________
; Does addition, returns output to sum and resets
add:	lda	decinp2,d
	cpa	'\x00',i
	breq	addid
doadd:	lda	decinp1,d
	adda	decinp2,d
	brv	ovrflw	; Check for sum overflow
	sta	sum,d
	ret0
addid:	lda	0,i	; in case there is no second decimal input, do additive identity
	sta	decinp2,d
	br	doadd 
;__________________________________________________________________________________________________________________________________
; Does subtraction, returns output to sum and resets
sub:	lda	decinp2,d
	cpa	'\x00',i
	breq	subid
dosub:	lda	decinp1,d
	suba	decinp2,d
	brv	ovrflw	; Check for sum overflow
	sta	sum,d
	ret0
subid:	lda	0,i	; in case there is no second decimal input, do additive identity 
	sta	decinp2,d
	br	dosub 
;__________________________________________________________________________________________________________________________________
; Does multiplcation, returns output to sum and resets
multi:	lda	0,i
	sta	sum,d	;Resets sum to zero 
	call 	hnegs 	;Handle negatives
	call    	mult 	;Call multiplication
	call	invsum 	;Print product
	ret0

mult: 	lda 	sum,d	;do {sum += imp1; --inp2} while !(inp2==0)
	adda 	decinp1,d
	brv	ovrflw	;Check for sum overflw
	sta 	sum,d
	lda 	decinp2,d
	suba 	1,i
	breq 	endmp 
	sta 	decinp2,d
	br 	mult
endmp: 	ret0

;__________________________________________________________________________________________________________________________________
; Does division, returns output to sum and resets
divi: 	lda	0,i
	sta	sum,d	;Resets sum to zero
	call	hnegs
	call 	div 	;Call division 
	call 	invsum 	;Print product
	ret0

div:	lda 	decinp2,d
	breq 	divby0 	; * Assumes that the sum (output of subroutine) is preset to zero
	lda 	decinp1,d
	breq 	enddiv 
	brle 	divdec
	suba	decinp2,d
	brv	ovrflw	; Check for sum overflow
	sta 	decinp1,d
	call	divinc
	br 	div

divinc: 	lda 	sum,d
	adda 	1,i
	brv	ovrflw	; Check for sum overflow
	sta 	sum,d
	ret0

divdec: 	lda 	sum,d
	suba 	1,i
	brv	ovrflw	; Check for sum overfow
	sta 	sum,d
	br 	enddiv

enddiv: 	ret0

divby0: 	stro 	dby0msg,d 
	ret0

;__________________________________________________________________________________________________________________________________
;Global functions/ subs

; Resets values to defaults
reset:	lda	0,i	; resets values
	sta	rawinput,d
	sta	decinp1,d
	sta	decinp2,d
	sta	fininp1,d
	sta	fininp2,d
	sta	finchin,d
	sta	issign,d
	sta	isop,d
	sta 	dec1cac,d
	sta	charcac,d

	lda	1,i
	sta	isneg,d
	sta	isvalid,d
	sta	inpsign,d
	
	cpx	inpstack,i 	; reset stack
	brle	empty
	ldx	inpstack,i	; Start from the stop
reslop:	lda	0,x
	cpa	'\x00',i	; Checks if loop has reached end of stack input
	breq	resct
; Reset value
	lda	'\x00',i
	sta	0,x
	addx 	2,i
	br	reslop
resct:	ret0

; Handles negative inputs for operations
hnegs:	br	hneg1	;Handle negatives using a flag variable
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

; Inverts the sum depending on the sign coefficient
invsum:	lda	isneg,d
	brgt	einvsum 
	lda	sum,d
	nega
	sta	sum,d
einvsum:	ret0

; Prints invalid input message
invalid:	stro	invmsg,d
	br	main
;	ret0	TODO TEST THIS

; Prints overflow message
ovrflw:	stro	ovrflwm,d
	br	main

; Verifies and prints the output using the 3 global variables
print:	lda 	sum,d
	brv	ovrflw
	charo	'=',i
	deco	sum,d
	charo	'\n',i
	ret0

;__________________________________________________________________________________________________________________________________
;Variables
rawinput:	.word	0
	.byte	0	;0 byte for safety
decinp1:	.word	0 	;First decimal input
decinp2:	.word	0	
sum:	.word	0	;Output of operation

fininp1:	.word	0	;Filled variable booleans
fininp2:	.word	0
finchin:	.word	0

dec1cac:	.word	0	; Temporary variables to hold the previously determined decinp1 and charin values while
charcac:	.word	0	;           decinp2 performs multidigit operations

isneg:	.word	1	;Sign coefficient
isvalid:	.word	1	;Valid input boolean

issign:	.word	0	;Sign boolean (for milestone 6 input interpretation)
inpsign:	.word	1	;Input sign coeffecient
isop:	.word	0	;Operation boolean (for milestone 7 input interpretation)

charin:	.ASCII	"\x00"	;Operation character input
	.byte	0	;0 byte for safety
dby0msg: 	.ASCII 	"Error: cannot divide by zero\n\x00"
invmsg:	.ASCII	"Error: invalid expression\n\x00"
ovrflwm:	.ASCII	"Error: overflow\n\x00"
inpcache:	.word	0
inpstack:	.block	64	;Large memory allocation for input
.end