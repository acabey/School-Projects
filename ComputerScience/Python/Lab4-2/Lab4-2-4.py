#Copyright Andrew Cabey 2016

while(1):
	raw = str(raw_input("Absolute value finder\nJust enter a positive or negative number, or 0 to quit: "))
	floatin = float(raw)
	intin = int(floatin)

	if (intin == 0):
		break
	#Inverts input if negative
	if (intin < 0):
		intin *= -1
		floatin *= -1.0
	if ('.' in raw):
		print "The absolute value of \""+raw+"\" is "+str(floatin)
	else:
	    print "The absolute value of \""+raw+"\" is "+str(intin)