use bivm_ar;

-- Testes
-- select * from factvendas;
-- select * from quarfactvendas;
-- call sp_insert_venda(1,1.0,0.5,0.5,'2000-01-01','01:00:00',1,4,1,100,22);


drop procedure if exists sp_insert_venda;
DELIMITER $$
create procedure sp_insert_venda(in in_source int, in in_precoV decimal(6,2), in in_precoA decimal(6,2),
	in in_lucro decimal(6,2), in in_data date, in in_hora time, in in_utilizador varchar(75),
    in in_maquina varchar(15), in in_produto varchar(45), in in_validade int, in in_idade int)
BEGIN
	set @data = (select id from dimdata where data = in_data limit 1);
    set @hora = (select id from dimhora where tempo = in_hora limit 1);
    set @utilizador = (select id from ltutilizador where source = in_source and source_id = in_utilizador);
    set @maquina = (select id from ltmaquina where source = in_source and source_id = in_maquina);
    set @produto = (select id from ltproduto where source = in_source and source_id = in_produto);
    if 
		@data is not null and
        @hora is not null and
        @utilizador is not null and
        @maquina is not null and
        @produto is not null 
	then
		INSERT INTO factVendas (precoV,precoA,lucro,data,hora,utilizador,maquina,produto,validade,idade) VALUES
			(in_precoV,in_precoA,in_lucro,@data,@hora,@utilizador,@maquina,@produto,in_validade,in_idade);
	else
		INSERT INTO quarFactVendas(source,precoV,precoA,lucro,source_data,data,source_hora,hora,
			source_utilizador,utilizador,source_maquina,maquina,source_produto,produto,validade,idade,
            quar_descricao) 
		VALUES
			(in_source,in_precoV,in_precoA,in_lucro,in_data,@data,in_hora,@hora,
             in_utilizador,@utilizador,in_maquina,@maquina,in_produto,@produto,in_validade,in_idade,
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

-- Testes
-- select * from dimmaquina;
-- select * from quarmaquina;
-- select * from ltmaquina;
-- select * from updateMaquina;
-- call sp_insert_maquina(5,5,'modelo',100,50,'cod','freg','rua','cid','dis','pais');
-- call sp_insert_maquina(5,6,'modelo',100,50,'cod','freg','rua','cid','dis','pais');
-- call sp_update_maquina(5,5,'A',3150.0,300,'4710-057','Campus de Gualtar','Campus de Gualtar','Braga','Braga','Portugal',now());
-- call sp_update_maquina(10,314,'A',3150.0,300,'4710-057','Campus de Gualtar','Campus de Gualtar','Braga','Braga','Alemanha',now());
-- call sp_update_maquina(1,1,'A',3150.0,300,'4710-057','Campus de Gualtar','Campus de Gualtar','Braga','Braga','Alemanha',now());

drop procedure if exists sp_insert_maquina;
DELIMITER $$
create procedure sp_insert_maquina(in in_source int, in in_source_id varchar(15), in in_modelo VARCHAR(75),
		in in_renda decimal(6,2), in in_capacidade int, in in_cod_postal varchar(10),
        in in_freguesia varchar(75), in in_rua varchar(75), in in_cidade varchar(45),
        in in_distrito varchar(45), in in_pais varchar(45))
BEGIN
	SET @id = ( SELECT id FROM ltmaquina WHERE source = in_source and source_id = in_source_id);
    if @id is not null then
		INSERT INTO quarmaquina  (source,source_id,renda,capacidade,cod_postal,freguesia,rua,cidade,distrito,pais,descricao,op) value
			(in_source,in_source_id,in_renda,in_capacidade,in_cod_postal,in_freguesia,in_rua,in_cidade,in_distrito,in_pais,
			"Chave repetida",'U');
	else
		START TRANSACTION;
		INSERT INTO LTMaquina (source,source_id) values
			(in_source,in_source_id);
		set @id = ( SELECT id FROM LTMaquina WHERE source = in_source and source_id = in_source_id);
		INSERT INTO dimmaquina (id,modelo,renda,capacidade,cod_postal,freguesia,rua,cidade,distrito,pais) values
			(@id,in_modelo,in_renda,in_capacidade,in_cod_postal,in_freguesia,in_rua,in_cidade,in_distrito,in_pais);
		COMMIT;
    END IF;
END $$
DELIMITER ;

drop procedure if exists sp_update_maquina;
DELIMITER $$
create procedure sp_update_maquina(in in_source int, in in_source_id varchar(15), in in_modelo VARCHAR(75),
		in in_renda decimal(6,2), in in_capacidade int, in in_cod_postal varchar(10),
        in in_freguesia varchar(75), in in_rua varchar(75), in in_cidade varchar(45),
        in in_distrito varchar(45), in in_pais varchar(45), in in_data_update datetime)
BEGIN
START TRANSACTION;
	set @id = (select id FROM ltmaquina WHERE source = in_source and source_id = in_source_id);
	IF @id is not null THEN
		INSERT INTO updateMaquina (maquina,modelo,renda,capacidade,cod_postal,freguesia,rua,cidade,distrito,pais,data_update) values
			(@id,in_modelo,in_renda,in_capacidade,in_cod_postal,in_freguesia,in_rua,in_cidade,in_distrito,in_pais,in_data_update);
	ELSE 
		INSERT INTO quarmaquina  (source,source_id,modelo,renda,capacidade,cod_postal,freguesia,rua,cidade,distrito,pais,descricao,op) value
			(in_source,in_source_id,in_modelo,in_renda,in_capacidade,in_cod_postal,in_freguesia,in_rua,in_cidade,in_distrito,in_pais,
			"Update sobre uma maquina nao existente",'U');
    END IF;
COMMIT;
END $$
DELIMITER ;