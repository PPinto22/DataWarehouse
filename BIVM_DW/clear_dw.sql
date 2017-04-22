use bivm_dw;

SET SQL_SAFE_UPDATES = 0;

delete from histproduto;
ALTER TABLE histproduto AUTO_INCREMENT = 1;
delete from histmaquina;
ALTER TABLE histmaquina AUTO_INCREMENT = 1;

delete from dimproduto;
delete from dimmaquina;
delete from dimutilizador;

delete from dimdata;

delete from factvendas;

delete from etl;
insert into etl values(null);