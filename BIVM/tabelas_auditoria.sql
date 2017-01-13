use bivm;

drop table if exists auditProduto;
create table auditProduto (
	id int not null primary key auto_increment,
	id_produto int not null,
    Nome varchar(75) not null,
    PrecoA decimal(6,2) not null,
    PrecoV decimal(6,2) not null,
    DataOp DateTime not null default now(),
    Op char(1) not null
);

drop table if exists auditUtilizador;
create table auditUtilizador (
	id int not null primary key auto_increment,
	id_utilizador int not null,
    Email varchar(75) not null,
    Nome varchar(75) not null,
    Profissao varchar(45) not null,
    Genero char(1) not null,
    Data_nascimento date not null,    
    DataOp DateTime not null default now(),
    Op char(1) not null
);

drop table if exists auditMaquina;
create table auditMaquina (
	id int not null primary key auto_increment,
	id_maquina int not null,
    Modelo varchar(75) not null,
    Renda decimal(6,2) not null,
    Capacidade int not null,
    Cod_Postal varchar(10) not null,
    Freguesia varchar(75) not null,
    Rua varchar(75) not null,
    Cidade varchar(30) not null,
    Distrito varchar(30) not null,
    Pais varchar(30) not null,
    DataOp DateTime not null default now(),
    Op char(1) not null
);

drop trigger if exists tg_insert_auditProduto;
DELIMITER $$
create trigger tg_insert_auditProduto 
	after insert on produto 
    for each row
BEGIN
    insert into auditproduto (id_produto,nome,precoA,precoV,op) values
		(new.id,new.nome,new.precoA,new.precoV,'I');
        
END$$
DELIMITER ;

drop trigger if exists tg_update_auditProduto;
DELIMITER $$
create trigger tg_update_auditProduto
	after update on produto 
    for each row
BEGIN
	insert into auditproduto (id_produto,nome,precoA,precoV,op) values
		(new.id,new.nome,new.precoA,new.precoV,'I');
END$$
DELIMITER ;


drop trigger if exists tg_insert_auditUtilizador;
DELIMITER $$
create trigger tg_insert_auditUtilizador 
	after insert on utilizador 
    for each row
BEGIN
    insert into auditutilizador (id_utilizador,email,nome,profissao,genero,data_nascimento,op) values
		(new.id,new.email,new.nome,new.profissao,new.genero,new.data_nascimento,'I');
END$$
DELIMITER ;

drop trigger if exists tg_insert_auditMaquina;
DELIMITER $$
create trigger tg_insert_auditMaquina 
	after insert on maquina 
    for each row
BEGIN
    insert into auditmaquina (id_maquina,modelo,renda,capacidade,cod_postal,freguesia,rua,cidade,distrito,pais,op) 
		select new.id, new.modelo, new.renda, new.capacidade, cod_postal, freguesia, rua, cidade, distrito, pais, 'I' 
			from Morada where new.morada = Morada.id;
END$$
DELIMITER ;

drop trigger if exists tg_update_auditUtilizador;
DELIMITER $$
create trigger tg_update_auditUtilizador 
	after update on utilizador 
    for each row
BEGIN
    IF 
        new.email <> old.email OR
        new.nome <> old.nome OR
        new.profissao <> old.profissao OR
        new.genero <> old.genero OR
        new.data_nascimento <> old.data_nascimento 
	THEN
		insert into auditutilizador (id_utilizador,email,nome,profissao,genero,data_nascimento,op) values
			(new.id,new.email,new.nome,new.profissao,new.genero,new.data_nascimento,'U');
	END IF;
END$$
DELIMITER ;

drop trigger if exists tg_update_auditMaquina;
DELIMITER $$
create trigger tg_update_auditMaquina
	after update on maquina 
    for each row
BEGIN
    IF 
        new.modelo <> old.modelo OR
        new.renda <> old.renda OR
        new.capacidade <> old.capacidade OR
        new.morada <> old.morada
	THEN
		insert into auditmaquina (id_maquina,modelo,renda,capacidade,cod_postal,freguesia,rua,cidade,distrito,pais,op) 
			select new.id, new.modelo, new.renda, new.capacidade, cod_postal, freguesia, rua, cidade, distrito, pais, 'U' 
				from Morada where new.morada = Morada.id;
	END IF;
END$$
DELIMITER ;

drop trigger if exists tg_update_auditMaquina_Morada;
DELIMITER $$
create trigger tg_update_auditMaquina_Morada
	after update on morada 
    for each row
BEGIN
	insert into auditmaquina (id_maquina,modelo,renda,capacidade,cod_postal,freguesia,rua,cidade,distrito,pais,op) 
		select M.id, M.modelo, M.renda, M.capacidade, new.cod_postal, new.freguesia, new.rua, new.cidade, new.distrito, new.pais, 'U' 
			from Maquina as M where M.morada = new.id;
END$$
DELIMITER ;



