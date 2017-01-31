select * from bivm_ar.etl;

select * from bivm_ar.predimproduto;
select * from bivm_ar.predimmaquina;
select * from bivm_ar.predimutilizador;
select * from bivm_ar.prefactvendas;

select * from bivm_ar.updateproduto;
select * from bivm_ar.updatemaquina;
select * from bivm_ar.updateutilizador;

select * from bivm_ar.dimproduto;
select * from bivm_ar.dimutilizador;
select * from bivm_ar.dimmaquina;
select * from bivm_ar.dimhora;
select * from bivm_ar.dimdata;

select * from bivm_ar.factvendas;

select * from bivm_ar.ltproduto;
select * from bivm_ar.ltmaquina;
select * from bivm_ar.ltutilizador;

select * from bivm_ar.quarproduto;
select * from bivm_ar.quarmaquina;
select * from bivm_ar.quarutilizador;
select * from bivm_ar.quarfactvendas;

select * from bivm.auditproduto;
select * from bivm.auditutilizador;
select * from bivm.auditmaquina;

select TF.precoV, TF.precoA, TF.lucro, D.data, H.tempo, U.email as utilizador, TF.maquina, P.nome as produto, P.pais, TF.validade, TF.idade
	FROM bivm_ar.factvendas as TF
    INNER JOIN bivm_ar.dimData as D ON TF.data = D.id
    INNER JOIN bivm_ar.dimHora as H on TF.hora = H.id
    INNER JOIN bivm_ar.dimutilizador as U on TF.utilizador = U.id
    INNER JOIN bivm_ar.dimproduto as P on TF.produto = P.id;