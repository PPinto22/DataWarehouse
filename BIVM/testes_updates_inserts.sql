SET SQL_SAFE_UPDATES = 0;

delete from bivm.auditproduto;
delete from bivm.auditutilizador;
delete from bivm.auditmaquina;
select * from bivm.morada;
select * from bivm.maquina;
select * from bivm.produto;

-- Insert/Update
insert into bivm.produto (id,Nome,PrecoV,PrecoA) values
(20,'lanCHe',1.0,0.5);
insert into bivm.produto (id,Nome,PrecoV,PrecoA) values
(21,'Pastilhas Trident',0.7,0.4);
insert into bivm.utilizador (id,email,password,saldo,nome,profissao,genero,data_nascimento) values
	(50,'joaocosta@gmail.com',4567,30.00,'Jose Gomes','Medico','M',Date(now()));
insert into bivm.utilizador (id,email,password,saldo,nome,profissao,genero,data_nascimento) values
	(51,'novoutilizador@gmail.com',4567,30.00,'Andre Fernandes','Engenheiro','M',Date(now()));
insert into bivm.utilizador (id,email,password,saldo,nome,profissao,genero,data_nascimento) values
	(21,'gmail.com',4567,30.00,'Jose Gomes','Medico','M',Date(now()));
insert into bivm.maquina (id,descriçao,modelo,renda,capacidade,morada) values
	(20,'maquina 20...','A',100,300,5);
update bivm.utilizador set profissao = "Dentista" 
	where id = 1;   
update bivm.morada set cod_postal = '000000' 
	where id = 2;

update bivm.maquina set renda = 300.00 where id = 1;
select sleep(1);
update bivm.maquina set renda = 350.00 where id = 1;
select sleep(1);
update bivm.maquina set morada = 3 where id = 1;

select * from bivm.auditmaquina;

update bivm.produto set precoV = 1.2, precoA=0.4 where id = 1;
select sleep(1);
update bivm.produto set precoV = 1.5, precoA=0.6 where id = 1;
select sleep(1);
update bivm.produto set precoV = 1.3, precoA=0.3 where id = 1;

INSERT INTO bivm.Venda
  (Data, PrecoV, PrecoA, Utilizador, Remessa, Maquina)
  VALUES
  ('2017-02-20 13:00:00','0.8','0.5',21,1,1),
  ('2017-02-21 21:30:00','0.8','0.5',8,2,2);

-- Delete/Revert
delete from bivm.Venda where data in ('2017-02-20 13:00:00','2017-02-21 21:30:00');

delete from bivm.utilizador where id in(20,21,50,51);
delete from bivm.produto where id in (20,21);
delete from bivm.maquina where id in (20);

update bivm.morada set cod_postal = '4715-086'
	where id = 2;
update bivm.utilizador set profissao = "Sapateiro" 
	where id = 1;

update bivm.maquina set renda = 200.00, morada = 1 where id = 1;
update bivm.produto set precoV = 0.8, precoA=0.3 where id = 1;