use bivm_dw;

select * from factvendas;

select sum(TF.precoV), sum(TF.precoA), sum(TF.lucro), TF.maquina, H.Periodo, U.genero
	FROM bivm_dw.factvendas as TF
    INNER JOIN bivm_dw.dimData as D ON TF.data = D.id
    INNER JOIN bivm_dw.dimHora as H on TF.hora = H.id
    INNER JOIN bivm_dw.dimutilizador as U on TF.utilizador = U.id
--    INNER JOIN bivm_dw.dimproduto as P on TF.produto = P.id
    WHERE D.Ano >= 2016 AND D.Mes >= 6
		AND H.Periodo = 'Tarde'
        AND U.genero = 'Feminino'
    GROUP BY TF.maquina;