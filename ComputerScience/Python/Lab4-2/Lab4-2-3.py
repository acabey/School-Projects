#Loops unil breaking
while (1):
	response = raw_input("What time is it? ")
	if (response == "Party Time"):
            break
        else:
            print "Of course it's not \"" + str(response) + "\", try again! "
print "Final message"