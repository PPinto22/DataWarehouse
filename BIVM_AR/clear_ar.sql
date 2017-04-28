use bivm_ar;

SET SQL_SAFE_UPDATES = 0;

delete from dimdata;
ALTER TABLE dimdata AUTO_INCREMENT = 1;

delete from dimproduto;
delete from dimmaquina;
delete from dimutilizador;
delete from dimlocal;

delete from prefactvendas;
delete from factvendas;

delete from predimproduto;
delete from predimutilizador;
delete from predimmaquina;
delete from predimlocal;

delete from ltmaquina;
ALTER TABLE ltmaquina AUTO_INCREMENT = 1;
delete from ltproduto;
ALTER TABLE ltproduto AUTO_INCREMENT = 1;
delete from ltutilizador;
ALTER TABLE ltutilizador AUTO_INCREMENT = 1;
delete from ltlocal;
ALTER TABLE ltlocal AUTO_INCREMENT = 1;

delete from quarproduto;
ALTER TABLE quarproduto AUTO_INCREMENT = 1;
delete from quarutilizador;
ALTER TABLE quarutilizador AUTO_INCREMENT = 1;
delete from quarmaquina;
ALTER TABLE quarmaquina AUTO_INCREMENT = 1;
delete from quarlocal;
ALTER TABLE quarlocal AUTO_INCREMENT = 1;
delete from quarfactvendas;
ALTER TABLE quarfactvendas AUTO_INCREMENT = 1;

delete from updateProduto;
ALTER TABLE updateProduto AUTO_INCREMENT = 1;
delete from updateUtilizador;
ALTER TABLE updateUtilizador AUTO_INCREMENT = 1;
delete from updateMaquina;
ALTER TABLE updateMaquina AUTO_INCREMENT = 1;
delete from updateLocal;
ALTER TABLE updateLocal AUTO_INCREMENT = 1;

delete from etl;
insert into etl values(null);