-- Analisa o patrimônio total e classifica os candidatos
SELECT 
    C.NM_CANDIDATO AS Nome_Candidato,
    C.NM_URNA_CANDIDATO AS Nome_Urna,
    CASE 
        WHEN C.CD_CARGO = 13 THEN 'Vereador'
        WHEN C.CD_CARGO = 11 THEN 'Prefeito'
        WHEN C.CD_CARGO = 12 THEN 'Vice-Prefeito'
        ELSE 'Outro'
    END AS Cargo,
    SUM(CAST(B.VR_BEM_CANDIDATO AS DECIMAL(18, 2))) AS Patrimonio_Total,
    MAX(CAST(B.VR_BEM_CANDIDATO AS DECIMAL(18, 2))) AS Bem_Maior_Valor,
    CASE 
        WHEN SUM(CAST(B.VR_BEM_CANDIDATO AS DECIMAL(18, 2))) <= 999999.99 THEN 'Candidato com Patrimônio Normal'
        WHEN SUM(CAST(B.VR_BEM_CANDIDATO AS DECIMAL(18, 2))) BETWEEN 1000000 AND 999999999.99 THEN 'Candidato com Patrimônio Milionário'
        WHEN SUM(CAST(B.VR_BEM_CANDIDATO AS DECIMAL(18, 2))) > 1000000000 THEN 'Candidato com Patrimônio Bilionário'
    END AS Classificacao_Patrimonial
FROM 
    Candidato C
INNER JOIN Bem_Candidato B
    ON C.SQ_CANDIDATO = B.SQ_CANDIDATO
WHERE 
    C.CD_CARGO IN (11, 12, 13) -- Códigos de Prefeito, Vice-Prefeito e Vereador
GROUP BY 
    C.NM_CANDIDATO, C.NM_URNA_CANDIDATO, C.CD_CARGO
ORDER BY 
    Patrimonio_Total DESC;