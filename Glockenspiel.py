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
	top = float(pi*v*K*pow(m,2))
	bottom = float(8*f)
	return sqrt(top/bottom)

def radGyrationBar(thickness):
	return thickness/3.46

def radGyrationPipe(radiusInner, radiusOuter):
	return .5*math.sqrt((radiusInner**2)+(radiusOuter**2))

#This is broken
"""
def frequencyNote(note, octave):
	x=octave-1
	y=note
	a=2**x
	b=1.059463**y
	return = 275*a*b/10;
"""

def pitch(freq):	
	from math import log2, pow
	h = round(12*log2(freq/C0))
	octave = h // 12
	n = h % 12
	return pitches[n] + str(octave)
	

if __name__ == '__main__':
	desiredNotes = ['C7', 'C#7', 'D7', 'D#7', 'E7', 'F7', 'F#7', 'G7', 'G#7', 'A7', 'A#7', 'B7', 'C8', 'C#8','D8', 'D#8', 'E8']
	desiredFreqs = [2093, 2217.46, 2349.32, 2489.02, 2637.02, 2793.83, 2959.96, 3135.96, 3322.44, 3520.00, 3729.31, 3951.07, 4186.01, 4434.92, 4698.63, 4978.03, 5274.04]
	#output = [0.1087740828685471, 0.10567740667430857, 0.10266891121583085, 0.09974608326590563, 0.09690659466597884, 0.09414777399901017, 0.09146756618168685, 0.08886378086803991, 0.08633392208046284, 0.08387619344505425, 0.08148840204096675, 0.07916854847192305, 0.07691479974227595, 0.07472521087761211, 0.07259796059202207, 0.07053120271649775, 0.06852331023000975]

	output = [] 
	#print str(len(desiredNotes)), str(len(desiredFreqs))
	K = 0.0047625/3.46
	for freq in desiredFreqs:
		output.append(round(lengthRequired(5050, K, freq, 3.012)*100,3))
	print len(output)
	print sum(output)
	print output
