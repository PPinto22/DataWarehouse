select * from bivm_dw.histproduto;
select * from bivm_dw.histmaquina;

select * from bivm_dw.dimproduto;
select * from bivm_dw.dimutilizador;
select * from bivm_dw.dimmaquina;
select * from bivm_dw.dimhora;
select * from bivm_dw.dimdata;

select * from bivm_dw.factvendas;

select TF.precoV, TF.precoA, TF.lucro, D.data, H.tempo, U.email as utilizador, TF.maquina, P.nome as produto, P.pais, TF.validade, TF.idade
	FROM bivm_dw.factvendas as TF
    INNER JOIN bivm_dw.dimData as D ON TF.data = D.id
    INNER JOIN bivm_dw.dimHora as H on TF.hora = H.id
    INNER JOIN bivm_dw.dimutilizador as U on TF.utilizador = U.id
    INNER JOIN bivm_dw.dimproduto as P on TF.produto = P.id;