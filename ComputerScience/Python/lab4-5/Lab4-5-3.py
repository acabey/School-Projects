#Copyright Andrew Cabey 2016
data = eval(raw_input("Enter a list of numbers in square brackets:\n"))
# Sort the data
firstUnsorted = 0
	while (firstUnsorted < len(data) - 1):
		#data[firstUnsorted] = smallest remaining unsorted item
		# data[firstUnsorted] = smallest remaining unsorted item
		compare = firstUnsorted + 1
		while (compare < len(data)):
			#if(data[firstUnsorted] > data[compare]):
			#	Swap firstUnsorted item with the smallest
			compare++
		firstUnsorted++
