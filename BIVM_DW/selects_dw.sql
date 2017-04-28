select * from bivm_dw.histproduto;
select * from bivm_dw.histmaquina;

select * from bivm_dw.dimproduto;
select * from bivm_dw.dimutilizador;
select * from bivm_dw.dimmaquina;
select * from bivm_dw.dimdata;
select * from bivm_dw.dimlocal;

select * from bivm_dw.factvendas;

select TF.precoV, TF.precoA, TF.lucro, TF.validade, D.dia, U.email as utilizador, TF.maquina, 
	L.cod_postal, L.freguesia, L.rua, L.cidade, L.pais,  P.nome as produto, P.pais, 
	TF.idade, TF.hora, TF.periodo
	FROM bivm_dw.factvendas as TF
    INNER JOIN bivm_dw.dimData as D ON TF.data = D.id
    INNER JOIN bivm_dw.dimutilizador as U on TF.utilizador = U.id
    INNER JOIN bivm_dw.dimproduto as P on TF.produto = P.id
    INNER JOIN bivm_dw.dimLocal as L on TF.local = L.id;