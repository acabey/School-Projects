#Copyright Andrew Cabey 2016
#Lab 73 #4

def aces(hand):
	i = 0
	for card in hand:
		if card[0] == 'a':
			i += 1
	return i