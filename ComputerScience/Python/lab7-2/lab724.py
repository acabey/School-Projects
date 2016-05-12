#Copyright Andrew Cabey

from lab722 import gcf

userInA = int(raw_input("Enter the first number"))
userInB = int(raw_input("Enter the second number"))

print "The GCF of " + str(userInA) + " and " + str(userInB) + " is: " + str(gcf(userInA, userInB))