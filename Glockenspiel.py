#Copyright Andrew Cabey 2016
#Calculates required length of pipe or bar for a given frequency

#Constant velocities of a wave through media
velocityMedium = {
'Aluminium' : 5150,
'Brass'		: 3500,
'Copper'	: 3700,
'Steel' 	: 5050,
'Glass'		: 5200
}

#Coefficient of length to produce an antinode in the center as well as each end of the bar.
nodesLength = {
'f1'		: .224,
'f2'		: .776
}

#Fundamental frequency constants
A4 = 440
C0 = A4*pow(2, -4.75)
pitches = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]

#Properties of the stock
height = 0.0047625 #meters

#Calculate frequency of the nth transverse mode of vibration for a bar or pipe
"""
v = speed of sound in the wave's medium of travel
K is the radius of gyration (see @radGyration)
L is the length of the bar or pipe
m is a constant related to n by the equation (2n+1)
"""
def frequencyProduced(v, K, L, m):
	from math import pi, sqrt
	if m == 3: m = 3.012 #More accurate predetermined value. If n is greater than 1, this inaccuracy becomes negligible
	return ((math.pi * v * K)/(8*L**2))*m**2

def lengthRequired(v, K, f, m):
	from math import pi, sqrt
	if m == 3: m = 3.012
	return math.sqrt((math.pi*v*k*m**2)/8*f)

def radGyrationBar(thickness):
	return thickness/3.46

def radGyrationPipe(radiusInner, radiusOuter):
	return .5*math.sqrt((radiusInner**2)+(radiusOuter**2))

#This is broken
def frequencyNote(note, octave):
	x=octave-1
	y=note
	a=2**x
	b=1.059463**y
	return = 275*a*b/10;
    
def pitch(freq):	
	from math import log2, pow
    h = round(12*log2(freq/C0))
    octave = h // 12
    n = h % 12
    return pitches[n] + str(octave)
	

if __name__ == '__main__':
	for a in range(96, 104):
		print str(chr(a).uppercase()) + lengthRequired(velocityMedium['Aluminium'], radGyrationBar(0.00635), frequencyNote(a))