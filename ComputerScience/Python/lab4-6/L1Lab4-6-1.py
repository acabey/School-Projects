#Copyright Andrew Cabey 2016
while(True):
	data = eval(raw_input("Enter a list of numbers in square brackets:\n"))
	if (not len(data)): break
	
	# Sort the data
	for firstUnsorted in range(1, len(data)):
	    for compare in range(0, len(data) - 1):
	       if data[compare] > data[compare + 1]:
	       	temp = data[compare]
	       	data[compare] = data[compare + 1]
	       	data[compare+1] = temp
	print data