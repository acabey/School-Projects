#Copyright Andrew Cabey 2016
while(True):
	data = eval(raw_input("Enter a list of numbers in square brackets:\n"))
	if (not len(data)): break
	# Sort the data
	firstUnsorted = 0
	while (firstUnsorted < len(data) - 1):
		#data[firstUnsorted] = smallest remaining unsorted item
		# data[firstUnsorted] = smallest remaining unsorted item
		compare = firstUnsorted + 1
		while (compare < len(data)):
			if(data[firstUnsorted] > data[compare]):
				temp = data[firstUnsorted]
				data[firstUnsorted] = data[compare]
				data[compare] = temp
			compare+=1
		firstUnsorted+=1
	print data