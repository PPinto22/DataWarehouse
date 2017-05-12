# -*- coding: UTF-8 -*-
from config import *
from datetime import *
import idGenerator
import random
import MySQLdb

class Remessas:

    def __init__(self, date, machine, product):
        self.expirationDate = date + timedelta(days=product.expirationDate)
        self.capacity = machine.capacity
        self.maquinaID = machine.id
        self.productID = product.id

    def insertInDB(self, db, cursor):
        cursor.execute("INSERT INTO Remessa (Validade, Quantidade, Maquina, Produto) SELECT %s, %s - IF(SUM(quantidade) is NULL, 0, SUM(quantidade)), %s, %s FROM Remessa WHERE Maquina = %s and Produto = %s;", (str(self.expirationDate).decode("utf-8").encode("latin-1"), self.capacity, self.maquinaID, self.productID, self.maquinaID, self.productID))

        db.commit()