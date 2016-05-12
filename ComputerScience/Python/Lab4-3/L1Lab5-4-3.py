#Copyright Andrew Cabey 2016
#opens your file, reads it line by line, and prints out each line
import os
inpPath = str(raw_input("Enter a filename or path: "))

myfile = open(inpPath)
outfile = open("temp.txt", "w")

lines = myfile.read().splitlines()
for line in lines:
	print line
	userIn = str(raw_input("Enter text to replace this line: "))
	if (not userIn):
		outfile.write(line+"\n")
	else:
		outfile.write(userIn+"\n")

os.remove(inpPath)
os.rename("temp.txt", inpPath)

myfile.close()
outfile.close()