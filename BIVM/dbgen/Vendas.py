# -*- coding: UTF-8 -*-
from config import *
from datetime import *
import idGenerator
import random
import MySQLdb

class Vendas:

    def __init__(self, date, users, machines, products):
        self.date = str(date) + " " + format(random.randint(0, 23), '02d') + ":" + format(random.randint(0, 59), '02d') + ":" + format(random.randint(0, 59), '02d')
        self.user = random.choice(users).id
        self.machine = random.choice(machines).id
        self.product = random.choice(products).id

    def insertInDB(self, db):
        cursor = db.cursor()

        try:
            cursor.callproc('sp_venda', (self.date.decode('utf-8').encode('latin-1'), self.machine, self.user, self.product))
        except:
            pass

        cursor.close()