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

# !! Programação triste !!
# É preciso fazer com que os produtos replicados no config sejam REPLICADOS
# Isto é bem capaz de ser o pedaço de código mais triste que alguma vez escrevi
# Espero, verdadeiramente, não ir para o inferno depois disto
# Tenho, no entanto, a consciência que é exactamente isso que mereço
# Rezem por mim

tmpP = []

for p in products:
    tmpP += [p] * len([i for p1 in produtos if p1[0] == p.name])

products = tmpP

# Making so that some users are more likely to buy than others
tmpU = []

for u in users:
    tmpU += [u] * int(random.normalvariate(20, 7))

users = tmpU

# Making so that some district are more likely to sell than others
allDistricts = set()

for d in adresses:
    allDistricts.add(d[2])

machines = sorted(machines, key=lambda x: x.address[6])

machinesT = []

for i in range(len(machines)):
    k = int(math.ceil(len(allDistricts) * ((len(machines) - i)/float(len(machines))) * 1))
    machinesT += [machines[i]] * k


print "Vamos às vendas!"
totalSales = 0
totalDays = sellingPeriod.days + 1

cursor = db.cursor()

for i in range(totalDays):
    
    current_date = (fstSell + timedelta(days=i))

    if i % DiasEntreRemessas == 0:
        cursor.callproc('sp_stock_cleaning', [str(current_date).decode('utf-8').encode("latin-1")])

        for m in machines:
            for p in products:
                rs = Remessas(current_date, m, p)
                rs.insertInDB(db, cursor)

    n_sales = int(random.normalvariate(AVGVendasDia, DesvioVendasDia))
    
    monthOffset = (math.sin((i % 365 - 182) * math.pi/365) + 1) / 2
    n_sales = int(n_sales/2) + int(n_sales * monthOffset)

    increasingOffset = i/float(totalDays) + 0.5
    n_sales = int(n_sales * increasingOffset)

    for j in range(n_sales):
        v = Vendas(current_date, users, machinesT, products)
        v.insertInDB(db, cursor)
        totalSales = totalSales + 1
    print "Dia " + str(i) + " de " + str(sellingPeriod.days + 1)

print "Criadas " + str(totalSales) + " vendas"

cursor.close()
db.close()