use bivm;

SET SQL_SAFE_UPDATES = 0;

-- select * from bivm.auditProduto;
-- select * from bivm.auditUtilizador;
-- select * from bivm.auditMaquina;

delete from auditProduto;
alter table auditProduto auto_increment = 1;

delete from auditUtilizador;
alter table auditUtilizador auto_increment = 1;

delete from auditMaquina;
alter table auditMaquina auto_increment = 1;
