
-- Configuração de uso do banco de dados
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
	CD_ELEICAO CHAR(50),  -- Código da eleição
	DS_ELEICAO VARCHAR(255),
	SQ_CANDIDATO VARCHAR(50) NOT NULL,  -- Identificador do candidato
    NR_ORDEM_REDE_SOCIAL CHAR(50) NOT NULL,  -- Número da ordem da rede social
    DS_URL VARCHAR(500) NOT NULL,  -- URL do perfil da rede social
    PRIMARY KEY (SQ_CANDIDATO, NR_ORDEM_REDE_SOCIAL)
);


-- Criação da tabela Tipo Rede Social
IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Tipo_Rede_Social')
DROP TABLE dbo.Tipo_Rede_Social
GO

CREATE TABLE Tipo_Rede_Social (
    CD_TIPO_BEM_CANDIDATO INT PRIMARY KEY, -- Código do tipo de bem (chave primária)
    DS_TIPO_BEM_CANDIDATO VARCHAR(255) -- Descrição do tipo de bem
);

PRINT 'Criação da tabela Tipo Rede Social concluída com sucesso!';


-- Criação da tabela Rede Social
IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Rede_Social')
DROP TABLE dbo.Rede_Social
GO

CREATE TABLE Rede_Social (
	AA_ELEICAO INT,
	SG_UF CHAR(10),
	CD_TIPO_ELEICAO INT,
	NM_TIPO_ELEICAO VARCHAR(255),
	CD_ELEICAO INT,  -- Código da eleição
	DS_ELEICAO VARCHAR(255),
	SQ_CANDIDATO VARCHAR(50) NOT NULL,  -- Identificador do candidato
    NR_ORDEM_REDE_SOCIAL SMALLINT NOT NULL,  -- Número da ordem da rede social
    DS_URL VARCHAR(500) NOT NULL,  -- URL do perfil da rede social
    PRIMARY KEY (SQ_CANDIDATO, NR_ORDEM_REDE_SOCIAL)
);
PRINT 'Criação da tabela Rede Social concluída com sucesso!';


PRINT ''
PRINT 'Fim script criação das tabelas da atividade 3'
