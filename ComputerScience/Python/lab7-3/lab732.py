#Copyright Andrew Cabey 2016
#Lab 73 #2

suits = ['clubs', 'diamonds', 'hearts', 'spades']
ranks = ['ace', '2', '3', '4', '5', '6', '7', '8', '9', 'ten', 'jack', 'queen', 'king'] 

cards = []

for rank in ranks:
	for suit in suits:
		cards.append(str(rank[0]+suit[0]))

cards.sort()