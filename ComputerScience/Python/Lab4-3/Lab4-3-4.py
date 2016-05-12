#Copyright Andrew Cabey 2016
while (1): #Continuous loop until breaking
	user_in = raw_input("Enter an interesting and relatively long string of characters or Q to quit: ")
	i = 0
	c = 0
	if (user_in == 'Q'):
		break
	#Loops throughout entire string
	while (i < len(user_in)):
		if (user_in[i].lower() == 'e'):
			c+=1
		i+=1
	print "Found " + str(c) + " \'e\'s"
print "Be sure to check out my mixtape"
