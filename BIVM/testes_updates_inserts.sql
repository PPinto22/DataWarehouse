delete from bivm.auditproduto;
delete from bivm.auditutilizador;
delete from bivm.auditmaquina;
select * from bivm.morada;
select * from bivm.maquina;
select * from bivm.produto;
-- Insert/Update
insert into bivm.produto (id,Nome,PrecoV,PrecoA) values
(20,'lanCHe',1.0,2.0),(21,'LANCHE',3.14,3.14);
insert into bivm.utilizador (id,email,password,saldo,nome,profissao,genero,data_nascimento) values
	(50,'joaocosta@gmail.com',4567,30.00,'Jose Gomes','Medico','M',Date(now()));
insert into bivm.utilizador (id,email,password,saldo,nome,profissao,genero,data_nascimento) values
	(51,'novoutilizador@gmail.com',4567,30.00,'Jose Gomes','Medico','M',Date(now()));
insert into bivm.utilizador (id,email,password,saldo,nome,profissao,genero,data_nascimento) values
	(21,'gmail.com',4567,30.00,'Jose Gomes','Medico','M',Date(now()));
insert into bivm.utilizador (id,email,password,saldo,nome,profissao,genero,data_nascimento) values
	(20,'joaocosta@gmail.com',4567,30.00,'Jose Gomes','Medico','M',Date(now()));
insert into bivm.maquina (id,descriçao,modelo,renda,capacidade,morada) values
	(20,'maquina 20...','A',100,300,5);
update bivm.utilizador set profissao = "Sapateiro2" 
	where profissao = "Sapateiro";    
update bivm.maquina set capacidade = "31415" 
	where capacidade = "150";
update bivm.morada set cod_postal = '000000' 
	where id = 2;
update bivm.morada set pais = 'Franca' 
	where pais = 'Portugal';
update bivm.maquina set renda = 3141.92 where id = 1;
update bivm.produto set precoV = 3.0 where id = 1;

INSERT INTO bivm.Venda
  (Data, PrecoV, PrecoA, Utilizador, Remessa, Maquina)
  VALUES
  ('2017-01-20 13:00:00','0.8','0.5',21,1,1),
  ('2017-01-21 21:30:00','0.8','0.5',8,2,2);

-- Delete/Revert
delete from bivm.Venda where data in ('2017-01-20 13:00:00','2017-01-21 21:30:00');

delete from bivm.utilizador where id in(20,21);
delete from bivm.produto where id in (20,21);
update bivm.morada set pais = 'Portugal' 
	where pais = 'Franca';
update bivm.morada set cod_postal = '4715-086'
	where id = 2;
update bivm.maquina set modelo = "A" 
	where modelo = "ABC"; 
update bivm.utilizador set profissao = "Sapateiro" 
	where profissao = "Sapateiro2";
delete from bivm.maquina where id in (20);
update bivm.maquina set capacidade = "150" 
	where capacidade = "31415";
update bivm.maquina set renda = 200.00 where id = 1;
delete from bivm.utilizador where id in (50,51);
update bivm.produto set precoV = 0.8 where id = 1;