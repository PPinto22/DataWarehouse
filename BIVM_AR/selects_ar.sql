select * from bivm_ar.etl;

select * from bivm_ar.predimproduto;
select * from bivm_ar.predimmaquina;
select * from bivm_ar.predimutilizador;
select * from bivm_ar.predimlocal;
select * from bivm_ar.prefactvendas;

select * from bivm_ar.updateproduto;
select * from bivm_ar.updatemaquina;
select * from bivm_ar.updateutilizador;

select * from bivm_ar.dimproduto;
select * from bivm_ar.dimutilizador;
select * from bivm_ar.dimmaquina;
select * from bivm_ar.dimdata;
select * from bivm_ar.dimlocal;

select count(*) from bivm_ar.factvendas;

select * from bivm_ar.ltproduto;
select * from bivm_ar.ltmaquina;
select * from bivm_ar.ltutilizador;
select * from bivm_ar.ltlocal;

select * from bivm_ar.quarproduto;
select * from bivm_ar.quarmaquina;
select * from bivm_ar.quarutilizador;
select * from bivm_ar.quarlocal;
select * from bivm_ar.quarfactvendas;

select * from bivm.auditproduto;
select * from bivm.auditutilizador;
select * from bivm.auditmaquina;

select TF.precoV, TF.precoA, TF.lucro, TF.Validade, D.dia, U.email as utilizador, TF.maquina, P.nome as produto, P.pais, 
		TF.idade, TF.hora, TF.periodo
	FROM bivm_ar.factvendas as TF
    INNER JOIN bivm_ar.dimData as D ON TF.data = D.id
    INNER JOIN bivm_ar.dimutilizador as U on TF.utilizador = U.id
    INNER JOIN bivm_ar.dimproduto as P on TF.produto = P.id;