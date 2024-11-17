-- Configuração de uso do banco de dados
USE EleicaoDB;
GO

-- Habilita a opção de importar arquivos CSV
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Loop pelos arquivos CSV
DECLARE @nomeArquivo VARCHAR(255)
DECLARE @caminhoArquivo VARCHAR(255)
DECLARE @extensao VARCHAR(255)
DECLARE @comando VARCHAR(MAX)

-- Define o caminho dos arquivos
SET @caminhoArquivo = 'E:\3-SQL\'

-- Verifica se o cursor já existe
IF CURSOR_STATUS('global','cursor_arquivos') >= 1
BEGIN
    -- Se o cursor estiver aberto, fecha e desaloca
    CLOSE cursor_arquivos
    DEALLOCATE cursor_arquivos
END

-- Cursor para iterar sobre os nomes dos arquivos
DECLARE cursor_arquivos CURSOR FOR
SELECT 'bem_candidato_2024_RO.csv' AS nomeArquivo
UNION ALL
SELECT 'bem_candidato_2024_AC.csv'
UNION ALL
SELECT 'bem_candidato_2024_AM.csv'
UNION ALL
SELECT 'bem_candidato_2024_RR.csv'
UNION ALL
SELECT 'bem_candidato_2024_PA.csv'
UNION ALL
SELECT 'bem_candidato_2024_AP.csv'
UNION ALL
SELECT 'bem_candidato_2024_TO.csv'
UNION ALL
SELECT 'bem_candidato_2024_MA.csv'
UNION ALL
SELECT 'bem_candidato_2024_PI.csv'
UNION ALL
SELECT 'bem_candidato_2024_CE.csv'
UNION ALL
SELECT 'bem_candidato_2024_RN.csv'
UNION ALL
SELECT 'bem_candidato_2024_PB.csv'
UNION ALL
SELECT 'bem_candidato_2024_PE.csv'
UNION ALL
SELECT 'bem_candidato_2024_AL.csv'
UNION ALL
SELECT 'bem_candidato_2024_SE.csv'
UNION ALL
SELECT 'bem_candidato_2024_BA.csv'
UNION ALL
SELECT 'bem_candidato_2024_MG.csv'
UNION ALL
SELECT 'bem_candidato_2024_ES.csv'
UNION ALL
SELECT 'bem_candidato_2024_RJ.csv'
UNION ALL
SELECT 'bem_candidato_2024_SP.csv'
UNION ALL
SELECT 'bem_candidato_2024_PR.csv'
UNION ALL
SELECT 'bem_candidato_2024_SC.csv'
UNION ALL
SELECT 'bem_candidato_2024_RS.csv'
UNION ALL
SELECT 'bem_candidato_2024_MS.csv'
UNION ALL
SELECT 'bem_candidato_2024_MT.csv'
UNION ALL
SELECT 'consulta_cand_2024_GO.csv'

OPEN cursor_arquivos

FETCH NEXT FROM cursor_arquivos INTO @nomeArquivo

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Monta o comando BULK INSERT dinamicamente com o caminho completo
    SET @comando = '
    BULK INSERT Candidato
    FROM ''' + @caminhoArquivo + @nomeArquivo +'''
    WITH (
        FORMAT = ''CSV'',
        FIELDQUOTE = ''"'', -- Se os campos estiverem entre aspas
        ROWTERMINATOR = ''0x0a'',
        FIRSTROW = 2, -- Ignora o cabeçalho, se houver
        FIELDTERMINATOR = '';'', -- Separador de campos
		CODEPAGE = ''1252'',
		TABLOCK
    );'

    -- Executa o comando BULK INSERT
	PRINT ''
	PRINT 'Lendo o arquivo: ' + @nomeArquivo
    EXEC(@comando)
	
    FETCH NEXT FROM cursor_arquivos INTO @nomeArquivo
	
END

PRINT ''
PRINT 'Importação dos dados para tabela temporária concluída com sucesso!';
PRINT ''

CLOSE cursor_arquivos
DEALLOCATE cursor_arquivos


-- Carga da tabela Tipo de bem
INSERT INTO Tipo_bem (CD_TIPO_BEM_CANDIDATO, DS_TIPO_BEM_CANDIDATO)
SELECT DISTINCT CD_TIPO_BEM_CANDIDATO, DS_TIPO_BEM_CANDIDATO
from dbo.Temporaria
ORDER BY CD_TIPO_BEM_CANDIDATO
PRINT 'Carga da tabela Tipo de Bem concluída com sucesso!';


-- Carga da tabela Bem Candidato
INSERT INTO Bem_Candidato (ANO_ELEICAO,
						CD_TIPO_ELEICAO,
						NM_TIPO_ELEICAO,
						CD_ELEICAO,
						DS_ELEICAO,
						DT_ELEICAO,
						SG_UF,
						SG_UE,
						NM_UE,
						SQ_CANDIDATO,
						NR_ORDEM_BEM_CANDIDATO,
						CD_TIPO_BEM_CANDIDATO,
						DS_BEM_CANDIDATO,
						VR_BEM_CANDIDATO,
						DT_ULT_ATUAL_BEM_CANDIDATO,
						HH_ULT_ATUAL_BEM_CANDIDATO)
SELECT DISTINCT ANO_ELEICAO,
				CD_TIPO_ELEICAO,
				NM_TIPO_ELEICAO,
				CD_ELEICAO,
				DS_ELEICAO,
				DT_ELEICAO,
				SG_UF,
				SG_UE,
				NM_UE,
				SQ_CANDIDATO,
				NR_ORDEM_BEM_CANDIDATO,
				CD_TIPO_BEM_CANDIDATO,
				DS_BEM_CANDIDATO,
				VR_BEM_CANDIDATO,
				DT_ULT_ATUAL_BEM_CANDIDATO,
				HH_ULT_ATUAL_BEM_CANDIDATO
from dbo.Temporaria
ORDER BY CD_TIPO_BEM_CANDIDATO

PRINT 'Carga da tabela Candidato concluída com sucesso!';

DROP TABLE dbo.Temporaria

PRINT ''
PRINT 'Fim script carga das tabelas da atividade 2'

