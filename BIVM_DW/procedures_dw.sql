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
	-- Altera historia apenas se algum dos outros atributos excepto capacidade ou modelo mudaram
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