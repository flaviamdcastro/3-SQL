SELECT 
    U.SG_UF AS Estado,
    U.NM_UE AS Municipio,
    C.NM_CANDIDATO AS Nome_Candidato,
    C.NM_URNA_CANDIDATO AS Nome_Urna,
    CASE 
        WHEN C.CD_CARGO = 13 THEN 'Vereador'
        WHEN C.CD_CARGO = 11 THEN 'Prefeito'
        WHEN C.CD_CARGO = 12 THEN 'Vice-Prefeito'
        ELSE 'Outro'
    END AS Cargo,
    SUM(CAST(B.VR_BEM_CANDIDATO AS DECIMAL(18, 2))) AS Patrimonio_Total,
    	FORMAT(MAX(CAST(B.VR_BEM_CANDIDATO AS DECIMAL(18, 2))), 'C', 'pt-BR') AS Valor_Bem_Mais_Caro,
--    MAX(CAST(B.VR_BEM_CANDIDATO AS DECIMAL(18, 2))) AS Valor_Bem_Mais_Caro,
    TB.DS_TIPO_BEM_CANDIDATO AS Tipo_Bem_Maior_Valor, -- Descrição do tipo do bem de maior valor
    MAX(B.DS_BEM_CANDIDATO) AS Bem_De_Maior_Valor,
    CASE 
        WHEN SUM(CAST(B.VR_BEM_CANDIDATO AS DECIMAL(18, 2))) <= 999999.99 THEN 'Candidato com Patrimônio Normal'
        WHEN SUM(CAST(B.VR_BEM_CANDIDATO AS DECIMAL(18, 2))) BETWEEN 1000000 AND 999999999.99 THEN 'Candidato com Patrimônio Milionário'
        WHEN SUM(CAST(B.VR_BEM_CANDIDATO AS DECIMAL(18, 2))) > 1000000000 THEN 'Candidato com Patrimônio Bilionário'
    END AS Classificacao_Patrimonial
FROM 
    Candidato C
INNER JOIN Bem_Candidato B
    ON C.SQ_CANDIDATO = B.SQ_CANDIDATO
LEFT JOIN Tipo_Bem TB
    ON B.CD_TIPO_BEM_CANDIDATO = TB.CD_TIPO_BEM_CANDIDATO
LEFT JOIN UF U
    ON C.SG_UE = U.SG_UE AND C.SG_UF = U.SG_UF
WHERE 
    C.CD_CARGO IN (11, 12, 13) -- Códigos de Prefeito, Vice-Prefeito e Vereador
    AND CAST(B.VR_BEM_CANDIDATO AS DECIMAL(18, 2)) = (
        SELECT MAX(CAST(B2.VR_BEM_CANDIDATO AS DECIMAL(18, 2)))
        FROM Bem_Candidato B2
        WHERE B2.SQ_CANDIDATO = B.SQ_CANDIDATO
    )
GROUP BY 
    C.NM_CANDIDATO, 
    C.NM_URNA_CANDIDATO, 
    C.CD_CARGO,
    U.NM_UE, 
    U.SG_UF,
    TB.DS_TIPO_BEM_CANDIDATO
ORDER BY 
    Patrimonio_Total DESC;
