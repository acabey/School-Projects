#Copyright Andrew Cabey

def gcf(a, b):
	while b:			#While b is positive
		a, b = b, a%b	#a = b, b = modulo of a and b. b is now the remainder of the division
	return a

