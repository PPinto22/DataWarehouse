# -*- coding: UTF-8 -*-
from config import *
import idGenerator
import random
import MySQLdb

class Maquinas:

    def __init__(self):

        m = random.randint(0, len(machineModel) - 1)
        r = random.randint(0, len(machineRent) - 1)

        self.id = -1

        self.description = "Desc"
        self.model = machineModel[m][0]
        self.capacity = machineModel[m][1]
        self.rent = machineRent[r]

        self.addId = -1
        self.address = idGenerator.genRandomAddress()

        self.stock = {}

        for i in produtos:
            self.stock[i[0]] = 0


    def __str__(self):
        return self.description + " " + self.model + " " + self.capacity + " " + self.rent

    def insertInDB(self, db):
        
        cursor = db.cursor()
        
        cursor.execute("INSERT INTO Morada (Cod_Postal, Freguesia, Rua, Porta, Pais, Cidade, Distrito) VALUES (%s, %s, %s, %s, %s, %s, %s);", (self.address[0].decode("utf-8").encode("latin-1"), self.address[1].decode("utf-8").encode("latin-1"), self.address[2].decode("utf-8").encode("latin-1"), str(self.address[3]).decode("utf-8").encode("latin-1"), self.address[4].decode("utf-8").encode("latin-1"), self.address[5].decode("utf-8").encode("latin-1"), self.address[6].decode("utf-8").encode("latin-1")))
        
        db.commit()
        
        cursor.execute("SELECT id FROM Morada WHERE Cod_Postal = %s and Freguesia = %s and Rua = %s and Pais = %s and Cidade = %s and Distrito = %s and Porta = %s",
            (self.address[0].decode("utf-8").encode("latin-1"),
            self.address[1].decode("utf-8").encode("latin-1"),
            self.address[2].decode("utf-8").encode("latin-1"),
            self.address[4].decode("utf-8").encode("latin-1"),
            self.address[5].decode("utf-8").encode("latin-1"),
            self.address[6].decode("utf-8").encode("latin-1"),
            self.address[3]))


        self.addId = cursor.fetchone()[0]

        cursor.execute("INSERT INTO Maquina (Descri\xe7ao, Modelo, Renda, Capacidade, Morada) VALUES (%s, %s, %s, %s, %s)",
                       (self.description.decode("utf-8").encode("latin-1"),
                        self.model.decode("utf-8").encode("latin-1"),
                        self.rent.decode("utf-8").encode("latin-1"),
                        self.capacity,
                        self.addId))
        db.commit()
        
        cursor.execute("SELECT id FROM Maquina WHERE Morada = %s", (self.addId,))

        self.id = cursor.fetchone()[0]
        
        cursor.close()