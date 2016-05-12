#Copyright Andrew Cabey

def gcf(a, b):
	while b:			#While b is positive
		a, b = b, a%b	#a = b, b = modulo of a and b. b is now the remainder of the division
	return a

userInA = int(raw_input("Enter the first number"))
userInB = int(raw_input("Enter the second number"))

print "The GCF of " + str(userInA) + " and " + str(userInB) + " is: " + str(gcf(userInA, userInB))