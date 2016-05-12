#Copyright Andrew Cabey 2016
#Lab 73 #6

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

def handswithaces(hands):
	i = 0
	for hand in hands:
		if aces(hand):
			i+=1
	return i

def aces(hand):
	i = 0
	for card in hand:
		if card[0] == 'a':
			i += 1
	return i

#I hate performance so I'm not using variables
def highcard(hand):
	highestcard = "2"
	values = {'t' : 10, 'j' : 11, 'q' : 12, 'k' : 13, 'a' : 14, '2' : 2, '3' : 3, '4' : 4, '5' : 5, '6' : 6, '7' : 7, '8' : 8, '9' : 9}
	for card in hand:
		if values.get(card[0]) > values.get(highestcard[0]): 
			highestcard = card
	return highestcard

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

if __name__ == "__main__":
	print highcard (['4d','8c','5d'])			# 8c
	print highcard (['4d'])						# 4d
	print highcard (['2d','jc','kd','tc','ad'])	# ad
	print highcard (['qd','jc','9d','tc','2c'])	# qd
	print highcard (['3d','tc','9d','ts','2d'])	# tc or ts 
	print highcard (['2d','2c','2h','3c','2s'])	# 3c