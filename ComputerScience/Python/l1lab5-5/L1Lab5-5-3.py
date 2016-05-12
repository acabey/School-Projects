#Copyright Andrew Cabey 2016
import socket

s = socket.socket()
s.connect(("localhost", 5010))

while True:
	userin = raw_input("Enter a message to relay: ")
	if (userin == "Quit"):
		s.close()
		break
	else: 
		s.send(userin)
		copyback = s.recv(1024)
		if not copyback:
			print "Connection has been closed by server"
			break
		else:
			print copyback