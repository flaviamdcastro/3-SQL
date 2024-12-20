
DROP VIEW vw_informacoes_candidatos;

CREATE VIEW vw_informacoes_candidatos AS
SELECT
    C.SQ_CANDIDATO,
    C.NR_CPF_CANDIDATO AS CPF_Candidato,
    C.NM_CANDIDATO AS Nome_Candidato,
    O.DS_OCUPACAO AS Ocupacao,
    P.SG_PARTIDO AS Partido,
    V.QT_VOTOS_NOMINAIS AS Votos_Nominais,
    V.QT_VOTOS_NOMINAIS_VALIDOS AS Votos_Validos,
    SUM(BC.VR_BEM_CANDIDATO) AS Valor_Total_Bens, -- Soma dos valores dos bens
    MAX(RS.DS_URL) AS Link_Rede_Social,
    C.DS_EMAIL AS Email_Candidato,
    C.NR_TITULO_ELEITORAL_CANDIDATO AS Titulo_Eleitoral,
    STRING_AGG(TB.DS_TIPO_BEM_CANDIDATO, ', ') AS Tipos_Bem -- Lista dos tipos de bens do candidato
FROM
    Candidato AS C
LEFT JOIN
    Ocupacao AS O ON C.CD_OCUPACAO = O.CD_OCUPACAO
LEFT JOIN
    Partido AS P ON C.NR_PARTIDO = P.NR_PARTIDO
LEFT JOIN
    Votacao AS V ON C.SQ_CANDIDATO = V.SQ_CANDIDATO
LEFT JOIN
    Bem_Candidato AS BC ON C.SQ_CANDIDATO = BC.SQ_CANDIDATO
LEFT JOIN
    Tipo_Bem AS TB ON BC.CD_TIPO_BEM_CANDIDATO = TB.CD_TIPO_BEM_CANDIDATO
LEFT JOIN
    Rede_Social AS RS ON C.SQ_CANDIDATO = RS.SQ_CANDIDATO
GROUP BY
    C.SQ_CANDIDATO,
    C.NR_CPF_CANDIDATO,
    C.NM_CANDIDATO,
    O.DS_OCUPACAO,
    P.SG_PARTIDO,
    V.QT_VOTOS_NOMINAIS,
    V.QT_VOTOS_NOMINAIS_VALIDOS,
    C.DS_EMAIL,
    C.NR_TITULO_ELEITORAL_CANDIDATO;
