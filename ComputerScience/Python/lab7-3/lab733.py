#Copyright Andrew Cabey 2016
#Lab 73 #3
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

deck = generateDeck()

for i in range(0,4):
	hand = []
	for x in range(0,5):
		index = randint(0, len(deck)-1)
		card = deck[index]
		hand.append(card)
		deck.remove(card)
	#print "\nHand #" + str(i) + " " + hand + "\n"
	print hand