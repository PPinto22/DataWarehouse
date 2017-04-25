# -*- coding: UTF-8 -*-
from config import *
import random
import sys
import string
from datetime import *

allNames = set()

def getRandomUniqName(s):

	name = getRandomName(s)

	while(name in allNames):
		name = getRandomName(s)

	allNames.add(name)
	return name


def getRandomName(s):
	if(s == 'M'):
		return ' '.join(random.sample(male, 2)) + ' ' + ' '.join(random.sample(surname, 2))
	else:
		return ' '.join(random.sample(female, 2)) + ' ' + ' '.join(random.sample(surname, 2))


def getMailFromName(n):
	mail = "_".join(map(lambda x :cleanName(x), n.split(" ")))
	domain = random.choice(mailserver)

	return mail + "@" + domain

def cleanName(n):
	n = n.lower()
	for r in sCharsReplacement:
		n = n.replace(r[0], r[1])
	return n

def randomPassword():
	return ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(10))

def genAge():
	return fstBornDate + timedelta(days=int(bornPeriod.days*random.normalvariate(0.5, 0.12)))

def genRandomAddress():
	n = random.randint(0, len(adresses) - 1)

	add = (adresses[n][0], adresses[n][4], adresses[n][1], random.randint(0, 1000), "Portugal", adresses[n][3], adresses[n][2])

	return add