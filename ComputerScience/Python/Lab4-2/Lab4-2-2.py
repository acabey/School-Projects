print "Jigglypuff dies at 65 with upthrow upair, but deals 2-3 damage per laser shot"
response = int(raw_input("How many lasers do I spam Puff with? "))
count = 0
#Loops through for the amount that the user provides
while (response > 0):
	if (count == 32):
		print "Up throw up air ready!"
	if (count == 44):
			print "Up smash ready!"
	print "Pew pew"
	count += 1
	response -= 1
print "\n\nNow go up smash!"