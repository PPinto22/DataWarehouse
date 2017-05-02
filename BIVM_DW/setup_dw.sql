DROP DATABASE IF EXISTS BIVM_DW;  

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema BIVM_DW
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema BIVM_DW
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BIVM_DW` DEFAULT CHARACTER SET utf8 ;
USE `BIVM_DW` ;

-- -----------------------------------------------------
-- Table `BIVM_DW`.`DimData`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BIVM_DW`.`DimData` (
  `id` INT NOT NULL,
  `dia` DATE NOT NULL,
  `mes` VARCHAR(20) NOT NULL,
  `ano` INT NOT NULL,
  `dia_semana` VARCHAR(10) NOT NULL,
  `fim_de_semana` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BIVM_DW`.`DimUtilizador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BIVM_DW`.`DimUtilizador` (
  `id` INT NOT NULL,
  `email` VARCHAR(75) NOT NULL,
  `nome` VARCHAR(75) NOT NULL,
  `profissao` VARCHAR(45) NOT NULL,
  `genero` VARCHAR(45) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BIVM_DW`.`DimMaquina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BIVM_DW`.`DimMaquina` (
  `id` INT NOT NULL,
  `modelo` VARCHAR(75) NOT NULL,
  `renda` DECIMAL(6,2) NOT NULL,
  `capacidade` INT NOT NULL,
  `cod_postal` VARCHAR(10) NOT NULL,
  `freguesia` VARCHAR(75) NOT NULL,
  `rua` VARCHAR(75) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `distrito` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BIVM_DW`.`DimProduto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BIVM_DW`.`DimProduto` (
  `id` INT NOT NULL,
  `nome` VARCHAR(75) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `precoA` DECIMAL(6,2) NOT NULL,
  `precoV` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BIVM_DW`.`FactVendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BIVM_DW`.`FactVendas` (
  `precoV` DECIMAL(6,2) NOT NULL,
  `precoA` DECIMAL(6,2) NOT NULL,
  `lucro` DECIMAL(6,2) NOT NULL,
  `validade` INT NOT NULL,
  `data` INT NOT NULL,
  `utilizador` INT NOT NULL,
  `maquina` INT NOT NULL,
  `produto` INT NOT NULL,
  `hora` INT NOT NULL,
  `periodo` VARCHAR(10) NOT NULL,
  `idade` INT NOT NULL,
  INDEX `_idx` (`data` ASC),
  INDEX `utilizador_idx` (`utilizador` ASC),
  INDEX `maquina_idx` (`maquina` ASC),
  INDEX `produto_idx` (`produto` ASC),
  CONSTRAINT `data`
    FOREIGN KEY (`data`)
    REFERENCES `BIVM_DW`.`DimData` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `utilizador`
    FOREIGN KEY (`utilizador`)
    REFERENCES `BIVM_DW`.`DimUtilizador` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `maquina`
    FOREIGN KEY (`maquina`)
    REFERENCES `BIVM_DW`.`DimMaquina` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `produto`
    FOREIGN KEY (`produto`)
    REFERENCES `BIVM_DW`.`DimProduto` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BIVM_DW`.`HistProduto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BIVM_DW`.`HistProduto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `produto` INT NOT NULL,
  `precoA_anterior` DECIMAL(6,2) NOT NULL,
  `precoA` DECIMAL(6,2) NOT NULL,
  `precoV_anterior` DECIMAL(6,2) NOT NULL,
  `precoV` DECIMAL(6,2) NOT NULL,
  `data_update` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_produto_idx` (`produto` ASC),
  CONSTRAINT `fk_produto`
    FOREIGN KEY (`produto`)
    REFERENCES `BIVM_DW`.`DimProduto` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BIVM_DW`.`HistMaquina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BIVM_DW`.`HistMaquina` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `maquina` INT NOT NULL,
  `renda_anterior` DECIMAL(6,2) NOT NULL,
  `renda` DECIMAL(6,2) NOT NULL,
  `cod_postal_anterior` VARCHAR(10) NOT NULL,
  `cod_postal` VARCHAR(10) NOT NULL,
  `freguesia_anterior` VARCHAR(75) NOT NULL,
  `freguesia` VARCHAR(75) NOT NULL,
  `rua_anterior` VARCHAR(45) NOT NULL,
  `rua` VARCHAR(45) NOT NULL,
  `cidade_anterior` VARCHAR(45) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `distrito_anterior` VARCHAR(45) NOT NULL,
  `distrito` VARCHAR(45) NOT NULL,
  `pais_anterior` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `data_update` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_maquina_idx` (`maquina` ASC),
  CONSTRAINT `fk_maquina`
    FOREIGN KEY (`maquina`)
    REFERENCES `BIVM_DW`.`DimMaquina` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;





-- Procedures --
use bivm_dw;

drop table if exists etl;
create table etl (
    last_load DATETIME
);
insert into etl value(null);

-- TESTES
-- select * from dimproduto;
-- select * from histproduto;
-- call sp_update_produto(1,0.3,0.8,now());
-- insert into dimproduto values (1,'nome','pais',0.5,1.0);

drop procedure if exists bivm_dw.sp_update_produto;
DELIMITER $$
create procedure bivm_dw.sp_update_produto(in in_id int, in in_precoA decimal(6,2), 
		in in_precoV decimal(6,2), in in_data_update datetime)
BEGIN
START TRANSACTION;
	INSERT INTO histproduto 
		(produto,precoV_anterior,precoA_anterior,precoV,precoA,data_update)
		SELECT in_id,Dim.precoV,Dim.precoA,
			   in_precoV,in_precoA,in_data_update
		FROM dimproduto as Dim WHERE id = in_id AND (
			precoV <> in_precoV OR
            precoA <> in_precoA
            );
	UPDATE dimproduto SET
			precoA = in_precoA,
			precoV = in_precoV
		WHERE id = in_id;
COMMIT;
END $$
DELIMITER ;

-- Testes
-- select * from dimutilizador;
-- insert into dimutilizador value(5,'andreiabarross@gmail.com','nome','profissao','genero',curdate()); -- data_nascimento
-- call sp_update_utilizador(5,'Andreia Barros','Sapateira','Feminino','1964-07-10');
-- delete from dimutilizador where email = 'andreiabarross@gmail.com';

drop procedure if exists sp_update_utilizador;
DELIMITER $$
create procedure sp_update_utilizador(in in_id int, in in_nome VARCHAR(75), in in_profissao varchar(45),
    in in_genero varchar(45), in in_data_nascimento date)
BEGIN
	UPDATE dimutilizador SET
			nome = in_nome,
			profissao = in_profissao,
			genero = in_genero,
			data_nascimento = in_data_nascimento
		WHERE id = in_id;
END $$
DELIMITER ;

-- Testes
-- 
-- select * from dimmaquina;
-- select * from histmaquina;
-- delete from dimmaquina;
-- insert into dimmaquina values (1,'modelo',100,50,'cod','freg','rua','cid','dis','pais');
-- call sp_update_maquina(1,'modelo2',100,500,'cod','freg','rua','cid','dis','pais',now());
-- call sp_update_maquina(1,'A',3150.0,300,'4710-057','Campus de Gualtar','Campus de Gualtar','Braga','Braga','Alemanha',now());
-- call sp_update_maquina(1,'A',3150.0,300,'4710-057','Campus de Gualtar','Campus de Gualtar','Braga','Braga','Portugal',now());

drop procedure if exists sp_update_maquina;
DELIMITER $$
create procedure sp_update_maquina(in in_id int, in in_modelo VARCHAR(75),
		in in_renda decimal(6,2), in in_capacidade int, in in_cod_postal varchar(10),
        in in_freguesia varchar(75), in in_rua varchar(75), in in_cidade varchar(45),
        in in_distrito varchar(45), in in_pais varchar(45), in in_data_update datetime)
BEGIN
START TRANSACTION;
	INSERT INTO histMaquina (maquina,renda_anterior,cod_postal_anterior,freguesia_anterior,rua_anterior,
		cidade_anterior,distrito_anterior,pais_anterior,
        renda,cod_postal,freguesia,rua,cidade,distrito,pais,data_update)
	SELECT Dim.id,Dim.renda,Dim.cod_postal,Dim.freguesia,Dim.rua,Dim.cidade,Dim.distrito,Dim.pais,
		   in_renda,in_cod_postal,in_freguesia,in_rua,in_cidade,in_distrito,in_pais,in_data_update
		FROM DimMaquina as Dim where Dim.id = in_id AND (
			renda <> in_renda OR 
            cod_postal <> in_cod_postal OR
            freguesia <> in_freguesia OR
            rua <> in_rua OR
            cidade <> in_cidade OR
            distrito <> in_distrito OR
            pais <> in_pais);
	UPDATE DimMaquina SET
			modelo = in_modelo,
			renda = in_renda,
            capacidade = in_capacidade,
			cod_postal = in_cod_postal,
			freguesia = in_freguesia,
			rua = in_rua,
			cidade = in_cidade,
			distrito = in_distrito,
			pais = in_pais
        WHERE id = in_id;
COMMIT;
END $$
DELIMITER ;

