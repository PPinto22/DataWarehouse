# -*- coding: UTF-8 -*-
from Utilizadores import Utilizadores
from Produtos import Produtos
from Maquinas import Maquinas
from Remessas import Remessas
from Vendas import Vendas
from config import *
from datetime import *
import random
import math
import MySQLdb


db = MySQLdb.connect("localhost","root","password","BIVM")

users = []
products = []
machines = []

print "A criar Utilizadores"
for i in range(NUtilizadores):
    u = Utilizadores()
    u.insertInDB(db)
    users.append(u)
print "Criados " + str(NUtilizadores) + " utilizadores"

print "A criar Produtos"
for i in range(NProdutos):
    p = Produtos()
    p.insertInDB(db)
    products.append(p)
print "Criados " + str(NProdutos) + " produtos"

print "A criar Maquinas"
for i in range(NMaquinas):
    m = Maquinas()
    m.insertInDB(db)
    machines.append(m)
print "Criados " + str(NMaquinas) + " maquinas"

# Making so that some district are more likely to sell than the others
allDistricts = set()

for d in adresses:
    allDistricts.add(d[2])

machines = sorted(machines, key=lambda x: x.address[6])

machinesT = []

for i in range(len(machines)):
    machinesT += [machines[i]] * int(math.ceil(len(allDistricts) * ((len(machines) - i)/float(len(machines))) * random.random()))

print "Vamos às vendas!"
totalSales = 0
for i in range(sellingPeriod.days + 1):
    if i % DiasEntreRemessas == 0:
        cursor = db.cursor()
        cursor.callproc('sp_stock_cleaning', [str(fstSell + timedelta(days=i)).decode('utf-8').encode("latin-1")])
        cursor.close()

        for m in machines:
            for p in products:
                rs = Remessas((fstSell + timedelta(days=i)), m, p)
                rs.insertInDB(db)

    for j in range(int(random.normalvariate(AVGVendasDia, DesvioVendasDia))):
        v = Vendas((fstSell + timedelta(days=i)), users, machines, products)
        v.insertInDB(db)
        totalSales = totalSales + 1
    print "Dia " + str(i) + " de " + str(sellingPeriod.days + 1)

print "Criadas " + str(totalSales) + " vendas"

db.close()