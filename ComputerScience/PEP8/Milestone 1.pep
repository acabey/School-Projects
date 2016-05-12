main:	deci	decinp1,d
	chari	charin,d
	deci	decinp2,d

	ldbytea	charin,d
	cpa	43,i
	breq	add
	ldbytea	charin,d
	cpa	45,i
	breq	sub
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

invalid:	stro	invmsg,d
	ret0

print:	charo	'=',i
	deco	sum,d
	charo	'\n',i
	ret0


;Variables
decinp1:	.word	0 
decinp2:	.word	0
sum:	.word	0
charin:	.ASCII	"\x00"
invmsg:	.ASCII	"Error: invalid expression\n\x00"
.end