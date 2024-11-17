-- Seleciona os candidatos a vereador eleitos e cria um ranking baseado nos votos recebidos
SELECT
    C.NM_CANDIDATO AS Nome_Candidato,
    U.NM_UE AS Municipio,
    CAST(V.QT_VOTOS_NOMINAIS AS INT) AS Votos_Recebidos,
    RANK() OVER (ORDER BY CAST(V.QT_VOTOS_NOMINAIS AS INT) DESC) AS Ranking
FROM
    Candidato C
INNER JOIN Votacao V
    ON C.SQ_CANDIDATO = V.SQ_CANDIDATO
    AND C.CD_ELEICAO = V.CD_ELEICAO
    AND C.NR_TURNO = V.NR_TURNO
INNER JOIN UF U
    ON V.SG_UF = U.SG_UF
    AND V.SG_UE = U.SG_UE
WHERE
    C.DS_SIT_TOT_TURNO = 'Eleito'     -- Apenas candidatos eleitos
    AND C.CD_CARGO = 13               -- Código do cargo de vereador
ORDER BY
    Votos_Recebidos DESC;             -- Ordena pelos votos recebidos



-- Seleciona os candidatos a vereador eleitos e cria um ranking baseado nos votos recebidos
SELECT
    C.NM_CANDIDATO AS Nome_Candidato,
    U.NM_UE AS Municipio,
    CAST(V.QT_VOTOS_NOMINAIS AS INT) AS Votos_Recebidos,
    RANK() OVER (ORDER BY CAST(V.QT_VOTOS_NOMINAIS AS INT) DESC) AS Ranking
FROM
    Candidato C
INNER JOIN Votacao V
    ON C.SQ_CANDIDATO = V.SQ_CANDIDATO
    AND C.CD_ELEICAO = V.CD_ELEICAO
    AND C.NR_TURNO = V.NR_TURNO
INNER JOIN UF U
    ON V.SG_UF = U.SG_UF
    AND V.SG_UE = U.SG_UE
WHERE
    C.DS_SIT_TOT_TURNO = 'Eleito'     -- Apenas candidatos eleitos
    AND C.CD_CARGO = 13               -- Código do cargo de vereador
ORDER BY
    Votos_Recebidos DESC;             -- Ordena pelos votos recebidos
