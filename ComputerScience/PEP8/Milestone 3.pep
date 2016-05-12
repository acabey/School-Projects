main:	lda	0,i
	sta	sum,d
	deci	decinp1,d	; load and verify all inputs
	lda	decinp1,d
	brv	ovrflw
	chari	charin,d
	lda	charin,d
	brv	ovrflw
	deci	decinp2,d
         	lda	decinp2,d
	brv	ovrflw

	lda	charin,d
	cpa	11077,i	; compare to +
	breq	add
	cpa	11589,i	; compare to -
	breq	sub
	cpa	10821,i	; compare to *
	breq	multi
	;cpa	12101,i	; compare to /
	;breq	div
	call 	invalid 
	br	main

add:	lda	decinp1,d
	adda	decinp2,d
	sta	sum,d
	call	print
	br	main

sub:	lda	decinp1,d
	suba	decinp2,d
	sta	sum,d
	call	print
	br	main

multi:	call 	invert 	;Handle negatives
	call    	mult 	;Call multiplication
	call	print 	;Print product
	br	main

mult: 	lda 	sum,d	;do {sum += imp1; --inp2} while !(inp2==0)
	adda 	decinp1,d
	sta 	sum,d
	lda 	decinp2,d
	suba 	1,i
	breq 	end
	sta 	decinp2,d
	br 	mult
end: 	ret0

invert: 	lda 	decinp2,d 	;if inp2 is not negative, return to call
	brlt 	isneg
	ret0
isneg: 	nega 		;if inp2 is negative: invert inp2 and inp1. Allow loop to handle negative
	sta 	decinp2,d
	lda 	decinp1,d
	nega
	sta 	decinp1,d
	ret0



invalid:	stro	invmsg,d
	ret0

print:	lda 	sum,d
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
charin:	.ASCII	"\x00"
invmsg:	.ASCII	"Error: invalid expression\n\x00"
ovrflwm:	.ASCII	"Error: overflow\n\x00"
.end