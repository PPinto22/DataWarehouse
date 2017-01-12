USE `bivm` ;

SET SQL_SAFE_UPDATES = 0;

INSERT INTO Morada
  (Cod_Postal, Freguesia, Rua, Porta, Pais, Cidade, Distrito)
  VALUES
  ('4710-057', 'Campus de Gualtar', 'Campus de Gualtar', null, 'Portugal', 'Braga', 'Braga'),
  ('4715-086', 'São José de São Lázaro', ' Rua Álvaro Carneiro', null, 'Portugal', 'Braga', 'Braga'),
  ('4810-525', 'São Paio', 'Avenida de São Gonçalo', null, 'Portugal', 'Guimarães', 'Braga'),
  ('4835-044', 'Creixomil', 'R. dos Cutileiros', null, 'Portugal', 'Guimarães', 'Braga'),
  ('4800-058', 'Campus de Azurem', 'Campus de Azurem', null, 'Portugal', 'Guimarães', 'Braga');

INSERT INTO Maquina
  (Descriçao, Modelo, Renda, Capacidade, Morada)
  VALUES
  ('CP1 no segundo piso','A', '200', '300', 1),
  ('CP3 no primeito piso','A', '150', '250', 1),
  ('Nave','B', '350', '400', 5),
  ('Entrada da escola','B', '250', '150', 2),
  ('Ala Norte','A1', '500', '450', 3),
  ('Ala Sul','B2', '500', '450', 3),
  ('Entrada do Hospital','C', '300', '250', 4);
  

INSERT INTO Produto
  (Nome, PrecoA, PrecoV)
  VALUES
  ('Lanche','0.5', '0.8'),
  ('Bolacha Maria','0.2','0.4'),
  ('Bolacha Chocolate','0.7','1'),
  ('Croissant','0.3','0.5'),
  ('Kinder Bueno','0.4','0.7'),
  ('Kit Kat','0.3','0.55'),
  ('Ice Tea','0.5','0.8'),
  ('Agua','0.1','0.6'),
  ('Coca Cola','0.5','0.8');
  
INSERT INTO Remessa
  (Validade, Quantidade, Maquina, Produto)
  VALUES
  ('2016-12-01','15','1','1'),
  ('2016-11-30','15','2','1'),
  ('2016-12-02','5','1','4'),
  ('2016-12-10','9','2','5'),
  ('2017-12-20','20','2','8'),
  ('2017-01-02','40','5','9'),
  ('2017-01-05','40','6','2'),
  ('2016-01-05','20','4','5'),
  ('2016-01-05','10','7','6'),
  ('2016-01-07','20','3','7'),
  ('2016-01-10','10','3','4'),
  ('2016-01-13','10','4','3'),
  ('2016-01-15','20','7','1'),
  ('2016-01-25','20','6','4'),
  ('2016-01-06','20','5','1');
  

INSERT INTO Utilizador
  (Email, Password, Saldo, Nome, Profissao, Genero, Data_nascimento)
  VALUES
  ('joaocosta@gmail.com','1234','10','João Costa','Sapateiro','M','1964-07-10'),
  ('joanaabreu@gmail.com','2345','15','Joana Abreu','Comerciante','F','1978-09-20'),
  ('andrepereira@hotmail.com','3456','30','Andre Pereira','Engenheiro Informatico','M','1988-01-27'),
  ('josegomes@hotmail.com','4567','30','José Gomes','Medico','M','1953-08-08'),
  ('albertofreitas@iol.pt','5678','30','Alberto Freitas','Medico','M','1966-04-27'),
  ('afonsomarques@iol.pt','6789','20','Afonso Marques','Enfermeiro','M','1973-06-15'),
  ('beatrizaarao@gmail.com','7890','10','Beatriz Aarão','Estudante','F','1995-10-07'),
  ('pedropinto@gmail.com','8901','10','Pedro Pinto','Estudante','M','1995-09-22'),
  ('andreiabarros@gmail.com','4321','10','Andreia Barros','Estudante','F','1995-10-01'),
  ('joaofernandes@gmail.com','5432','10','João Fernandes','Estudante','M','1995-04-10'),
  ('armandocosta@hotmail.com','6543','30','Armando Costa','Professor','M','1970-06-07'),
  ('marianaabreu@hotmail.com','7654','20','Mariana Abreu','Enfermeira','F','1984-03-09'),
  ('duartealves@hotmail.com','8765','20','Duarte Alves','Secretario','M','1982-02-28'),
  ('martimcardoso@gmail.com','9876','30','Martim Cardoso','Professor','M','1976-12-24'),
  ('diogomartins@hotmail.com','0987','5','Diogo Martins','Estudante','M','2000-11-06');
  
  

  
INSERT INTO Venda
  (Data, PrecoV, PrecoA, Utilizador, Remessa, Maquina)
  VALUES
  ('2016-11-28','0.8','0.5',9,1,1),#lanche
  ('2016-11-26','0.8','0.5',7,2,2),#lanche
  ('2016-11-30','0.6','0.5',8,2,2),#lanche promocao(ultimo dia validade)
  ('2016-11-29','0.5','0.3',10,3,1),#croissant
  ('2016-01-20','0.6','0.1',7,2,5),#agua
  ('2016-12-03','0.8','0.5',1,6,5),#cola
  ('2016-12-17','0.4','0.2',2,7,6),#maria
  ('2016-01-03','0.7','0.4',15,8,4),#kinder
  ('2015-12-30','0.55','0.3',4,9,7),#kit kat
  ('2015-12-15','0.8','0.5',11,10,3),#ice tea
  ('2016-01-05','0.5','0.3',14,11,3),#croissant
  ('2016-01-09','1','0.7',15,12,3),#bolachaChocolate
  ('2016-01-12','0.8','0.5',12,13,7),#lanche
  ('2016-01-20','0.5','0.3',13,14,6),#croissant
  ('2016-01-02','0.8','0.5',3,15,5),#lanche
  ('2016-01-01','0.55','0.3',5,9,7),#kitkat
  ('2016-12-03','0.8','0.5',6,6,5),#cola
  ('2016-01-24','0.4','0.3',10,14,6),#croissant promocao
  ('2016-01-15','0.6','0.5',3,13,7),#lanche promoçao
  ('2016-01-06','0.8','0.5',11,10,3);#icetea





SET SQL_SAFE_UPDATES = 1;
