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
SELECT 'votacao_candidato_munzona_2024_RO.csv' AS nomeArquivo
UNION ALL
SELECT 'votacao_candidato_munzona_2024_AC.csv'
UNION ALL
SELECT 'votacao_candidato_munzona_2024_AM.csv'
UNION ALL
SELECT 'votacao_candidato_munzona_2024_RR.csv'
UNION ALL
SELECT 'votacao_candidato_munzona_2024_PA.csv'
UNION ALL
SELECT 'votacao_candidato_munzona_2024_AP.csv'
UNION ALL
SELECT 'votacao_candidato_munzona_2024_TO.csv'
UNION ALL
SELECT 'votacao_candidato_munzona_2024_MA.csv'
UNION ALL
SELECT 'votacao_candidato_munzona_2024_PI.csv'
UNION ALL
SELECT 'votacao_candidato_munzona_2024_CE.csv'
UNION ALL
SELECT 'votacao_candidato_munzona_2024_RN.csv'
UNION ALL
SELECT 'votacao_candidato_munzona_2024_PB.csv'
UNION ALL
SELECT 'votacao_candidato_munzona_2024_PE.csv'
UNION ALL
SELECT 'votacao_candidato_munzona_2024_AL.csv'
UNION ALL
SELECT 'votacao_candidato_munzona_2024_SE.csv'
UNION ALL
SELECT 'votacao_candidato_munzona_2024_BA.csv'
UNION ALL
SELECT 'votacao_candidato_munzona_2024_MG.csv'
UNION ALL
SELECT 'votacao_candidato_munzona_2024_ES.csv'
UNION ALL
SELECT 'votacao_candidato_munzona_2024_RJ.csv'
UNION ALL
SELECT 'votacao_candidato_munzona_2024_SP.csv'
UNION ALL
SELECT 'votacao_candidato_munzona_2024_PR.csv'
UNION ALL
SELECT 'votacao_candidato_munzona_2024_SC.csv'
UNION ALL
SELECT 'votacao_candidato_munzona_2024_RS.csv'
UNION ALL
SELECT 'votacao_candidato_munzona_2024_MS.csv'
UNION ALL
SELECT 'votacao_candidato_munzona_2024_MT.csv'
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
        ROWTERMINATOR = ''\n'',
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


-- Carga da tabela Situacao no Turno
INSERT INTO Situacao_Turno (CD_SIT_TOT_TURNO, DS_SIT_TOT_TURNO)
SELECT DISTINCT CD_SIT_TOT_TURNO, DS_SIT_TOT_TURNO
from dbo.Temporaria
ORDER BY CD_SIT_TOT_TURNO
PRINT 'Carga da tabela Situacao no Turno concluída com sucesso!';



-- Carga da tabela Votacao
INSERT INTO Votacao (ANO_ELEICAO,
					CD_TIPO_ELEICAO,
					NR_TURNO,
					CD_ELEICAO,
					TP_ABRANGENCIA,
					SG_UF,
					SG_UE,
					CD_MUNICIPIO,
					NR_ZONA,
					CD_CARGO,
					SQ_CANDIDATO,
					CD_SITUACAO_CANDIDATURA,
					DS_SITUACAO_CANDIDATURA,
					CD_DETALHE_SITUACAO_CAND,
					DS_DETALHE_SITUACAO_CAND,
					CD_SITUACAO_JULGAMENTO,
					DS_SITUACAO_JULGAMENTO,
					CD_SITUACAO_CASSACAO,
					DS_SITUACAO_CASSACAO,
					CD_SITUACAO_DIPLOMA,
					DS_SITUACAO_DIPLOMA,
					TP_AGREMIACAO,
					NR_PARTIDO,
					SG_FEDERACAO,
					SQ_COLIGACAO,
					ST_VOTO_EM_TRANSITO,
					QT_VOTOS_NOMINAIS,
					NM_TIPO_DESTINACAO_VOTOS,
					QT_VOTOS_NOMINAIS_VALIDOS,
					CD_SIT_TOT_TURNO
)
SELECT DISTINCT ANO_ELEICAO,
				CD_TIPO_ELEICAO,
				NR_TURNO,
				CD_ELEICAO,
				TP_ABRANGENCIA,
				SG_UF,
				SG_UE,
				CD_MUNICIPIO,
				NR_ZONA,
				CD_CARGO,
				SQ_CANDIDATO,
				CD_SITUACAO_CANDIDATURA,
				DS_SITUACAO_CANDIDATURA,
				CD_DETALHE_SITUACAO_CAND,
				DS_DETALHE_SITUACAO_CAND,
				CD_SITUACAO_JULGAMENTO,
				DS_SITUACAO_JULGAMENTO,
				CD_SITUACAO_CASSACAO,
				DS_SITUACAO_CASSACAO,
				CD_SITUACAO_DIPLOMA,
				DS_SITUACAO_DIPLOMA,
				TP_AGREMIACAO,
				NR_PARTIDO,
				SG_FEDERACAO,
				SQ_COLIGACAO,
				ST_VOTO_EM_TRANSITO,
				QT_VOTOS_NOMINAIS,
				NM_TIPO_DESTINACAO_VOTOS,
				QT_VOTOS_NOMINAIS_VALIDOS,
				CD_SIT_TOT_TURNO
from dbo.Temporaria
ORDER BY SQ_CANDIDATO, CD_ELEICAO, NR_TURNO, NR_ZONA
PRINT 'Carga da tabela Situacao no Turno concluída com sucesso!';


DROP TABLE dbo.Temporaria

PRINT ''
PRINT 'Fim script carga das tabelas da atividade 4'