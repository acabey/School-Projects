#Copyright Andrew Cabey 2016
#L1Lab7-3

from random import randint,seed
from lab736 import generateDeck,aces,dealHand,dealHands,handswithaces

seed(1)

m_hands = []
for i in range(0,1000):
	m_deck = generateDeck()
	m_hands.append(dealHand(m_deck, 5))

print "There are " + str(handswithaces(m_hands)) + " hands with aces"