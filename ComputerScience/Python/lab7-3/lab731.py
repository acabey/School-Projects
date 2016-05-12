#Copyright Andrew Cabey 2016
#Lab 73 #1

names = []

while True:
	userInput = str(raw_input("Enter a name: "))
	if not userInput:
		break
	names.append(userInput)

names.sort()

for x in names:
	print x