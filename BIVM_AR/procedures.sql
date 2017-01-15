use bivm_ar;

-- TESTES
-- select * from quarproduto;
-- select * from dimproduto;
-- select * from histproduto;
-- select * from ltproduto;
-- call sp_update_produto(1,1,'Lanche','Espanha',0.5,0.8,now());

drop procedure if exists sp_insert_produto;
DELIMITER $$
create procedure sp_insert_produto(in in_source int, in in_source_id int, 
	in in_nome VARCHAR(75), in in_pais VARCHAR(45), in in_precoA decimal(6,2), in in_precoV decimal(6,2))
BEGIN
	IF EXISTS( SELECT id FROM dimproduto WHERE nome = in_nome and pais = in_pais) THEN
		INSERT INTO quarproduto  (source,source_id,nome,pais,precoV,precoA,descricao,op) values
			(in_source,in_source_id,in_nome,in_pais,in_precoV,in_precoA,"Registo repetido",'I');
	ELSE 
		INSERT INTO dimproduto (nome,pais,precoA,precoV) values
			(in_nome,in_pais,in_precoA,in_precoV);
    END IF;
END $$
DELIMITER ;

drop procedure if exists sp_update_produto;
DELIMITER $$
create procedure sp_update_produto(in in_source int, in in_source_id int, 
	in in_nome VARCHAR(75), in in_pais VARCHAR(45), in in_precoA decimal(6,2), in in_precoV decimal(6,2),
    in in_data_update datetime)
BEGIN
START TRANSACTION;
	set @id = (select id FROM ltproduto WHERE source = in_source and source_id = in_source_id);
	IF @id is not null THEN
		INSERT INTO histproduto 
			(id,nome_anterior,pais_anterior,precoV_anterior,precoA_anterior,
			nome,pais,precoV,precoA,data_update)
			SELECT @id,Dim.nome,Dim.pais,Dim.precoV,Dim.precoA,
					in_nome,in_pais,in_precoV,in_precoA,in_data_update
			FROM dimproduto as Dim WHERE id = @id;
		UPDATE dimproduto SET
				nome = in_nome,
				pais = in_pais,
				precoA = in_precoA,
				precoV = in_precoV
			WHERE id = @id;
	ELSE 
		INSERT INTO quarproduto  (source,source_id,nome,pais,precoV,precoA,descricao,op) value
			(in_source,in_source_id,in_nome,in_pais,in_precoV,in_precoA,"Registo nao existente",'U');
    END IF;
COMMIT;
END $$
DELIMITER ;

-- Testes
-- select * from quarutilizador;
-- select * from ltutilizador;
-- select * from dimutilizador;
-- select * from histutilizador;
-- call sp_insert_utilizador(5,1,'andreiabarross@gmail.com','nome','profissao','genero',curdate()); -- data_nascimento
-- call sp_update_utilizador(1,1,'joaocosta@gmail.com','João Costa','Sapateiro','Masculino','1964-07-10',now());
-- delete from dimutilizador where email = 'andreiabarross@gmail.com';

drop procedure if exists sp_insert_utilizador;
DELIMITER $$
create procedure sp_insert_utilizador(in in_source int, in in_source_id int, in in_email VARCHAR(75),
		in in_nome VARCHAR(75), in in_profissao varchar(45), in in_genero varchar(45), in in_data_nascimento date)
BEGIN
	IF EXISTS( SELECT id FROM dimutilizador WHERE email = in_email) THEN
		INSERT INTO quarutilizador  (source,source_id,email,nome,profissao,genero,data_nascimento,descricao,op) values
			(in_source,in_source_id,in_email,in_nome,in_profissao,in_genero,in_data_nascimento,"Registo repetido",'I');
	ELSE 
		INSERT INTO dimutilizador (email,nome,profissao,genero,data_nascimento) values
			(in_email,in_nome,in_profissao,in_genero,in_data_nascimento);
    END IF;
END $$
DELIMITER ;

drop procedure if exists sp_update_utilizador;
DELIMITER $$
create procedure sp_update_utilizador(in in_source int, in in_source_id int, 
	in in_email varchar(75), in in_nome VARCHAR(75), in in_profissao varchar(45),
    in in_genero varchar(45), in in_data_nascimento date, in in_data_update datetime)
BEGIN
START TRANSACTION;
	set @id = (select id FROM ltutilizador WHERE source = in_source and source_id = in_source_id);
	IF @id is not null THEN
		INSERT INTO histutilizador 
			(id,email_anterior,nome_anterior,profissao_anterior,genero_anterior,data_nascimento_anterior,
            email,nome,profissao,genero,data_nascimento,data_update)
			SELECT @id,Dim.email,Dim.nome,Dim.profissao,Dim.genero,Dim.data_nascimento,
					in_email,in_nome,in_profissao,in_genero,in_data_nascimento,in_data_update
			FROM dimutilizador as Dim WHERE id = @id;
		UPDATE dimutilizador SET
				email = in_email,
				nome = in_nome,
				profissao = in_profissao,
                genero = in_genero,
                data_nascimento = in_data_nascimento
			WHERE id = @id;
	ELSE 
		INSERT INTO quarutilizador  (source,source_id,email,nome,profissao,genero,data_nascimento,descricao,op) value
			(in_source,in_source_id,in_email,in_nome,in_profissao,in_genero,in_data_nascimento,
			"Registo nao existente",'U');
    END IF;
