#Copyright Andrew Cabey 2016
import socket
import sys

serversocket = socket.socket()
serversocket.bind(('localhost', 5010))
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