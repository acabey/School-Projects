#Copyright Andrew Cabey 2016
#opens your file, reads it line by line, and prints out each line
import os

myfile = open("file.txt")
lines = myfile.read().splitlines()
for line in lines:
	print line