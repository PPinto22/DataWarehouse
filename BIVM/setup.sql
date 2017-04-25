-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

SET SQL_SAFE_UPDATES = 0;

-- -----------------------------------------------------
-- Schema BIVM
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema BIVM
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BIVM` DEFAULT CHARACTER SET utf8 ;
USE `BIVM` ;

-- -----------------------------------------------------
-- Table `BIVM`.`Morada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BIVM`.`Morada` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Cod_Postal` VARCHAR(10) NOT NULL,
  `Freguesia` VARCHAR(75) NOT NULL,
  `Rua` VARCHAR(75) NOT NULL,
  `Porta` INT NULL,
  `Pais` VARCHAR(30) NOT NULL,
  `Cidade` VARCHAR(30) NOT NULL,
  `Distrito` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BIVM`.`Utilizador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BIVM`.`Utilizador` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Email` VARCHAR(75) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Saldo` DECIMAL(6,2) NOT NULL,
  `Nome` VARCHAR(75) NOT NULL,
  `Profissao` VARCHAR(45) NOT NULL,
  `Genero` CHAR NOT NULL,
  `Data_nascimento` DATE NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BIVM`.`Maquina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BIVM`.`Maquina` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Descriçao` VARCHAR(500) NOT NULL,
  `Modelo` VARCHAR(75) NOT NULL,
  `Renda` DECIMAL(6,2) NOT NULL,
  `Capacidade` INT NOT NULL,
  `Morada` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Maquina_Morada1_idx` (`Morada` ASC),
  CONSTRAINT `fk_Maquina_Morada1`
    FOREIGN KEY (`Morada`)
    REFERENCES `BIVM`.`Morada` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BIVM`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BIVM`.`Produto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(75) NOT NULL,
  `PrecoV` DECIMAL(6,2) NOT NULL,
  `PrecoA` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BIVM`.`Remessa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BIVM`.`Remessa` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Validade` DATE NOT NULL,
  `Quantidade` INT NOT NULL,
  `Maquina` INT NOT NULL,
  `Produto` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Remessa_Maquina_idx` (`Maquina` ASC),
  INDEX `fk_Remessa_Produto1_idx` (`Produto` ASC),
  CONSTRAINT `fk_Remessa_Maquina`
    FOREIGN KEY (`Maquina`)
    REFERENCES `BIVM`.`Maquina` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Remessa_Produto1`
    FOREIGN KEY (`Produto`)
    REFERENCES `BIVM`.`Produto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BIVM`.`Venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BIVM`.`Venda` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Data` DATETIME NOT NULL,
  `PrecoV` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
  `PrecoA` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
  `Utilizador` INT NOT NULL,
  `Remessa` INT NOT NULL,
  `Maquina` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `Utilizador_idx` (`Utilizador` ASC),
  INDEX `Remessa_idx` (`Remessa` ASC),
  INDEX `Maquina_idx` (`Maquina` ASC),
  CONSTRAINT `Utilizador`
    FOREIGN KEY (`Utilizador`)
    REFERENCES `BIVM`.`Utilizador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Remessa`
    FOREIGN KEY (`Remessa`)
    REFERENCES `BIVM`.`Remessa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Maquina`
    FOREIGN KEY (`Maquina`)
    REFERENCES `BIVM`.`Maquina` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;






-- Tabelas de auditoria 
use bivm;

-- select * from bivm.auditProduto;
-- select * from bivm.auditMaquina;
-- select * from bivm.auditUtilizador;

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
    IF 
        new.precoA <> old.precoA OR
        new.precoV <> old.precoV
	THEN
		insert into auditproduto (id_produto,nome,precoA,precoV,op) values
			(new.id,new.nome,new.precoA,new.precoV,'U');
	END IF;
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



-- Procedimentos
drop procedure if exists sp_stock_cleaning;
delimiter $$
create procedure sp_stock_cleaning(in currentDate date)
begin

update remessa
  set Quantidade = 0
    where Quantidade > 0 and currentDate > Validade;
    
END $$
delimiter ;


drop procedure if exists sp_venda;
delimiter $$
create procedure sp_venda(in sellDate datetime, in maquina int, in utilizador int, in produto int)
begin

SET @remessa = (select id FROM Remessa as R
                WHERE R.Produto = produto and R.Maquina = maquina and R.Quantidade > 0
                ORDER BY R.Validade
                LIMIT 1);

IF (@remessa IS NULL) THEN
  signal sqlstate '45000' SET MESSAGE_TEXT = "Não há stock";  
END IF;

IF ((select Validade from Remessa as R where R.id = @remessa) < sellDate) THEN
  signal sqlstate '45000' SET MESSAGE_TEXT = "Produto fora de validade";  
END IF;

IF ((select Saldo from Utilizador as U where U.id = utilizador) < 
(select precoV from Produto where id = produto)) then
  signal sqlstate '45000' SET MESSAGE_TEXT = "Saldo insuficiente";
END IF;

start transaction;

set @precoV = (select precoV FROM Produto 
               WHERE id = produto );

set @precoA = (select precoA FROM Produto 
               WHERE id = produto );

INSERT INTO Venda (Data, PrecoV, PrecoA, Maquina, Utilizador, Remessa) value 
  (sellDate, @precoV, @precoA, maquina, utilizador,@remessa);

UPDATE Remessa as R
SET Quantidade = Quantidade - 1
WHERE
    R.id = @remessa;
  
UPDATE Utilizador as U
SET 
    Saldo = Saldo - @precoV
WHERE
    U.id = utilizador;

commit;

END $$
delimiter ;

