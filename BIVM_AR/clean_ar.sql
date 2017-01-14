use bivm_ar;

SET SQL_SAFE_UPDATES = 0;

delete from dimdata;
ALTER TABLE dimdata AUTO_INCREMENT = 1;
delete from dimhora;
ALTER TABLE dimhora AUTO_INCREMENT = 1;

delete from dimproduto;
ALTER TABLE dimproduto AUTO_INCREMENT = 1;
delete from dimmaquina;
delete from dimutilizador;
ALTER TABLE dimutilizador AUTO_INCREMENT = 1;

delete from prefactvendas;
delete from factvendas;

delete from predimproduto;
delete from predimutilizador;
delete from predimmaquina;

delete from ltmaquina;
ALTER TABLE ltmaquina AUTO_INCREMENT = 1;
delete from ltproduto;
delete from ltutilizador;

delete from quarproduto;
delete from quarutilizador;
delete from quarmaquina;

delete from histproduto;
delete from histutilizador;
delete from histmaquina;

delete from etl;
insert into etl values(null,null);