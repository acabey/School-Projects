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

carddeck = generateDeck()

hands = []
for i in range(0,4):
	hand = []
	for x in range(0,5):
		index = randint(0, len(carddeck)-1)
		card = carddeck[index]
		hand.append(card)
		del carddeck[index]
	hands.append(hand)

print hands