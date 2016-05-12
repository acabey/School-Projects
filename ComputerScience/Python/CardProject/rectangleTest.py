from graphics import *


w = GraphWin('Poker Game', 600, 400)
rect = Rectangle(Point(.15*w.width,.85*w.height), Point(.23*w.width,.8*w.height))

for point in rect:
	print point