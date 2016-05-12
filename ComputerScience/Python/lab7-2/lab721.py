#Copyright Andrew Cabey 2016

a = int(raw_input("Enter the first number"))
b = int(raw_input("Enter the second number"))

while b:			#While b is positive
	a, b = b, a%b	#a = b, b = modulo of a and b. b is now the remainder of the division

print a