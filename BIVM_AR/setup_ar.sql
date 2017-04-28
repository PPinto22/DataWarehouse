-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema BIVM_AR
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema BIVM_AR
-- -----------------------------------------------------
drop schema if exists BIVM_AR;
CREATE SCHEMA IF NOT EXISTS `BIVM_AR` DEFAULT CHARACTER SET utf8 ;
USE `BIVM_AR` ;

-- -----------------------------------------------------
-- Table `BIVM_AR`.`DimData`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BIVM_AR`.`DimData` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dia` DATE NOT NULL,
  `mes` VARCHAR(20) NOT NULL,
  `ano` INT NOT NULL,
  `dia_semana` VARCHAR(10) NOT NULL,
  `fim_de_semana` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BIVM_AR`.`DimUtilizador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BIVM_AR`.`DimUtilizador` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(75) NOT NULL,
  `nome` VARCHAR(75) NOT NULL,
  `profissao` VARCHAR(45) NOT NULL,
  `genero` VARCHAR(45) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BIVM_AR`.`DimMaquina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BIVM_AR`.`DimMaquina` (
  `id` INT NOT NULL,
  `modelo` VARCHAR(75) NOT NULL,
  `renda` DECIMAL(6,2) NOT NULL,
  `capacidade` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BIVM_AR`.`DimProduto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BIVM_AR`.`DimProduto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(75) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `precoA` DECIMAL(6,2) NOT NULL,
  `precoV` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BIVM_AR`.`DimLocal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BIVM_AR`.`DimLocal` (
  `id` INT NOT NULL,
  `cod_postal` VARCHAR(10) NOT NULL,
  `freguesia` VARCHAR(75) NOT NULL,
  `rua` VARCHAR(75) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `distrito` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BIVM_AR`.`FactVendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BIVM_AR`.`FactVendas` (
  `precoV` DECIMAL(6,2) NOT NULL,
  `precoA` DECIMAL(6,2) NOT NULL,
  `lucro` DECIMAL(6,2) NOT NULL,
  `validade` INT NOT NULL,
  `data` INT NOT NULL,
  `utilizador` INT NOT NULL,
  `maquina` INT NOT NULL,
  `local` INT NOT NULL,
  `produto` INT NOT NULL,
  `hora` INT NOT NULL,
  `periodo` VARCHAR(45) NOT NULL,
  `idade` INT NOT NULL,
  INDEX `_idx` (`data` ASC),
  INDEX `utilizador_idx` (`utilizador` ASC),
  INDEX `maquina_idx` (`maquina` ASC),
  INDEX `produto_idx` (`produto` ASC),
  INDEX `local_idx` (`local` ASC),
  CONSTRAINT `data`
    FOREIGN KEY (`data`)
    REFERENCES `BIVM_AR`.`DimData` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `utilizador`
    FOREIGN KEY (`utilizador`)
    REFERENCES `BIVM_AR`.`DimUtilizador` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `maquina`
    FOREIGN KEY (`maquina`)
    REFERENCES `BIVM_AR`.`DimMaquina` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `produto`
    FOREIGN KEY (`produto`)
    REFERENCES `BIVM_AR`.`DimProduto` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `local`
    FOREIGN KEY (`local`)
    REFERENCES `BIVM_AR`.`DimLocal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;










-- MAIS TABELAS --
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
CALL PROC_DROP_FOREIGN_KEY('factvendas', 'local');
CALL PROC_DROP_FOREIGN_KEY('factvendas', 'data');


drop table if exists etl;
create table etl (
    last_load DATETIME
);
insert into etl value(null);

drop table if exists predimproduto;
create table preDimProduto (
    source int,
    source_id varchar(45),
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
    source_id varchar(75),
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

drop table if exists preDimLocal;
create table preDimLocal (
	source int,
    source_id varchar(10),
    cod_postal varchar(10),
    freguesia varchar(75),
    rua varchar(75),
    cidade varchar(45),
    distrito varchar(45),
    pais varchar(45),
	data_update datetime default null,
    op char(1) default 'I'
);

drop table if exists LTlocal;
create table LTlocal (
	id int not null auto_increment,
	source int not null,
    source_id varchar(10) not null,
    cod_postal varchar(10),
    primary key (id,source,source_id)
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
	validade int,
    source_data date,
    data int,
    source_utilizador varchar(75),
    utilizador int,
    source_maquina varchar(15),
    maquina int,
    source_produto varchar(45),
    local int,
    produto int,
    idade int,
    hora int,
    periodo varchar(45),
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
    descricao varchar(150),
    op char(1),
    data datetime default now()
);

drop table if exists QuarLocal;
create table QuarLocal(
	quar_id int primary key auto_increment,
    source int,
    source_id varchar(10),
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
    validade int,
	idade int,
    data Date,
    hora int,
    periodo varchar(45),
    utilizador varchar(75),
    maquina varchar(15),
    local varchar(10),
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
    data_update datetime
);

drop table if exists updateLocal;
create table updateLocal (
	id int primary key auto_increment,
    local int,
    cod_postal varchar(10),
    freguesia varchar(75),
    rua varchar(75),
    cidade varchar(45),
    distrito varchar(45),
    pais varchar(45),
    data_update datetime
);






-- Procedimentos e triggers --
use bivm_ar;


drop trigger if exists tg_periodo;
delimiter $$
create trigger tg_periodo 
	before insert on prefactvendas 
    for each row
BEGIN
	if new.hora >= 0 and new.hora <= 5 then
			set new.periodo = 'Madrugada';
	else
		if new.hora >= 6 and new.hora <= 13 then
			set new.periodo = 'Manha';
		else
			if new.hora >= 13 and new.hora <= 20 then
				set new.periodo = 'Tarde';
			else
				set new.periodo = 'Noite';
			end if;
		end if;
	end if;
END$$
DELIMITER ;


drop procedure if exists sp_insert_venda;
DELIMITER $$
create procedure sp_insert_venda(in in_source int, in in_precoV decimal(6,2), in in_precoA decimal(6,2),
	in in_lucro decimal(6,2), in in_validade int, in in_data date, in in_utilizador varchar(75),
    in in_maquina varchar(15), in in_local varchar(10), in in_produto varchar(45), in in_hora int, in in_periodo varchar(45), in in_idade int)
BEGIN
	set @data = (select id from dimdata where dia = in_data limit 1);
    set @utilizador = (select id from ltutilizador where source = in_source and source_id = in_utilizador);
    set @maquina = (select id from ltmaquina where source = in_source and source_id = in_maquina);
    set @local = (select id from ltlocal where source = in_source and source_id = in_local limit 1);
    set @produto = (select id from ltproduto where source = in_source and source_id = in_produto);
    if 
		@data is not null and
        @utilizador is not null and
        @maquina is not null and
        @local is not null and
        @produto is not null 
	then
		INSERT INTO factVendas (precoV,precoA,lucro,validade,data,utilizador,maquina,local,produto,hora,periodo,idade) VALUES
			(in_precoV,in_precoA,in_lucro,in_validade,@data,@utilizador,@maquina,@local,@produto,in_hora,in_periodo,in_idade);
	else
		INSERT INTO quarFactVendas(source,precoV,precoA,lucro,validade,source_data,data,
			source_utilizador,utilizador,source_maquina,maquina,local,source_produto,produto,idade,
            hora,periodo,quar_descricao) 
		VALUES
			(in_source,in_precoV,in_precoA,in_lucro,in_validade,in_data,@data,
             in_utilizador,@utilizador,in_maquina,@maquina,@local,in_produto,@produto,in_idade,in_hora,in_periodo,
             'Dimensoes nao existentes');
	END IF;
END $$
DELIMITER ;

-- TESTES
-- select * from quarProduto;
-- select * from updateProduto;
-- select * from dimproduto;
-- select * from ltproduto;
-- call sp_insert_produto(1,3,'Lanche','Portugal',0.5,0.8);
-- call sp_update_produto(1,3,'PRODUTO_NAO_EXISTENTE','Portugal',0.8,0.8,now());
-- call sp_update_produto(1,'ID_NAO_EXISTENTE','Lanche','Portugal',0.8,0.8,now());

drop procedure if exists sp_insert_produto;
DELIMITER $$
create procedure sp_insert_produto(in in_source int, in in_source_id varchar(75), 
	in in_nome VARCHAR(75), in in_pais VARCHAR(45), in in_precoA decimal(6,2), in in_precoV decimal(6,2))
BEGIN
	set @id = ( SELECT id FROM ltproduto WHERE source = in_source and source_id = in_source_id);
    if @id is not null then
		INSERT INTO quarproduto  (source,source_id,nome,pais,precoV,precoA,descricao,op) values
			(in_source,in_source_id,in_nome,in_pais,in_precoV,in_precoA,"Chave repetida",'I');
	else
		set @id = ( SELECT id FROM ltproduto WHERE nome = in_nome and pais = in_pais limit 1);
		IF @id is not null THEN
			START TRANSACTION;
            INSERT INTO LTProduto (id,source,source_id,nome,pais) values
				(@id,in_source,in_source_id,in_nome,in_pais);
			INSERT INTO quarproduto  (source,source_id,nome,pais,precoV,precoA,descricao,op) values
				(in_source,in_source_id,in_nome,in_pais,in_precoV,in_precoA,
					"Produto repetido. Inserido novo mapeamento em LTProduto",'I');
			COMMIT;
		ELSE 
			START TRANSACTION;
			INSERT INTO LTProduto (source,source_id,nome,pais) values
				(in_source,in_source_id,in_nome,in_pais);
			set @id = ( SELECT id FROM ltproduto WHERE source = in_source and source_id = in_source_id);
			INSERT INTO dimproduto (id,nome,pais,precoA,precoV) values
				(@id,in_nome,in_pais,in_precoA,in_precoV);
			COMMIT;
		END IF;
	end if;
END $$
DELIMITER ;

drop procedure if exists sp_update_produto;
DELIMITER $$
create procedure sp_update_produto(in in_source int, in in_source_id varchar(75), 
	in in_nome VARCHAR(75), in in_pais VARCHAR(45), in in_precoA decimal(6,2), in in_precoV decimal(6,2),
    in in_data_update datetime)
BEGIN
	set @id = (select id FROM ltproduto 
		WHERE source = in_source and source_id = in_source_id and nome = in_nome and pais = in_pais);
	IF @id is not null THEN
		INSERT INTO updateProduto (produto,precoV,precoA,data_update) values
			(@id,in_precoV,in_precoA,in_data_update);
	ELSE 
		INSERT INTO quarproduto  (source,source_id,nome,pais,precoV,precoA,descricao,op) value
			(in_source,in_source_id,in_nome,in_pais,in_precoV,in_precoA,"Update sobre um produto nao existente",'U');
    END IF;
END $$
DELIMITER ;

-- Testes
-- select * from updateUtilizador;
-- select * from quarUtilizador;
-- select * from ltUtilizador;
-- select * from dimUtilizador;
-- call sp_insert_utilizador(5,'andreiabarross@gmail.com','andreiabarross@gmail.com','nome','profissao','genero',curdate()); -- data_nascimento
-- call sp_update_utilizador(5,1,'andreiabarross@gmail.com','nome','profissao','genero',curdate(),now()); -- data_nascimento
-- call sp_update_utilizador(5,1,'joaocosta@gmail.com','João Costa','Sapateiro','Masculino','1964-07-10',now());
-- delete from dimutilizador where email = 'andreiabarross@gmail.com';

drop procedure if exists sp_insert_utilizador;
DELIMITER $$
create procedure sp_insert_utilizador(in in_source int, in in_source_id varchar(75), in in_email VARCHAR(75),
		in in_nome VARCHAR(75), in in_profissao varchar(45), in in_genero varchar(45), in in_data_nascimento date)
BEGIN
	SET @id = ( SELECT id FROM ltutilizador WHERE source = in_source and source_id = in_source_id);
    if @id is not null then
		INSERT INTO quarutilizador  (source,source_id,email,nome,profissao,genero,data_nascimento,descricao,op) values
			(in_source,in_source_id,in_email,in_nome,in_profissao,in_genero,in_data_nascimento,"Chave repetida",'I');
	else
		set @id = ( SELECT id FROM ltutilizador WHERE email = in_email limit 1);
        if @id is not null then
			START TRANSACTION;
            INSERT INTO LTUtilizador (id,source,source_id,email) values
				(@id,in_source,in_source_id,in_email);
			INSERT INTO quarutilizador  (source,source_id,email,nome,profissao,genero,data_nascimento,descricao,op) values
				(in_source,in_source_id,in_email,in_nome,in_profissao,in_genero,in_data_nascimento,
				 "Utilizador repetido. Inserido novo mapeamento em LTUtilizador",'I');
			COMMIT;
        ELSE 
			START TRANSACTION;
			INSERT INTO LTUtilizador (source,source_id,email) values
				(in_source,in_source_id,in_email);
			set @id = ( SELECT id FROM ltUtilizador WHERE source = in_source and source_id = in_source_id);
			INSERT INTO dimutilizador (id,email,nome,profissao,genero,data_nascimento) values
				(@id,in_email,in_nome,in_profissao,in_genero,in_data_nascimento);
			COMMIT;
		END IF;
    END IF;
END $$
DELIMITER ;

drop procedure if exists sp_update_utilizador;
DELIMITER $$
create procedure sp_update_utilizador(in in_source int, in in_source_id varchar(75), 
	in in_email varchar(75), in in_nome VARCHAR(75), in in_profissao varchar(45),
    in in_genero varchar(45), in in_data_nascimento date, in in_data_update datetime)
BEGIN
	set @id = (select id FROM ltutilizador 
		WHERE source = in_source and source_id = in_source_id and email = in_email);
	IF @id is not null THEN
		INSERT INTO updateUtilizador (utilizador,nome,profissao,data_nascimento,genero,data_update) values
			(@id,in_nome,in_profissao,in_data_nascimento,in_genero,in_data_update);
	ELSE 
		INSERT INTO quarutilizador  (source,source_id,email,nome,profissao,genero,data_nascimento,descricao,op) values
				(in_source,in_source_id,in_email,in_nome,in_profissao,in_genero,in_data_nascimento,
				 "Update sobre um utilizador nao existente",'U');
    END IF;
END $$
DELIMITER ;


drop procedure if exists sp_update_maquina;
DELIMITER $$
create procedure sp_update_maquina(in in_source int, in in_source_id varchar(15), in in_modelo VARCHAR(75),
		in in_renda decimal(6,2), in in_capacidade int, in in_data_update datetime)
BEGIN
START TRANSACTION;
	set @id = (select id FROM ltmaquina WHERE source = in_source and source_id = in_source_id);
	IF @id is not null THEN
		INSERT INTO updateMaquina (maquina,modelo,renda,capacidade,data_update) values
			(@id,in_modelo,in_renda,in_capacidade,in_data_update);
	ELSE 
		INSERT INTO quarmaquina  (source,source_id,modelo,renda,capacidade,descricao,op) value
			(in_source,in_source_id,in_modelo,in_renda,in_capacidade,"Update sobre uma maquina nao existente",'U');
    END IF;
COMMIT;
END $$
DELIMITER ;



drop procedure if exists sp_insert_maquina;
DELIMITER $$
create procedure sp_insert_maquina(in in_source int, in in_source_id varchar(15), in in_modelo VARCHAR(75),
		in in_renda decimal(6,2), in in_capacidade int)
BEGIN
	SET @id = ( SELECT id FROM ltmaquina WHERE source = in_source and source_id = in_source_id);
    if @id is not null then
		INSERT INTO quarmaquina  (source,source_id,renda,capacidade,descricao,op) value
			(in_source,in_source_id,in_renda,in_capacidade,"Chave repetida",'I');
	else
		START TRANSACTION;
		INSERT INTO LTMaquina (source,source_id) values
			(in_source,in_source_id);
		set @id = ( SELECT id FROM LTMaquina WHERE source = in_source and source_id = in_source_id);
		INSERT INTO dimmaquina (id,modelo,renda,capacidade) values
			(@id,in_modelo,in_renda,in_capacidade);
		COMMIT;
    END IF;
END $$
DELIMITER ;




drop procedure if exists sp_update_local;
DELIMITER $$
create procedure sp_update_local(in in_source int, in in_source_id varchar(10), in in_cod_postal varchar(10), in in_freguesia VARCHAR(75),
		in in_rua varchar(75),in in_cidade varchar(45), in in_distrito varchar(45), in in_pais varchar(45), in in_data_update datetime)
BEGIN
	set @id = (select id FROM LTLocal 
		WHERE source = in_source and source_id = in_source_id and cod_postal = in_cod_postal);
	IF @id is not null THEN
		INSERT INTO updateLocal (local,cod_postal,freguesia,rua,cidade,distrito,pais,data_update) values
			(@id,in_cod_postal,in_freguesia,in_rua,in_cidade,in_distrito,in_pais,in_data_update);
	ELSE 
		INSERT INTO QuarLocal  (source,cod_postal,freguesia,rua,cidade,distrito,pais,descricao,op) values
				(in_source,in_cod_postal,in_freguesia,in_rua,in_cidade,in_distrito,in_pais,"Update sobre um local nao existente",'U');
    END IF;
END $$
DELIMITER ;


drop procedure if exists sp_insert_local;
DELIMITER $$
create procedure sp_insert_local(in in_source int, in in_source_id varchar(10), in in_cod_postal varchar(10), in in_freguesia VARCHAR(75),
		in in_rua varchar(75),in in_cidade varchar(45), in in_distrito varchar(45), in in_pais varchar(45))
BEGIN
	SET @id = ( SELECT id FROM LTLocal WHERE source = in_source and source_id = in_source_id);
    if @id is not null then
		INSERT INTO quarLocal  (source,cod_postal,freguesia,rua,cidade,distrito,pais,descricao,op) value
			(in_source,in_cod_postal,in_freguesia,in_rua,in_cidade,in_distrito,in_pais,
			"Local repetido",'I');
	else
		set @id = ( SELECT id FROM LTLocal WHERE cod_postal = in_cod_postal limit 1);
        if @id is not null then
			START TRANSACTION;
            INSERT INTO LTLocal (id,source,source_id,cod_postal) values
				(@id,in_source,in_source_id,in_cod_postal);
			INSERT INTO QuarLocal  (source,cod_postal,freguesia,rua,cidade,distrito,pais,descricao,op) values
				(in_source,in_cod_postal,in_freguesia,in_rua,in_cidade,in_distrito,in_pais,
				 "Local repetido. Inserido novo mapeamento em LTLocal",'I');
			COMMIT;
        ELSE 
			START TRANSACTION;
			INSERT INTO LTLocal (source,source_id,cod_postal) values
				(in_source,in_source_id,in_cod_postal);
			set @id = ( SELECT id FROM LTLocal WHERE source = in_source and in_source_id = source_id);
			INSERT INTO dimLocal (id,cod_postal,freguesia,rua,cidade,distrito,pais) values
					(@id,in_cod_postal,in_freguesia,in_rua,in_cidade,in_distrito,in_pais);
			COMMIT;
		END IF;
    END IF;
END $$
DELIMITER ;


