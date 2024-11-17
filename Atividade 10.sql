CREATE PROCEDURE exibir_candidatos_por_uf 
    @uf CHAR(2)
AS
BEGIN
    SET NOCOUNT ON;

    -- Apaga a tabela temporária se ela existir
    IF OBJECT_ID('tempdb..#TempCandidatos') IS NOT NULL
        DROP TABLE #TempCandidatos;

    -- Cria a tabela temporária para armazenar os dados
    CREATE TABLE #TempCandidatos (
        NR_CANDIDATO VARCHAR(50),
        Nome_Candidato VARCHAR(255),
        NM_URNA_CANDIDATO VARCHAR(50),
        NM_SOCIAL_CANDIDATO VARCHAR(255),
        Municipio VARCHAR(100),
        Estado CHAR(2),
        Turno INT,
        Situacao_Candidato VARCHAR(255),
        Valor_Total_Bens DECIMAL(20, 2),
        Link_Rede_Social VARCHAR(255)
    );

    -- Insere as informações dos candidatos da UF informada
    INSERT INTO #TempCandidatos (NR_CANDIDATO, Nome_Candidato, NM_URNA_CANDIDATO, NM_SOCIAL_CANDIDATO, Municipio, Estado, Turno, Situacao_Candidato, Valor_Total_Bens, Link_Rede_Social)
    SELECT
        C.NR_CANDIDATO,
        C.NM_CANDIDATO,
        C.NM_URNA_CANDIDATO,
        C.NM_SOCIAL_CANDIDATO,
        U.NM_UE,
        U.SG_UF,
        C.NR_TURNO,
        ST.DS_SIT_TOT_TURNO,
        SUM(BC.VR_BEM_CANDIDATO),
        MAX(RS.DS_URL)
    FROM
        Candidato AS C
    LEFT JOIN
        UF AS U ON C.SG_UF = U.SG_UF AND C.SG_UE = U.SG_UE
    LEFT JOIN
        Bem_Candidato AS BC ON C.SQ_CANDIDATO = BC.SQ_CANDIDATO
    LEFT JOIN
        Rede_Social AS RS ON C.SQ_CANDIDATO = RS.SQ_CANDIDATO
    LEFT JOIN
        Situacao_Turno AS ST ON C.CD_SIT_TOT_TURNO = ST.CD_SIT_TOT_TURNO
    WHERE
        C.SG_UF = @uf
    GROUP BY
        C.NR_CANDIDATO,
        C.NM_CANDIDATO,
        C.NM_URNA_CANDIDATO,
        C.NM_SOCIAL_CANDIDATO,
        U.NM_UE,
        U.SG_UF,
        C.NR_TURNO,
        ST.DS_SIT_TOT_TURNO;

    -- Exibe os dados da tabela temporária
    SELECT * FROM #TempCandidatos;

    -- Limpeza automática da tabela temporária (opcional devido ao escopo)
    DROP TABLE #TempCandidatos;
END;