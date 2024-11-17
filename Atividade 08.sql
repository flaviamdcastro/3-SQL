SELECT
    RANK() OVER (PARTITION BY U.NM_UE ORDER BY SUM(CAST(V.QT_VOTOS_NOMINAIS AS INT)) DESC) AS Posicao_Ranking,
    U.NM_UE AS Municipio,
    C.NM_CANDIDATO AS Nome_Candidato,
    C.NM_URNA_CANDIDATO AS Nome_Urna,
    SUM(CAST(V.QT_VOTOS_NOMINAIS AS INT)) AS Quantidade_Votos 
FROM
    Candidato C
INNER JOIN Votacao V
    ON C.SQ_CANDIDATO = V.SQ_CANDIDATO
    AND C.CD_ELEICAO = V.CD_ELEICAO
    AND C.NR_TURNO = V.NR_TURNO
INNER JOIN UF U
    ON C.SG_UF = U.SG_UF
    AND C.SG_UE = U.SG_UE
WHERE
    C.CD_CARGO = 13 -- Código do cargo de Vereador
    AND C.CD_SIT_TOT_TURNO = '2' -- Código indicando candidato eleito
GROUP BY
    U.NM_UE,
    C.NM_CANDIDATO,
    C.NM_URNA_CANDIDATO
ORDER BY
    Quantidade_Votos DESC;

