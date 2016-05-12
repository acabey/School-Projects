main:	deci	decinp1,d
	lda	decinp1,d
	brv	ovrflw
	chari	charin,d
	lda	charin,d
	brv	ovrflw
	deci	decinp2,d
         	lda	decinp2,d
	brv	ovrflw

	lda	charin,d
	cpa	11077,i
	breq	add
	cpa	11589,i
	breq	sub
	call 	invalid 
	br	main

add:	lda	decinp1,d
	adda	decinp2,d
	brv	ovrflw
	sta	sum,d
	call	print
	br	main

sub:	lda	decinp1,d
	suba	decinp2,d
	brv	ovrflw
	sta	sum,d
	call	print
	br	main

invalid:	stro	invmsg,d
	ret0

print:	charo	'=',i
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