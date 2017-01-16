use bivm_ar;

DROP PROCEDURE IF EXISTS PROC_DROP_FOREIGN_KEY;
DELIMITER $$
CREATE PROCEDURE PROC_DROP_FOREIGN_KEY(IN tableName VARCHAR(64), IN constraintName VARCHAR(64))
BEGIN
	IF EXISTS(
		SELECT * FROM information_schema.table_constraints
		WHERE 
			table_schema    = DATABASE()     AND
			table_name      = tableName      AND
			constraint_name = constraintName AND
			constraint_type = 'FOREIGN KEY')
	THEN
		SET @query = CONCAT('ALTER TABLE ', tableName, ' DROP FOREIGN KEY ', constraintName, ';');
		PREPARE stmt FROM @query; 
		EXECUTE stmt; 
		DEALLOCATE PREPARE stmt; 
	END IF; 
END$$
DELIMITER ;

CALL PROC_DROP_FOREIGN_KEY('factvendas', 'utilizador');
CALL PROC_DROP_FOREIGN_KEY('factvendas', 'produto');
CALL PROC_DROP_FOREIGN_KEY('factvendas', 'maquina');
CALL PROC_DROP_FOREIGN_KEY('factvendas', 'data');
CALL PROC_DROP_FOREIGN_KEY('factvendas', 'hora');



drop table if exists etl;
create table etl (
    last_load DATETIME
);
insert into etl value(null);

drop table if exists predimproduto;
create table preDimProduto (
    source int,
    source_id varchar(75),
    nome varchar(45),
    pais varchar(45),
    precoV decimal(6,2),
    precoA decimal(6,2),
	data_update datetime default null,
    op char(1) default 'I'
);

drop table if exists predimutilizador;
create table preDimUtilizador (
    source int,
    source_id varchar(15),
    email varchar(75),
    nome varchar(75),
    profissao varchar(45),
    genero varchar(45),
    data_nascimento date,
	data_update datetime default null,
    op char(1) default 'I'
);

drop table if exists predimmaquina;
create table preDimMaquina (
    source int,
    source_id varchar(15),
    modelo varchar(75),
    renda decimal(6,2),
    capacidade int,
    cod_postal varchar(10),
    freguesia varchar(75),
    rua varchar(75),
    cidade varchar(45),
    distrito varchar(45),
    pais varchar(45),
	data_update datetime default null,
    op char(1) default 'I'
);

drop table if exists LTmaquina;
create table LTmaquina (
    id int not null auto_increment,
    source int not null,
    source_id varchar(15) not null,
    primary key (id,source,source_id)
);

drop table if exists LTproduto;
create table LTproduto (
    id int not null auto_increment,
    source int not null,
    source_id varchar(45) not null,
    nome varchar(45) not null,
    pais varchar(45) not null,
    primary key (id,source,source_id,nome,pais)
);

drop table if exists LTutilizador;
create table LTutilizador (
    id int not null auto_increment,
    source int not null,
    source_id varchar(75) not null,
    email varchar(75) not null,
    primary key (id,source,source_id,email)
);

drop table if exists QuarFactVendas;
create table QuarFactVendas (
	quar_id int primary key auto_increment,
	source int,
    precoV decimal(6,2),
    precoA decimal(6,2),
    lucro decimal(6,2),
    source_data date,
    data int,
    source_hora time,
    hora int,
    source_utilizador varchar(75),
    utilizador int,
    source_maquina varchar(15),
    maquina int,
    source_produto varchar(45),
    produto int,
    validade int,
    idade int,
	quar_descricao varchar(150),
    quar_insercao datetime default now()
);

drop table if exists QuarProduto;
create table QuarProduto (
	quar_id int primary key auto_increment,
    source int,
    source_id varchar(75),
    nome varchar(45),
    pais varchar(45),
    precoV decimal(6,2),
    precoA decimal(6,2),
    descricao varchar(150),
	op char(1),
    data datetime default now()
);

drop table if exists QuarUtilizador;
create table QuarUtilizador (
	quar_id int primary key auto_increment,
    source int,
    source_id varchar(45),
    email varchar(75),
    nome varchar(75),
    profissao varchar(45),
    genero varchar(45),
    data_nascimento date,
    descricao varchar(150),
	op char(1),
    data datetime default now()
);

drop table if exists QuarMaquina;
create table QuarMaquina(
	quar_id int primary key auto_increment,
    source int,
    source_id varchar(15),
    modelo varchar(75),
    renda decimal(6,2),
    capacidade int,
    cod_postal varchar(10),
    freguesia varchar(75),
    rua varchar(75),
    cidade varchar(45),
    distrito varchar(45),
    pais varchar(45),
    descricao varchar(150),
    op char(1),
    data datetime default now()
);

drop table if exists preFactVendas;
create table preFactVendas (
	source int not null,
    precoV decimal(6,2),
    precoA decimal(6,2),
    lucro decimal (6,2),
    data Date,
    hora Time,
    validade int,
    idade int,
    utilizador varchar(75),
    maquina varchar(15),
    produto varchar(45)
);

drop table if exists updateProduto;
create table updateProduto (
	id int primary key auto_increment,
    produto int,
    precoV decimal(6,2),
    precoA decimal(6,2),
	data_update datetime
);

drop table if exists updateUtilizador;
create table updateUtilizador (
	id int primary key auto_increment,
    utilizador int,
    nome varchar(75),
    profissao varchar(45),
    data_nascimento date,
    genero varchar(45),
	data_update datetime
);

drop table if exists updateMaquina;
create table updateMaquina (
	id int primary key auto_increment,
    maquina int,
    modelo varchar(45),
	renda decimal(6,2),
	capacidade int,
    cod_postal varchar(10),
    freguesia varchar(75),
    rua varchar(75),
    cidade varchar(45),
    distrito varchar(45),
    pais varchar(45),
    data_update datetime
);

