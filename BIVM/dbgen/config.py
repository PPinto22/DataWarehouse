# -*- coding: UTF-8 -*-
from datetime import datetime

malePopulation = 0.45

NUtilizadores = 100 # 10024
NMaquinas = 5 # 56
AVGVendasDia = 20 #5600
DesvioVendasDia = 5 #1200
DiasEntreRemessas = 2

initialBalance = [9000] * 10 + [8000] * 6

jobs = ["Construtor Civil"] * 10 + ["Electricista"] * 6 + ["Advogado"] * 7 + ["Estudante"] * 60 + ["Médico"] * 1 + ["Engenheiro"] * 1 + ["Dentista"] * 1 + ["Padeiro"] * 1 + ["Carteirista"] * 1 + ["Outro"] * 1

# Nome, precoA, precoV, dias de validade, 
produtos = [('Lanche',           '0.5',  '0.8',  7  )] * 10 +\
           [('Bolacha Maria',    '0.2',  '0.4',  365)] * 1  +\
           [('Bolacha Chocolate','0.7',  '1',    90 )] * 15 +\
           [('Croissant',        '0.3',  '0.5',  7  )] * 8  +\
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
            ('4250-181','Rua Doutor Cruz Malpique','Porto','Porto','Porto'),
            ('4425-512','Rua Central de Arcos','Porto','Maia','Maia'),
            ('4575-218','Avenida Doutor Carvalho Mendes','Porto','Penafiel','Eja'),
            ('4050-447','Rua Oliveira Monteiro','Porto','Porto','Porto'),
            ('4435-293','Rua João Casal','Porto','Gondomar','Rio Tinto'),
            ('4630-687','Rua do Juncal','Porto','Marco de Canaveses','Soalhães'),
            ('4049-056','Rua Joaquim António de Aguiar','Porto','Porto','Porto'),
            ('4300-342','Rua Monte da Estação','Porto','Porto','Porto'),
            ('4580-747','Rua da Almuinha','Porto','Paredes','Sobrosa'),
            ('4169-001','Rua Gonçalo Sampaio','Porto','Porto','Porto'),
            ('4595-327','Via Panorâmica','Porto','Paços de Ferreira','Eiriz'),
            ('4415-406','Avenida Jaime Isidoro','Porto','Vila Nova de Gaia','Perosinho'),
            ('4415-215','Rua dos Virtudes','Porto','Vila Nova de Gaia','Pedroso'),
            ('4590-684','Rua das Bicas','Porto','Paços de Ferreira','Raimonda'),
            ('4300-169','Rua Escolas','Porto','Porto','Porto'),
            ('4625-346','Rua do Emigrante','Porto','Marco de Canaveses','Penha Longa'),
            ('4610-547','Calçada de Melo','Porto','Felgueiras','Penacova'),
            ('4000-382','Rua de Passos Manuel','Porto','Porto','Porto'),
            ('4430-799','Rua 5 de Outubro','Porto','Vila Nova de Gaia','Avintes'),
            ('4460-833','Rua Teixeira Lopes','Porto','Matosinhos','Custóias'),
            ('4580-177','Rua Nova Torre da Madureira','Porto','Paredes','Beire'),
            ('4405-694','Rua da Presa','Porto','Vila Nova de Gaia','Vila Nova de Gaia'),
            ('4415-661','Rua da Agra','Porto','Vila Nova de Gaia','Lever'),
            ('4745-355','Rua Alto Vilares','Porto','Trofa','Muro'),
            ('4450-038','Rua Álvaro Castelões','Porto','Matosinhos','Matosinhos'),
            ('4575-018','Rua de São Sebastião','Porto','Marco de Canaveses','Alpendorada e Matos'),
            ('4440-366','Rua Dom João de Castro','Porto','Valongo','Sobrado'),
            ('4450-390','Bairro Benjamim Grandeiro','Porto','Matosinhos','Matosinhos'),
            ('4415-175','Rua do Bom Samaritano','Porto','Vila Nova de Gaia','Pedroso'),
            ('4460-366','Travessa Nova do Seixo','Porto','Matosinhos','Senhora da Hora'),
            ('4720-119','Rua do Rio Homem','Braga','Amares','Rendufe'),
            ('4710-103','Rua José Sarmento','Braga','Braga','Braga'),
            ('4704-533','Praça Doutor José Augusto Ferreira Salgado','Braga','Braga','Braga'),
            ('4715-456','Rua de Bugide','Braga','Braga','Pedralva'),
            ('4860-072','Rua da Cerâmica','Braga','Cabeceiras de Basto','Arco de Baúlhe'),
            ('4750-312','Avenida da Liberdade','Braga','Barcelos','Barcelos'),
            ('4750-086','Rua do Sobral','Braga','Barcelos','Alvito de São Pedro'),
            ('4750-379','Largo do Carvalho Santo','Braga','Barcelos','Carapeços'),
            ('4760-480','Travessa Dom Nuno Álvares Pereira','Braga','Vila Nova de Famalicão','Esmeriz'),
            ('4830-065','Rua de Calvos','Braga','Póvoa de Lanhoso','Calvos'),
            ('4705-086','Rua Cidade do Porto','Braga','Braga','Braga'),
            ('4815-396','Rua Agostinho de Lima','Braga','Vizela','Vizela'),
            ('4755-210','Rua da Capela','Braga','Barcelos','Fornelos'),
            ('4720-417','Rua Nossa Senhora da Conceição','Braga','Amares','Figueiredo'),
            ('4770-144','Rua de Viadeiros','Braga','Vila Nova de Famalicão','Cruz'),
            ('4750-704','Travessa do Machado','Braga','Barcelos','Tamel'),
            ('4750-079','Rua das Irmãs Franciscanas Missionárias de Maria','Braga','Barcelos','Barcelos'),
            ('4755-257','Rua de Medros','Braga','Barcelos','Carvalhal'),
            ('4730-260','Rua Padre António José de Araújo','Braga','Vila Verde','Lanhas'),
            ('4835-054','Rua Gil Eanes','Braga','Guimarães','Guimarães'),
            ('4805-659','Rua da Escola','Braga','Guimarães','Leitões'),
            ('4765-601','Rua D\'Abade','Braga','Vila Nova de Famalicão','Delães'),
            ('4740-275','Rua José Vieira','Braga','Esposende','Esposende'),
            ('4715-212','Rua do Nogueirense','Braga','Braga','Braga'),
            ('4750-364','Rua de Merouces','Braga','Barcelos','Campo'),
            ('4775-039','Travessa da Fonte Susa','Braga','Barcelos','Cambeses'),
            ('4810-714','Travessa Cabo de Vila','Braga','Guimarães','Abação de São Tomé'),
            ('4810-575','Rua Nossa Senhora de Fátima','Braga','Guimarães','Infantas'),
            ('4730-467','Rua 2','Braga','Vila Verde','Vila de Prado'),
            ('4705-509','Rua Nova da Naia','Braga','Braga','Morreira'),
            ('3885-616','Rua Professora Maria Joaquina Ferreira','Aveiro','Ovar','Esmoriz'),
            ('3830-230','Travessa da Filarmónica Ilhavense','Aveiro','Ílhavo','Ílhavo'),
            ('3860-028','Rua dos Anjos','Aveiro','Estarreja','Avanca'),
            ('3700-068','Avenida do Brasil','Aveiro','São João da Madeira','São João da Madeira'),
            ('3830-997','Rua Professor Francisco Corújo','Aveiro','Ílhavo','Gafanha da Encarnação'),
            ('3050-996','Rua Doutor Abel da Silva Lindo','Aveiro','Mealhada','Pampilhosa'),
            ('4500-508','Rua Calvário','Aveiro','Espinho','Espinho'),
            ('4500-748','Rua Liberdade','Aveiro','Santa Maria da Feira','Nogueira da Regedoura'),
            ('3885-296','Rua do Rio Velho','Aveiro','Ovar','Cortegaça'),
            ('3865-018','Rua das Cavadas Sul','Aveiro','Estarreja','Canelas'),
            ('4535-438','Rua António Gomes da Cruz','Aveiro','Santa Maria da Feira','Oleiros'),
            ('3800-072','Rua de Rangel Quadros','Aveiro','Aveiro','Aveiro'),
            ('3850-142','Viela Vacaria','Aveiro','Albergaria-a-Velha','Albergaria-A-Velha'),
            ('3810-027','Rua Mário Duarte','Aveiro','Aveiro','Aveiro'),
            ('3860-522','Beco dos Pescadores','Aveiro','Estarreja','Pardilhó'),
            ('3810-157','Rua da República','Aveiro','Aveiro','Aveiro'),
            ('3700-745','Rua Engenheiro Mário Hofle Araújo Moreira','Aveiro','Santa Maria da Feira','Seixal'),
            ('3700-562','Rua Teixeira de Pascoais','Aveiro','Santa Maria da Feira','Arrifana'),
            ('4525-084','Rua de Campêlo','Aveiro','Santa Maria da Feira','Campelo'),
            ('3830-556','Beco do Café Carioca','Aveiro','Ílhavo','Gafanha da Nazaré'),
            ('4520-108','Travessa Manuel Marque G.l. Resende','Aveiro','Santa Maria da Feira','Espargo'),
            ('3810-600','Beco do Cruzeiro','Aveiro','Aveiro','Verba'),
            ('3780-306','Largo dos Combatentes da Grande Guerra','Aveiro','Anadia','Anadia'),
            ('3720-352','Travessa das Águas','Aveiro','Oliveira de Azeméis','Cucujães'),
            ('3720-093','Rua do Caima','Aveiro','Oliveira de Azeméis','Macinhata da Seixa'),
            ('3850-451','Rua Várzea','Aveiro','Albergaria-a-Velha','Angeja'),
            ('3810-894','Rua de Estarreja','Aveiro','Aveiro','Aveiro'),
            ('3800-601','Rua dos Pereiras','Aveiro','Aveiro','Sarrazola'),
            ('3750-170','Urbanização do Alto do Rio','Aveiro','Águeda','Recardães'),
            ('3730-259','Rua Manuel Soares Pinheiro','Aveiro','Vale de Cambra','Vale de Cambra'),
            ('3460-586','Rua C','Viseu','Tondela','Tondela'),
            ('3510-008','Rua Nova da Balsa','Viseu','Viseu','Viseu'),
            ('3530-092','Rua Santa Catarina','Viseu','Mangualde','Mangualde'),
            ('3505-504','Quinta Alto dos Lagares','Viseu','Viseu','Viseu'),
            ('5110-673','Rua Remígio','Viseu','Armamar','Vila Seca'),
            ('5120-181','Terreiro do Visconde','Viseu','Tabuaço','Granja do Tedo'),
            ('3430-749','Rua Nossa Senhora Ribeira','Viseu','Carregal do Sal','Parada'),
            ('3505-545','Estrada da Ramalhosa','Viseu','Viseu','Viseu'),
            ('3660-463','Rua da Amizade','Viseu','São Pedro do Sul','São Pedro do Sul'),
            ('3430-059','Rua Lages','Viseu','Carregal do Sal','Carregal do Sal'),
            ('3505-490','Largo São Frutuoso','Viseu','Viseu','Viseu'),
            ('5100-114','Rua Arribada','Viseu','Lamego','Lamego'),
            ('3650-214','Rua Doutor Vasco dos Santos Teles','Viseu','Vila Nova de Paiva','Vila Nova de Paiva'),
            ('3515-374','Estrada de São Gens','Viseu','Viseu','Viseu'),
            ('3510-013','Rua do Coração de Jesus','Viseu','Viseu','Viseu'),
            ('3510-884','Avenida da Via Rápida','Viseu','Viseu','Vila Chã do Monte'),
            ('3515-650','Largo do Ferreiro','Viseu','Viseu','Travanca da Bodiosa'),
            ('3505-563','Rua da Lapa','Viseu','Viseu','Viseu'),
            ('3530-061','Rua do Adro','Viseu','Mangualde','Espinho'),
            ('3630-295','Rua do Casal','Viseu','Penedono','Penela da Beira'),
            ('3640-089','Rua do Centro Social','Viseu','Sernancelhe','Ferreirim'),
            ('3510-927','Rua dos Cruzeiros','Viseu','Viseu','Viseu'),
            ('3610-033','Rua da Ribeiro','Viseu','Tarouca','Gouviães'),
            ('3440-378','Rua Gago Coutinho','Viseu','Santa Comba Dão','Santa Comba Dão'),
            ('3510-040','Travessa Alexandre Herculano','Viseu','Viseu','Viseu'),
            ('3525-507','Beco Sacadura Botte','Viseu','Nelas','Aguieira'),
            ('3505-236','Largo 25 de Abril','Viseu','Viseu','Sanguinhedo'),
            ('3505-265','Bairro Familiar','Viseu','Viseu','Carragoso'),
            ('5130-054','Rua da Romanzeira','Viseu','São João da Pesqueira','Casais do Douro'),
            ('3525-637','Rua dos Emigrantes','Viseu','Nelas','Lapa do Lobo'),
           ]