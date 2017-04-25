# -*- coding: UTF-8 -*-
from config import NProdutos, produtos
import idGenerator
import random
import MySQLdb

class Produtos:

    pCount = 0

    def __init__(self):
      self.name = produtos[Produtos.pCount][0]
      self.APrice = produtos[Produtos.pCount][1]
      self.SPrice = produtos[Produtos.pCount][2]
      self.id = -1

      Produtos.pCount = Produtos.pCount + 1

    def __str__(self):
      return self.name + " " + self.APrice + " " + self.SPrice

    def insertInDB(self, db):

      cursor = db.cursor()

      cursor.execute("INSERT INTO Produto (Nome, PrecoA, PrecoV) VALUES (%s, %s, %s);", (self.name.decode("utf-8").encode("latin-1"), str(self.APrice), str(self.SPrice)))

      db.commit()

      cursor.execute("SELECT id FROM Produto WHERE Nome='" + self.name.decode("utf-8").encode("latin-1") + "';")
      self.id = cursor.fetchone()[0]

      cursor.close()