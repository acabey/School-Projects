#Copyright Andrew Cabey 2016
def swap(leftIndex, rightIndex):
	temp = data[leftIndex]
	data[leftIndex] = data[rightIndex]
	data[rightIndex] = temp

while(True):
	data = eval(raw_input("Enter a list of numbers in square brackets:\n"))
	if (not len(data)): break

	isSorted = false
	while (not isSorted):


	for i in range(0, len(data)):
		for firstUnsorted in range(i+1, len(data)):
			if data[i] > data[firstUnsorted]:
				swap(i, firstUnsorted)
	print data

	# 9,6,4

	#Loop through whole set
		#