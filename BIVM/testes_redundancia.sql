insert into bivm.produto (id,Nome,PrecoV,PrecoA) values
(20,'lanCHe',1.0,2.0),(21,'LANCHE',3.14,3.14);

delete from bivm.produto where id in (20,21);

select * from bivm.produto;

select * from bivm.utilizador;

insert into bivm.utilizador (id,email,password,saldo,nome,profissao,genero,data_nascimento) values
	(21,'gmail.com',4567,30.00,'Jose Gomes','Medico','M',Date(now()));

delete from bivm.utilizador where id in(21);

insert into bivm.utilizador (id,email,password,saldo,nome,profissao,genero,data_nascimento) values
	(20,'joaocosta@gmail.com',4567,30.00,'Jose Gomes','Medico','M',Date(now()));
    
delete from bivm.utilizador where id in (20);

insert into bivm.maquina (id,descriçao,modelo,renda,capacidade,morada) values
	(20,'maquina 20...','A',100,300,5);
    
delete from bivm.maquina where id in (20);

update bivm.utilizador set profissao = "Sapateiro2" 
	where profissao = "Sapateiro";
    
update bivm.utilizador set profissao = "Sapateiro" 
	where profissao = "Sapateiro2";
    
update bivm.maquina set modelo = "ABC" 
	where modelo = "A";
    
update bivm.maquina set modelo = "A" 
	where modelo = "ABC"; 

select * from bivm.morada;
update bivm.morada set cod_postal = '000000' 
	where id = 1;
update bivm.morada set cod_postal = '4710-057'
	where id = 1;

update bivm.morada set pais = 'Franca' 
	where pais = 'Portugal';
    
update bivm.morada set pais = 'Portugal' 
	where pais = 'Franca';
    