# -*- coding: UTF-8 -*-
from Utilizadores import Utilizadores
from Produtos import Produtos
from Maquinas import Maquinas
from config import *
from datetime import *
import random
import MySQLdb


db = MySQLdb.connect("localhost","root","password","BIVM")

users = []
products = []
machines = []

# print "A criar Utilizadores"
# for i in range(NUtilizadores):
#     u = Utilizadores()
#     u.insertInDB(db)
#     users.append(u)
# print "Criados " + str(NUtilizadores) + " utilizadores"

# print "A criar Produtos"
# for i in range(NProdutos):
#     p = Produtos()
#     p.insertInDB(db)
#     products.append(p)
# print "Criados " + str(NProdutos) + " produtos"

# print "A criar Maquinas"
# for i in range(NMaquinas):
#     m = Maquinas()
#     m.insertInDB(db)
#     machines.append(m)
# print "Criados " + str(NMaquinas) + " maquinas"

# print "Vamos às vendas!"
totalSales = 0

for i in range(sellingPeriod.days + 1):
    if i % DiasEntreRemessas == 0:
        rs = Remessas((fstSell + timedelta(days=i)), machines, products)
        for r in rs:
            r.insertInDB()

    for j in range(int(random.normalvariate(AVGVendasDia, DesvioVendasDia))):
        v = Vendas((fstSell + timedelta(days=i)), users, machines, products)
        v.insertInDB()
        totalSales = totalSales + 1

print "Criadas " + str(totalSales) + " vendas"

db.close()