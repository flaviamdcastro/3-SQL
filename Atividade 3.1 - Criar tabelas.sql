
-- Configura��o de uso do banco de dados
USE EleicaoDB;
GO

-- Carga de dados para a tabela Temporaria
IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Temporaria')
DROP TABLE dbo.Temporaria
GO

CREATE TABLE Temporaria (
	DT_GERACAO VARCHAR(255),
	HH_GERACAO VARCHAR(255),
	AA_ELEICAO CHAR(10),
	SG_UF CHAR(10),
	CD_TIPO_ELEICAO CHAR(10),
	NM_TIPO_ELEICAO VARCHAR(255),
	CD_ELEICAO CHAR(50),  -- C�digo da elei��o
	DS_ELEICAO VARCHAR(255),
	SQ_CANDIDATO VARCHAR(50) NOT NULL,  -- Identificador do candidato
    NR_ORDEM_REDE_SOCIAL CHAR(50) NOT NULL,  -- N�mero da ordem da rede social
    DS_URL VARCHAR(500) NOT NULL,  -- URL do perfil da rede social
    PRIMARY KEY (SQ_CANDIDATO, NR_ORDEM_REDE_SOCIAL)
);


-- Cria��o da tabela Tipo Rede Social
IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Tipo_Rede_Social')
DROP TABLE dbo.Tipo_Rede_Social
GO

CREATE TABLE Tipo_Rede_Social (
    CD_TIPO_BEM_CANDIDATO INT PRIMARY KEY, -- C�digo do tipo de bem (chave prim�ria)
    DS_TIPO_BEM_CANDIDATO VARCHAR(255) -- Descri��o do tipo de bem
);

PRINT 'Cria��o da tabela Tipo Rede Social conclu�da com sucesso!';


-- Cria��o da tabela Rede Social
IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Rede_Social')
DROP TABLE dbo.Rede_Social
GO

CREATE TABLE Rede_Social (
	AA_ELEICAO INT,
	SG_UF CHAR(10),
	CD_TIPO_ELEICAO INT,
	NM_TIPO_ELEICAO VARCHAR(255),
	CD_ELEICAO INT,  -- C�digo da elei��o
	DS_ELEICAO VARCHAR(255),
	SQ_CANDIDATO VARCHAR(50) NOT NULL,  -- Identificador do candidato
    NR_ORDEM_REDE_SOCIAL SMALLINT NOT NULL,  -- N�mero da ordem da rede social
    DS_URL VARCHAR(500) NOT NULL,  -- URL do perfil da rede social
    PRIMARY KEY (SQ_CANDIDATO, NR_ORDEM_REDE_SOCIAL)
);
PRINT 'Cria��o da tabela Rede Social conclu�da com sucesso!';


PRINT ''
PRINT 'Fim script cria��o das tabelas da atividade 3'
