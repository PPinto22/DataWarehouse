use bivm_dw;

drop table if exists etl;
create table etl (
    last_load DATETIME
);
insert into etl value(null);

-- TESTES
-- select * from dimproduto;
-- select * from histproduto;
-- call sp_update_produto(1,0.2,0.8,now());
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
		FROM dimproduto as Dim WHERE id = in_id;
	UPDATE dimproduto SET
			precoA = in_precoA,
			precoV = in_precoV
		WHERE id = in_id;
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

drop procedure if exists sp_update_utilizador;
DELIMITER $$
create procedure sp_update_utilizador(in in_source int, in in_source_id int, 
	in in_email varchar(75), in in_nome VARCHAR(75), in in_profissao varchar(45),
    in in_genero varchar(45), in in_data_nascimento date, in in_data_update datetime)
BEGIN
START TRANSACTION;
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
COMMIT;
END $$
DELIMITER ;

-- Testes
-- 
-- select * from dimmaquina;
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
COMMIT;
END $$
DELIMITER ;