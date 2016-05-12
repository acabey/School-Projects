#Copyright Andrew Cabey 2016
user_in = raw_input("Enter an interesting and relatively long string of characters: ")
i = 0
c = 0
#Loops throughout entire string
while (i < len(user_in)):
	if (user_in[i] == 'e'):
		c+=1
	i+=1
print c
