# -*- coding: UTF-8 -*-
from config import malePopulation, initialBalance, jobs
import idGenerator
import random
import MySQLdb

class Utilizadores:

    def __init__(self):  
      if(random.random() > malePopulation):
        self.sex = 'F'
      else:
        self.sex = 'M'

      self.name = idGenerator.getRandomUniqName(self.sex)
      self.mail = idGenerator.getMailFromName(self.name)
      self.password = idGenerator.randomPassword()
      self.balance = random.choice(initialBalance)
      self.job = random.choice(jobs)
      self.birth = idGenerator.genAge()
      self.id = -1


    def __str__(self):
      return self.sex + " " + self.name + " " + self.mail + " " + self.password + " " + str(self.balance) + " " + self.job + " " + str(self.birth)

    def insertInDB(self, db):

      cursor = db.cursor()

      cursor.execute("INSERT INTO Utilizador (Email, Password, Saldo, Nome, Profissao, Genero, Data_nascimento) VALUES (%s, %s, %s, %s, %s, %s, %s);", (self.mail.decode("utf-8").encode("latin-1"), self.password.decode("utf-8").encode("latin-1"), self.balance, self.name.decode("utf-8").encode("latin-1"), self.job.decode("utf-8").encode("latin-1"), self.sex, self.birth))

      db.commit()

      cursor.execute("SELECT id FROM Utilizador WHERE email='" + self.mail + "';")
      self.id = cursor.fetchone()[0]

      cursor.close()