COMMIT;
END $$
DELIMITER ;

-- Testes
-- 

-- select * from dimmaquina;
-- select * from quarmaquina;
-- select * from ltmaquina;
-- select * from histmaquina;
-- delete from dimmaquina where modelo = 'modelo';
-- call sp_insert_maquina(5,5,'modelo',100,50,'cod','freg','rua','cid','dis','pais');
-- call sp_update_maquina(10,314,'A',3150.0,300,'4710-057','Campus de Gualtar','Campus de Gualtar','Braga','Braga','Alemanha',now());
-- call sp_update_maquina(1,1,'A',3150.0,300,'4710-057','Campus de Gualtar','Campus de Gualtar','Braga','Braga','Alemanha',now());
-- call sp_update_maquina(1,1,'A',3150.0,300,'4710-057','Campus de Gualtar','Campus de Gualtar','Braga','Braga','Portugal',now());

drop procedure if exists sp_update_maquina;
DELIMITER $$
create procedure sp_update_maquina(in in_source int, in in_source_id int, in in_modelo VARCHAR(75),
		in in_renda decimal(6,2), in in_capacidade int, in in_cod_postal varchar(10),
        in in_freguesia varchar(75), in in_rua varchar(75), in in_cidade varchar(45),
        in in_distrito varchar(45), in in_pais varchar(45), in in_data_update datetime)
BEGIN
START TRANSACTION;
	set @id = (select id FROM ltmaquina WHERE source = in_source and source_id = in_source_id);
	IF @id is not null THEN
		INSERT INTO histmaquina 
			(id,renda_anterior,capacidade_anterior,cod_postal_anterior,freguesia_anterior,rua_anterior,
             cidade_anterior,distrito_anterior,pais_anterior,
             renda,capacidade,cod_postal,freguesia,rua,cidade,distrito,pais,data_update)
			SELECT @id,Dim.renda,Dim.capacidade,Dim.cod_postal,Dim.freguesia,Dim.rua,Dim.cidade,Dim.distrito,Dim.pais,
            in_renda,in_capacidade,in_cod_postal,in_freguesia,in_rua,in_cidade,in_distrito,in_pais,in_data_update
			FROM dimmaquina as Dim WHERE id = @id;
		UPDATE dimmaquina SET
				renda = in_renda,
                capacidade = in_capacidade,
                cod_postal = in_cod_postal,
                freguesia = in_freguesia,
                rua = in_rua,
                cidade = in_cidade,
                distrito = in_distrito,
                pais = in_pais
			WHERE id = @id;
	ELSE 
		INSERT INTO quarmaquina  (source,source_id,renda,capacidade,cod_postal,freguesia,rua,cidade,distrito,pais,descricao,op) value
			(in_source,in_source_id,in_renda,in_capacidade,in_cod_postal,in_freguesia,in_rua,in_cidade,in_distrito,in_pais,
			"Registo nao existente",'U');
    END IF;
COMMIT;
END $$
DELIMITER ;

drop procedure if exists sp_insert_maquina;
DELIMITER $$
create procedure sp_insert_maquina(in in_source int, in in_source_id int, in in_modelo VARCHAR(75),
		in in_renda decimal(6,2), in in_capacidade int, in in_cod_postal varchar(10),
        in in_freguesia varchar(75), in in_rua varchar(75), in in_cidade varchar(45),
        in in_distrito varchar(45), in in_pais varchar(45))
BEGIN
	IF EXISTS( SELECT id FROM ltmaquina WHERE source = in_source and source_id = in_source_id) THEN
		INSERT INTO quarmaquina  (source,source_id,modelo,renda,capacidade,cod_postal,freguesia,rua,
								  cidade,distrito,pais,descricao,op) values
			(in_source,in_source_id,in_modelo,in_renda,in_capacidade,in_cod_postal,in_freguesia,in_rua,
			 in_cidade,in_distrito,in_pais,"Registo repetido",'I');
	ELSE
		START TRANSACTION;
        INSERT INTO LTMaquina (source,source_id) values (in_source,in_source_id);
        set @id = (select id from ltmaquina where source = in_source and source_id = in_source_id);
		INSERT INTO dimMaquina (id,modelo,renda,capacidade,cod_postal,freguesia,rua,cidade,distrito,pais) values
			(@id,in_modelo,in_renda,in_capacidade,in_cod_postal,in_freguesia,in_rua,in_cidade,in_distrito,in_pais);
        COMMIT;
    END IF;
END $$
DELIMITER ;