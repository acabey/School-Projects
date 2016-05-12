#Copyright Andrew Cabey 2016
#L1Lab7-3

from random import randint,seed
from lab736 import generateDeck,aces,dealHand,dealHands,handswithaces

for q in range(1000,1000000):
	seed(1)
	average = 0
	

	for z in range(0,10):
		m_hands = []
		acecount = []
		for i in range(0,q):
			m_deck = generateDeck()
			m_hands.append(dealHand(m_deck, 5))
		
		acecount.append(handswithaces(m_hands))
		average = sum(acecount)/float(q)
	
	if abs(average-0.341158002) < .001: 
		print q
		break

"""

For q between 1000 and 1000000
	average = 0
	For 10 jogs, generate q hands
		acecount = []

		For every hand, count how many have aces
			Take the average of (aces/q) for all 10 jogs and record in dankmemes
		
		average = sum(acecount)/q
	
	if average is close to value: print it and quit

"""