#Copyright Andrew Cabey 2016
import socket, sys, errno
from socket import error as socket_error

ADDRESS = "localhost"
PORT = 5010

try:
	doClient()
except socket.error, e:
	if e.errno == errno.ECONNREFUSED:
		print "Failed to connect to server, fallback to operate as server"
	else:
		print "Unexpected exception"
		sys.exit(1)
finally:
	doServer()

def doClient():
	print "Operating as client"
	s = socket.socket()
	s.connect((ADDRESS, PORT))

	while True:
		userin = raw_input("Enter a message to relay: ")
		if (userin == "Quit"):
			s.close()
			sys.exit(0)
		else: 
			s.send(userin)
			copyback = s.recv(1024)
			if not copyback:
				print "Connection has been closed by server"
				sys.exit(0)
			else:
				print copyback

def doServer():
	print "Operating as server"
	serversocket = socket.socket()
	serversocket.bind((ADDRESS, PORT))
	serversocket.listen(1)

	while True:
		print "Accepting connection"
		connection, address = serversocket.accept()
		
		print "Recieving initial input"
		buf = connection.recv(1024)
		print buf
		
		while len(buf) > 0:
			if (buf == "kys"):
				print "Killing server"
				connection.close()
				serversocket.shutdown(socket.SHUT_RDWR)
				serversocket.close()
				sys.exit(0)
			else:
				print "Recieved input: " + buf
				connection.sendall("Did you just tell me to: " + buf + "?")

			print "Recieving input"
			buf = connection.recv(1024)
			print buf