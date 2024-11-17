-- Consulta total de candidatos a Vereador por estado com ranking
SELECT 
    RANK() OVER (ORDER BY COUNT(C.SQ_CANDIDATO) DESC) AS Ranking,
    C.SG_UF AS Estado,
    COUNT(C.SQ_CANDIDATO) AS Total_Candidatos
FROM 
    Candidato C
WHERE 
    C.CD_CARGO = 13 -- Código do cargo para Vereador
GROUP BY 
    C.SG_UF
ORDER BY 
    Ranking;
