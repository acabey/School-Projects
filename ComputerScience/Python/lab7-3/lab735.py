#Copyright Andrew Cabey 2016
#Lab 73 #5

from random import randint

def generateDeck():
	suits = ['clubs', 'diamonds', 'hearts', 'spades']
	ranks = ['ace', '2', '3', '4', '5', '6', '7', '8', '9', 'ten', 'jack', 'queen', 'king'] 
	cards = []
	for rank in ranks:
		for suit in suits:
			cards.append(str(rank[0]+suit[0]))
	cards.sort()
	return cards

def aces(hand):
	i = 0
	for card in hand:
		if card[0] == 'a':
			i += 1
	return i

def dealHand(l_deck, l_cards):
	hand = []
	for x in range(0,l_cards):
		index = randint(0, len(l_deck)-1)
		card = l_deck[index]
		hand.append(card)
		del l_deck[index]
	return hand

#This won't actually work, the cards can be dealt more than once
def dealHands(l_deck, l_hands, l_cards):
	hands = []
	for i in range(0,l_hands):
		hands.append(dealHand(l_deck, l_cards))
	return hands

m_hands = []
for i in range(0,20):
	m_deck = generateDeck()
	m_hands.append(dealHand(m_deck, 5))

i = 0
for hand in m_hands:
	if aces(hand):
		i+=1
	print str(hand) + " " + str(aces(hand))
print "There are " + str(i) + " hands with aces"