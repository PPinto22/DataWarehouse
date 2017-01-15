use bivm_dw;

SET SQL_SAFE_UPDATES = 0;

delete from dimdata;
delete from dimhora;

delete from dimproduto;
delete from dimmaquina;
delete from dimutilizador;

delete from factvendas;

delete from histproduto;
ALTER TABLE histproduto AUTO_INCREMENT = 1;
delete from histutilizador;
ALTER TABLE histutilizador AUTO_INCREMENT = 1;
delete from histmaquina;
ALTER TABLE histmaquina AUTO_INCREMENT = 1;

delete from etl;
insert into etl values(null);