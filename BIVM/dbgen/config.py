# -*- coding: UTF-8 -*-
from datetime import datetime

malePopulation = 0.45

NUtilizadores = 591
NMaquinas = 25
AVGVendasDia = NMaquinas * 20
DesvioVendasDia = AVGVendasDia/4
DiasEntreRemessas = 2

initialBalance = [9000] * 10 + [8000] * 6

jobs = ["Jardineiro"] * 10 + ["Electricista"] * 6 + ["Advogado"] * 7 + ["Estudante"] * 30 + ["Médico"] * 4 + ["Engenheiro"] * 10 + ["Dentista"] * 1 + ["Padeiro"] * 1 + ["Fotógrafo"] * 1 + ["Assistente Social"] * 3 + ["Cabeleireiro"] * 2 + ["Bombeiro"] * 3 + ["Lenhador"] * 1

# Nome, precoA, precoV, dias de validade, 
produtos = [('Lanche',           '0.5',  '0.8',  7  )] * 10 +\
           [('Bolacha Maria',    '0.2',  '0.4',  365)] * 1  +\
           [('Bolacha Chocolate','0.7',  '1',    90 )] * 15 +\
           [('Croissant',        '0.4',  '0.8',  7  )] * 8  +\
           [('Kinder Bueno',     '0.4',  '0.7',  365)] * 4  +\
           [('Kit Kat',          '0.3',  '0.55', 365)] * 3  +\
           [('Ice Tea',          '0.5',  '0.8',  90 )] * 12 +\
           [('Agua',             '0.1',  '0.6',  365)] * 3  +\
           [('Coca Cola',        '0.5',  '0.8',  365)] * 1


NProdutos = len(set(produtos))

# fstSell = datetime.strptime('2012-04-30', "%Y-%m-%d").date()
fstSell = datetime.strptime('2014-01-01', "%Y-%m-%d").date()
lstBuy = datetime.strptime('2017-01-01', "%Y-%m-%d").date()
sellingPeriod = lstBuy - fstSell

lstBornDate = datetime.strptime('1999-04-30', "%Y-%m-%d").date()
fstBornDate = datetime.strptime('1932-04-30', "%Y-%m-%d").date()
bornPeriod = lstBornDate - fstBornDate

male = ["Joaquim", "Júlio", "Artur", "João", "Miguel", "Leonardo", "José", "Carlos", "Alexandre", "Bernardo", "Daniel", "Eduardo", "Fernando", "Gabriel", "Hugo", "Ivo", "Luís", "Manuel", "Nuno", "Otávio", "Pedro", "Xavier", "Rui"]

female = ["Andreia", "Ana", "Filipa", "Beatriz", "Carolina", "Daniela", "Eduarda", "Fátima", "Gabriela", "Helena", "Ivone", "Joana", "Luísa", "Manuela", "Natália", "Patrícia", "Rita", "Sandra", "Vânia"]

surname = ["Abreu", "Aarão", "Alves", "Barros", "Campos", "Delgado", "Esteves", "Fernandes", "Gomes", "Henriques", "Infante", "Jesus", "Lima", "Lobo", "Machado", "Nestor", "Novais", "Nogueira", "Oliveira", "Pinto", "Pontes", "Pereira", "Rebelo", "Silva", "Raminhos", "Sá", "Rua", "Torres", "Teixeira", "Veiga", "Viana", "Vidal", "Xisto"]

sCharsReplacement = [("ã", "a"), ("â", "a"), ("á", "a"), ("é", "e"), ("ê", "e"), ("í", "i"), ("ó", "o"), ("ú", "u"), ("ç", "c")]

mailserver = ["gmail.com", "hotmail.com", "sapo.pt", "iol.pt", "outlook.com", "live.com.pt", "yahoo.com"]

machineModel = [("Cortex A", 18), ("Makita Serie 45", 23), ("StormKey", 16)]
machineRent = ["100", "200", "300", "250"]

adresses = [
            ('4760-480','Travessa Dom Nuno Álvares Pereira','Braga','Vila Nova de Famalicão','Esmeriz'),
            ('4705-509','Rua Nova da Naia','Braga','Braga','Morreira'),
            ('4750-079','Rua das Irmãs Franciscanas Missionárias de Maria','Braga','Barcelos','Barcelos'),
            ('4705-086','Rua Cidade do Porto','Braga','Braga','Braga'),
            ('4730-260','Rua Padre António José de Araújo','Braga','Vila Verde','Lanhas'),
            ('4720-119','Rua do Rio Homem','Braga','Amares','Rendufe'),
            ('4450-038','Rua Álvaro Castelões','Porto','Matosinhos','Matosinhos'),
            ('4600-752','Travessa dos Moínhos','Porto','Amarante','Telões'),
            ('4575-218','Avenida Doutor Carvalho Mendes','Porto','Penafiel','Eja'),
            ('4580-177','Rua Nova Torre da Madureira','Porto','Paredes','Beire'),
            ('4300-342','Rua Monte da Estação','Porto','Porto','Porto'),
            ('4000-382','Rua de Passos Manuel','Porto','Porto','Porto'),
            ('4580-747','Rua da Almuinha','Porto','Paredes','Sobrosa'),
            ('3850-451','Rua Várzea','Aveiro','Albergaria-a-Velha','Angeja'),
            ('3865-018','Rua das Cavadas Sul','Aveiro','Estarreja','Canelas'),
            ('3810-157','Rua da República','Aveiro','Aveiro','Aveiro'),
            ('3510-927','Rua dos Cruzeiros','Viseu','Viseu','Viseu'),
            ('5100-114','Rua Arribada','Viseu','Lamego','Lamego'),
            ('3505-265','Bairro Familiar','Viseu','Viseu','Carragoso'),
            ('3505-563','Rua da Lapa','Viseu','Viseu','Viseu'),
            ('5400-195','Travessa Cavaleiro','Vila Real','Chaves','Santa Maria Maior'),
            ('4880-127','Rua do Calvário','Vila Real','Mondim de Basto','Ermelo'),
            ('5070-017','Travessa da Lameira','Vila Real','Alijó','Alijó'),
            ('5030-101','Rua de Aveleira','Vila Real','Santa Marta de Penaguião','Fontes'),
            ('5430-492','Rua Cidade de Bruxelas','Vila Real','Valpaços','Valpaços'),

           ]