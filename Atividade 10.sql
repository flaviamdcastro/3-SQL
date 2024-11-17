CREATE PROCEDURE exibir_candidatos_por_uf (@uf VARCHAR(2))
AS
BEGIN
    -- Apaga a tabela temporária se ela existir
    IF OBJECT_ID('tempdb..#temp_candidatos') IS NOT NULL
        DROP TABLE #temp_candidatos;

    -- Cria a tabela temporária
    CREATE TABLE #temp_candidatos (
        -- Defina aqui as colunas da tabela com seus respectivos tipos de dados
        id INT,
        nome VARCHAR(255),
        uf VARCHAR(2)
    );

    -- Insere os dados dos candidatos da UF informada na tabela temporária
    INSERT INTO #temp_candidatos (id, nome, uf)
    SELECT id, nome, uf
    FROM candidatos -- Substitua 'candidatos' pelo nome da sua tabela
    WHERE uf = @uf;

    -- Exibe os dados da tabela temporária
    SELECT * FROM #temp_candidatos;

END