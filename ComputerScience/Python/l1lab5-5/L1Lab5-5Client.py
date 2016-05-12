#Copyright Andrew Cabey 2016
import os, socket

ip = "127.0.0.1"

s = socket.socket()
s.connect((ip, 5000))

s.send("Dank memes")
s.close()