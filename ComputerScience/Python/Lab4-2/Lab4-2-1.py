#Program prompts user for input then uses control flow to respond accordingly

response = int(raw_input("Whats the current tempurature outside? "))
if (response > 65):
	print "Guns out"
elif (response < 40):
	print "Brr"
else:
	print "That's so moderate"

response = int(raw_input("Whats your GPA? "))
if (response > 4):
        print "Wow ur so cool"
elif (response < 2):
        print "wow ur no bueno"
else:
        print "Cool dude"

response = int(raw_input("What's your age "))
if (response > 65):
        print "u can reture"
elif (response < 35):
        print "U cant run for president"
else:
        print "Hope ur doin gud"

response = int(raw_input("How cool are you? (number) "))
if (response > 100):
        print "thats not narcissistic"
elif (response < 1):
        print "get some self-confidence"
else:
        print "cool dude"

response = int(raw_input("What percentage is your battery at? "))
if (response > 100):
        print "liar"
elif (response < 50):
        print "go charge"
else:
        print "get back to work"
