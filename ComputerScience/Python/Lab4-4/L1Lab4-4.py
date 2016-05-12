#Copyright Andrew Cabey
while (True):
	userInput = str(input("Enter a list of numbers in square brackets: \n"))
	userData = eval(userInput)
	if (not userData): break
	userGoal = input("Enter number to find: ")

	dataStart = int(0)
	dataEnd = int(len(userData) -1)

	while (dataStart <= dataEnd):
		indexMiddle = (int(dataStart + dataEnd)/2)
		dataMiddle = userData[indexMiddle]
		if (dataMiddle == userGoal):
			print "Found your number (" + str(dataMiddle) + ") at position " + str(indexMiddle) + "(" + str(indexMiddle+1) + ")"
			break
		elif (dataMiddle < userGoal):
			dataStart = indexMiddle + 1
		else:
			dataEnd = indexMiddle - 1
	if (dataStart > dataEnd):
		print "Could not find number"
print "Bye"