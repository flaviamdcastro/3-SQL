-- Consulta o total de votos para o cargo de Prefeito em Belo Horizonte, incluindo situação de turno, município e estado
SELECT    
    U.SG_UF AS Estado,
	U.NM_UE AS Municipio,
	V.NR_TURNO AS Turno,
    C.NM_CANDIDATO AS Nome_Candidato,
    C.NM_URNA_CANDIDATO AS Nome_Urna,
    SUM(CAST(V.QT_VOTOS_NOMINAIS AS INT)) AS Total_Votos,
    ST.DS_SIT_TOT_TURNO AS Situacao_Turno -- Situação do turno
FROM 
    Votacao V
INNER JOIN 
    Candidato C
    ON V.SQ_CANDIDATO = C.SQ_CANDIDATO
LEFT JOIN 
    UF U
    ON V.SG_UE = U.SG_UE AND V.SG_UF = U.SG_UF
LEFT JOIN 
    Situacao_Turno ST
    ON V.CD_SIT_TOT_TURNO = ST.CD_SIT_TOT_TURNO
WHERE 
    U.NM_UE = 'BELO HORIZONTE' -- Nome do município
    AND V.CD_CARGO = 11        -- Código do cargo para Prefeito
GROUP BY 
    C.NM_CANDIDATO, 
    C.NM_URNA_CANDIDATO, 
    V.NR_TURNO,
    ST.DS_SIT_TOT_TURNO,
    U.NM_UE,
    U.SG_UF
ORDER BY 
    Turno ASC, Total_Votos DESC;
