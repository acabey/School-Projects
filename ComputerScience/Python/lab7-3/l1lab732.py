#Copyright Andrew Cabey 2016
#L1Lab7-3

from random import randint,seed
from lab736 import generateDeck,aces,dealHand,dealHands,handswithaces


def doRun(handsCount=1000, cardsCount=5, doSeed=False, seedValue=1):
	"""
	Simulates a single run generating a given number of hands and given number of cards per hand
	Returns the number of hands generated that have at least one ace
	"""
	if doSeed: seed(seedValue)
	m_hands = []
	for i in range(0,handsCount):
		m_hands.append(dealHand(generateDeck(), cardsCount))
	return handswithaces(m_hands)

def doTargetIntRuns(handsCount=1000, runCount=10, targetRatio=0.341158002, doSeed=False, seedValue=1):
	"""
	Simulates 10 runs with a given number of hands
	Returns the number of runs which were accurate to the theoretical amount of hands with aces
	"""
	if doSeed: seed(seedValue)
	i = 0
	for l_runs in range(0,int(runCount)):
		if isGoodRatio(doRun(handsCount)/float(handsCount)):
			i+=1
	return i

def isGoodRatio(number, target=0.341158002, accuracy=.01):
	if abs(number - target) < accuracy: return True
	return False

def doArrayRuns(runCount=10, handsCount=1000, doSeed=False, seedValue=1):
	"""
	Simulates a given number of runs with a given number of hands
	Returns a list containing the amount of hands with aces for each run
	"""
	if doSeed: seed(seedValue)
	withAces = []
	for l_runs in range(0,runCount):
		withAces.append(doRun(handsCount))
	return withAces

def bruteForceRequiredHands(minimum=1000, maximum=10000000, runCount=10, requiredRuns=9, targetRatio=0.341158002, doSeed=False, seedValue=1):
	"""
	Brute force the required amount of hands until 9/10 runs are accurate to theoretical value

	 -Loop while incrementing amount of hands
	   -If there are 9 runs where hands_with_aces/handscount is within .01 to 0.341158002, stop and return handscount
	"""
	for handscount in range(minimum,maximum, 1):
		if doSeed: seed(seedValue)
		a = doTargetIntRuns(handscount)
		print str(a) + " of 9 runs reached at " + str(handscount)
		if a >= requiredRuns:
			return handscount

def bruteForceRequiredSeed(minimum=1, maximum=10000000, handsPerRun=1000, runCount=10, requiredRuns=9, targetRatio=0.341158002):
	"""
	Brute force the required seed until 9/10 runs are accurate to theoretical value with 1000 hands

	 -Loop while incrementing seed value
	   -If there are 9 runs where hands_with_aces/handscount is within .01 to 0.341158002, stop and return desiredSeed
	"""
	for desiredSeed in range(minimum,maximum, 1):
		seed(desiredSeed)
		a = doTargetIntRuns(handsPerRun)
		print str(a) + " of 9 runs reached at " + str(desiredSeed)
		if a >= requiredRuns:
			return desiredSeed


if __name__ == '__main__':
	#seed(1)
	#for runs in doArrayRuns(10, bruteForceRequiredHands()):
	#	print "There are " + str(runs) + " with aces"
	#for stuff in doArrayRuns(10, 100000):
	#	print "There are " + str(stuff) + " with aces. Ratio is " + str(float(stuff)/float(100000)) + " result is " + str(isGoodRatio(float(stuff)/float(100000)))
	
	#print str(doTargetIntRuns(100000)) + " of 9 runs reached at " + str(100000)
	
	print bruteForceRequiredSeed(handsPerRun=100, targetRatio=.3) #At seed 167 and 1000 hands, first run will be 9 of 9

"""
	#Prove that with the right seed, even with 1000 hands all of them could be fine. At 1000 hands, seed must be 167
	for stuff in doArrayRuns(runCount=10, handsCount=1000, doSeed=True, seedValue=167):
		print "There are " + str(stuff) + " with aces. Ratio is " + str(float(stuff)/float(1000)) + " which is " + str(isGoodRatio(float(stuff)/float(1000)))
"""