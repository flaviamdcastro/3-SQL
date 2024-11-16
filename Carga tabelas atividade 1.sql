
-- Configuração de uso do banco de dados
USE EleicaoDB;
GO

-- Carga de dados para a tabela Candidato

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

-- Define a extensão dos arquivos
--SET @extensao = '.CSV'


-- Cursor para iterar sobre os nomes dos arquivos
DECLARE cursor_arquivos CURSOR FOR
SELECT 'consulta_cand_2024_RO.csv' AS nomeArquivo
UNION ALL
SELECT 'consulta_cand_2024_AC.csv'
UNION ALL
SELECT 'consulta_cand_2024_AM.csv'
UNION ALL
SELECT 'consulta_cand_2024_RR.csv'
UNION ALL
SELECT 'consulta_cand_2024_PA.csv'
UNION ALL
SELECT 'consulta_cand_2024_AP.csv'
UNION ALL
SELECT 'consulta_cand_2024_TO.csv'
UNION ALL
SELECT 'consulta_cand_2024_MA.csv'
UNION ALL
SELECT 'consulta_cand_2024_PI.csv'
UNION ALL
SELECT 'consulta_cand_2024_CE.csv'
UNION ALL
SELECT 'consulta_cand_2024_RN.csv'
UNION ALL
SELECT 'consulta_cand_2024_PB.csv'
UNION ALL
SELECT 'consulta_cand_2024_PE.csv'
UNION ALL
SELECT 'consulta_cand_2024_AL.csv'
UNION ALL
SELECT 'consulta_cand_2024_SE.csv'
UNION ALL
SELECT 'consulta_cand_2024_BA.csv'
UNION ALL
SELECT 'consulta_cand_2024_MG.csv'
UNION ALL
SELECT 'consulta_cand_2024_ES.csv'
UNION ALL
SELECT 'consulta_cand_2024_RJ.csv'
UNION ALL
SELECT 'consulta_cand_2024_SP.csv'
UNION ALL
SELECT 'consulta_cand_2024_PR.csv'
UNION ALL
SELECT 'consulta_cand_2024_SC.csv'
UNION ALL
SELECT 'consulta_cand_2024_RS.csv'
UNION ALL
SELECT 'consulta_cand_2024_MS.csv'
UNION ALL
SELECT 'consulta_cand_2024_MT.csv'
UNION ALL
SELECT 'consulta_cand_2024_GO.csv'

OPEN cursor_arquivos

FETCH NEXT FROM cursor_arquivos INTO @nomeArquivo

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Monta o comando BULK INSERT dinamicamente com o caminho completo
    SET @comando = '
    BULK INSERT Temporaria
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


-- Carga da tabela UF
INSERT INTO UF (SG_UF, SG_UE, NM_UE)
select DISTINCT SG_UF, SG_UE, NM_UE
from dbo.Temporaria
ORDER BY SG_UF, NM_UE
PRINT 'Carga da tabela UF concluída com sucesso!';


-- Carga da tabela Cargo
INSERT INTO Cargo (CD_CARGO, DS_CARGO)
select DISTINCT CD_CARGO, DS_CARGO
from dbo.Temporaria
ORDER BY DS_CARGO
PRINT 'Carga da tabela Cargo concluída com sucesso!';


-- Carga da tabela Situacao da Candidatura
INSERT INTO Situacao_Candidatura (CD_SITUACAO_CANDIDATURA, DS_SITUACAO_CANDIDATURA)
select DISTINCT CD_SITUACAO_CANDIDATURA, DS_SITUACAO_CANDIDATURA
from dbo.Temporaria
ORDER BY CD_SITUACAO_CANDIDATURA
PRINT 'Carga da tabela Situacao da Candidatura concluída com sucesso!';


-- Carga da tabela Partido
INSERT INTO Partido (NR_PARTIDO, SG_PARTIDO, NM_PARTIDO)
select DISTINCT NR_PARTIDO, SG_PARTIDO, NM_PARTIDO
from dbo.Temporaria
ORDER BY NR_PARTIDO
PRINT 'Carga da tabela Partido concluída com sucesso!';


