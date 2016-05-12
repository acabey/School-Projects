main:	lda	0,i		; resets values
	sta	sum,d
	lda	1,i
	sta	isneg,d
	
	deci	decinp1,d		; load and verify all inputs
	lda	decinp1,d
	brv	ovrflw
	chari	charin,d
	lda	charin,d
	brv	ovrflw
	deci	decinp2,d
         	lda	decinp2,d
	brv	ovrflw

;input
	lda	charin,d
	cpa	11077,i		; compare to +
	breq	add
	cpa	11589,i		; compare to -
	breq	sub
	cpa	10821,i		; compare to *
	breq	multi
	cpa	12101,i		; compare to /
	breq	divi
	call 	invalid 
	br	main
;__________________________________________________________________________________________________________________________________
add:	lda	decinp1,d
	adda	decinp2,d
	sta	sum,d
	call	print
	br	main
;__________________________________________________________________________________________________________________________________
sub:	lda	decinp1,d
	suba	decinp2,d
	sta	sum,d
	call	print
	br	main
;__________________________________________________________________________________________________________________________________
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


invalid:	stro	invmsg,d
	ret0


invsum:	lda	sum,d
	nega
	sta	sum,d
	br	rawprint


print:	lda	isneg,d 
	brlt	invsum
rawprint:	lda 	sum,d
	brv	ovrflw
	charo	'=',i
	deco	sum,d
	charo	'\n',i
	ret0


ovrflw:	stro	ovrflwm,d
	br	main


;Variables
decinp1:	.word	0 
decinp2:	.word	0
sum:	.word	0
isneg:	.word	1
charin:	.ASCII	"\x00"
dby0msg: 	.ASCII 	"Error: cannot divide by zero\n\x00"
invmsg:	.ASCII	"Error: invalid expression\n\x00"
ovrflwm:	.ASCII	"Error: overflow\n\x00"
.end