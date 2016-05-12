#Copyright Andrew Cabey

from lab722 import gcf

doContinue = True

while doContinue:
	userInA = raw_input("Enter the first number or \"quit\" to exit: ")
	if userInA == "quit":
		break
	else:
		userInA = int(userInA)

	userInB = raw_input("Enter the second number or \"quit\" to exit: ")
	if userInB == "quit":
		break
	else:
		userInB = int(userInB)

	print "The GCF of " + str(userInA) + " and " + str(userInB) + " is: " + str(gcf(userInA, userInB))