-- Carga da tabela Grau de Instrucao
INSERT INTO Grau_Instrucao (CD_GRAU_INSTRUCAO, DS_GRAU_INSTRUCAO)
select DISTINCT CD_GRAU_INSTRUCAO, DS_GRAU_INSTRUCAO
from dbo.Temporaria
ORDER BY CD_GRAU_INSTRUCAO
PRINT 'Carga da tabela Grau de Instrução concluída com sucesso!';



-- Carga da tabela Ocupacao
INSERT INTO Ocupacao (CD_OCUPACAO, DS_OCUPACAO)
select DISTINCT CD_OCUPACAO, DS_OCUPACAO
from dbo.Temporaria
ORDER BY CD_OCUPACAO
PRINT 'Carga da tabela Ocupação concluída com sucesso!';


-- Carga da tabela Eleicao
INSERT INTO Eleicao (ANO_ELEICAO,
    CD_TIPO_ELEICAO,
    NM_TIPO_ELEICAO,
    NR_TURNO,
    CD_ELEICAO,  
    DS_ELEICAO,
    DT_ELEICAO)
select DISTINCT ANO_ELEICAO,
    CD_TIPO_ELEICAO,
    NM_TIPO_ELEICAO,
    NR_TURNO,
    CD_ELEICAO,  
    DS_ELEICAO,
    DT_ELEICAO
from dbo.Temporaria
ORDER BY CD_ELEICAO
PRINT 'Carga da tabela Eleição concluída com sucesso!';



-- Carga da tabela Candidato
INSERT INTO Candidato (NR_TURNO,
				CD_ELEICAO,
				DS_ELEICAO,
				DT_ELEICAO,
				TP_ABRANGENCIA,
				SG_UF,
				SG_UE,
				CD_CARGO,
				SQ_CANDIDATO,
				NR_CANDIDATO,
				NM_CANDIDATO,
				NM_URNA_CANDIDATO,
				NM_SOCIAL_CANDIDATO,
				NR_CPF_CANDIDATO,
				DS_EMAIL,
				CD_SITUACAO_CANDIDATURA,
				TP_AGREMIACAO,
				NR_PARTIDO,
				SG_UF_NASCIMENTO,
				DT_NASCIMENTO,
				NR_TITULO_ELEITORAL_CANDIDATO,
				CD_GENERO,
				DS_GENERO,
				CD_GRAU_INSTRUCAO,
				CD_ESTADO_CIVIL,
				DS_ESTADO_CIVIL,
				CD_COR_RACA,
				DS_COR_RACA,
				CD_OCUPACAO,
				CD_SIT_TOT_TURNO,
				DS_SIT_TOT_TURNO)
select DISTINCT NR_TURNO,
				CD_ELEICAO,
				DS_ELEICAO,
				DT_ELEICAO,
				TP_ABRANGENCIA,
				SG_UF,
				SG_UE,
				CD_CARGO,
				SQ_CANDIDATO,
				NR_CANDIDATO,
				NM_CANDIDATO,
				NM_URNA_CANDIDATO,
				NM_SOCIAL_CANDIDATO,
				NR_CPF_CANDIDATO,
				DS_EMAIL,
				CD_SITUACAO_CANDIDATURA,
				TP_AGREMIACAO,
				NR_PARTIDO,
				SG_UF_NASCIMENTO,
				DT_NASCIMENTO,
				NR_TITULO_ELEITORAL_CANDIDATO,
				CD_GENERO,
				DS_GENERO,
				CD_GRAU_INSTRUCAO,
				CD_ESTADO_CIVIL,
				DS_ESTADO_CIVIL,
				CD_COR_RACA,
				DS_COR_RACA,
				CD_OCUPACAO,
				CD_SIT_TOT_TURNO,
				DS_SIT_TOT_TURNO

from dbo.Temporaria
ORDER BY CD_ELEICAO, NR_TURNO, SQ_CANDIDATO

PRINT 'Carga da tabela Candidato concluída com sucesso!';

DROP TABLE dbo.Temporaria

PRINT ''
PRINT 'Fim script carga das tabelas da atividade 1'