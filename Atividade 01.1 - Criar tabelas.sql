-- Cria��o do banco de dados
IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = 'EleicaoDB')
BEGIN
    CREATE DATABASE EleicaoDB; -- Cria o banco de dados
END;

GO

-- Configura��o de uso do banco de dados
USE EleicaoDB;
GO

-- Carga de dados para a tabela Tempor�ria
IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Temporaria')
DROP TABLE dbo.Temporaria
GO

CREATE TABLE Temporaria (
    DT_GERACAO VARCHAR(255),
	HH_GERACAO VARCHAR(255),
	ANO_ELEICAO INT,
	CD_TIPO_ELEICAO INT,
	NM_TIPO_ELEICAO VARCHAR(255),
	NR_TURNO INT,
	CD_ELEICAO INT,  -- C�digo da elei��o
	DS_ELEICAO VARCHAR(255),
	DT_ELEICAO VARCHAR(255),
	TP_ABRANGENCIA VARCHAR(255),
	SG_UF CHAR(10),
	SG_UE VARCHAR(255),
	NM_UE VARCHAR(255),
	CD_CARGO INT, -- C�digo do cargo
	DS_CARGO VARCHAR(255),
	SQ_CANDIDATO VARCHAR(50), -- Identificador �nico do candidato
	NR_CANDIDATO VARCHAR(50) NOT NULL,  -- N�mero do candidato
	NM_CANDIDATO VARCHAR(255) NOT NULL,  -- Nome completo do candidato
	NM_URNA_CANDIDATO VARCHAR(50) NOT NULL,  -- Nome do candidato na urna
	NM_SOCIAL_CANDIDATO VARCHAR(255),  -- Nome social do candidato
	NR_CPF_CANDIDATO VARCHAR(50), --UNIQUE NOT NULL,  -- CPF do candidato (�nico)
	DS_EMAIL VARCHAR(100),  -- Email do candidato
	CD_SITUACAO_CANDIDATURA INT,
	DS_SITUACAO_CANDIDATURA VARCHAR(255),
	TP_AGREMIACAO VARCHAR(255),
	NR_PARTIDO INT,
	SG_PARTIDO CHAR(50),  -- Sigla do partido
	NM_PARTIDO VARCHAR(255),
	NR_FEDERACAO INT,
	NM_FEDERACAO VARCHAR(255),
	SG_FEDERACAO VARCHAR(255),
	DS_COMPOSICAO_FEDERACAO VARCHAR(255),
	SQ_COLIGACAO CHAR(50), --INT,  -- Sequencial da coliga��o
	NM_COLIGACAO VARCHAR(255),
	DS_COMPOSICAO_COLIGACAO VARCHAR(255),
	SG_UF_NASCIMENTO VARCHAR(255),
	DT_NASCIMENTO DATE,  -- Data de nascimento do candidato
	NR_TITULO_ELEITORAL_CANDIDATO CHAR(50),  -- N�mero do t�tulo eleitoral (�nico)
	CD_GENERO INT CHECK (CD_GENERO IN (2, 4)),  -- C�digo do g�nero (2: Masculino, 4: Feminino)
	DS_GENERO VARCHAR(255),
	CD_GRAU_INSTRUCAO INT,  -- C�digo do grau de instru��o
	DS_GRAU_INSTRUCAO VARCHAR(255),
	CD_ESTADO_CIVIL INT,  -- C�digo do estado civil
	DS_ESTADO_CIVIL VARCHAR(255),
	CD_COR_RACA INT,  -- C�digo da cor/ra�a
	DS_COR_RACA VARCHAR(255),
	CD_OCUPACAO INT,  -- C�digo da ocupa��o
	DS_OCUPACAO VARCHAR(100),  -- Descri��o da ocupa��o
	CD_SIT_TOT_TURNO INT, -- C�digo da situ��o total turno
	DS_SIT_TOT_TURNO VARCHAR(255),
	PRIMARY KEY (SQ_CANDIDATO, CD_ELEICAO, NR_TURNO)
);

PRINT 'Cria��o da tabela Temporaria conclu�da com sucesso!';



-- Cria��o da tabela Candidato
IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Candidato')
DROP TABLE dbo.Candidato
GO

CREATE TABLE Candidato (
	NR_TURNO INT,
	CD_ELEICAO INT,  -- C�digo da elei��o
	DS_ELEICAO VARCHAR(255),
	DT_ELEICAO VARCHAR(255),
	TP_ABRANGENCIA VARCHAR(255),
	SG_UF CHAR(10),
	SG_UE VARCHAR(255),
	CD_CARGO INT, -- C�digo do cargo
	SQ_CANDIDATO VARCHAR(50), -- Identificador �nico do candidato
	NR_CANDIDATO VARCHAR(50) NOT NULL,  -- N�mero do candidato
	NM_CANDIDATO VARCHAR(255) NOT NULL,  -- Nome completo do candidato
	NM_URNA_CANDIDATO VARCHAR(50) NOT NULL,  -- Nome do candidato na urna
	NM_SOCIAL_CANDIDATO VARCHAR(255),  -- Nome social do candidato
	NR_CPF_CANDIDATO VARCHAR(50), --UNIQUE NOT NULL,  -- CPF do candidato (�nico)
	DS_EMAIL VARCHAR(100),  -- Email do candidato
	CD_SITUACAO_CANDIDATURA INT,
	TP_AGREMIACAO VARCHAR(255),
	NR_PARTIDO INT,
	SG_UF_NASCIMENTO VARCHAR(255),
	DT_NASCIMENTO DATE,  -- Data de nascimento do candidato
	NR_TITULO_ELEITORAL_CANDIDATO CHAR(50),  -- N�mero do t�tulo eleitoral (�nico)
	CD_GENERO INT CHECK (CD_GENERO IN (2, 4, -4)),  -- C�digo do g�nero (2: Masculino, 4: Feminino)
	DS_GENERO VARCHAR(255),
	CD_GRAU_INSTRUCAO INT,  -- C�digo do grau de instru��o
	CD_ESTADO_CIVIL INT,  -- C�digo do estado civil
	DS_ESTADO_CIVIL VARCHAR(255),
	CD_COR_RACA INT,  -- C�digo da cor/ra�a
	DS_COR_RACA VARCHAR(255),
	CD_OCUPACAO INT,  -- C�digo da ocupa��o
	CD_SIT_TOT_TURNO INT, -- C�digo da situ��o total turno
	DS_SIT_TOT_TURNO VARCHAR(255),
	PRIMARY KEY (SQ_CANDIDATO, CD_ELEICAO, NR_TURNO)
);

PRINT 'Cria��o da tabela Candidato conclu�da com sucesso!';


-- Cria��o da tabela UF
IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'UF')
DROP TABLE dbo.UF
GO

CREATE TABLE UF (
    SG_UF CHAR(2) , -- Sigla da Unidade Federativa (chave prim�ria)
	SG_UE CHAR(10), -- C�digo do Munic�pio
    NM_UE VARCHAR(100) NOT NULL, -- Nome da Unidade Federativa
    PRIMARY KEY (SG_UF,SG_UE)
);

PRINT 'Cria��o da tabela UF conclu�da com sucesso!';


-- Cria��o da tabela Cargo
IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Cargo')
DROP TABLE dbo.Cargo
GO

CREATE TABLE Cargo (
    CD_CARGO INT PRIMARY KEY, -- C�digo do cargo (chave prim�ria)
    DS_CARGO VARCHAR(255) NOT NULL -- Descri��o do cargo
);

PRINT 'Cria��o da tabela Cargo conclu�da com sucesso!';

-- Cria��o da tabela Situa��o da Candidatura
IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Situacao_Candidatura')
DROP TABLE dbo.Situacao_Candidatura
GO

CREATE TABLE Situacao_Candidatura (
    CD_SITUACAO_CANDIDATURA INT PRIMARY KEY, -- C�digo da situa��o da candidatura (chave prim�ria)
    DS_SITUACAO_CANDIDATURA VARCHAR(255) NOT NULL -- Descri��o da situa��o da candidatura
);

PRINT 'Cria��o da tabela Situacao_Candidatura conclu�da com sucesso!';


-- Cria��o da tabela Partido
IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Partido')
DROP TABLE dbo.Partido
GO

CREATE TABLE Partido (
    NR_PARTIDO INT PRIMARY KEY, -- N�mero do partido (chave prim�ria)
    SG_PARTIDO CHAR(50), -- Sigla do partido
    NM_PARTIDO VARCHAR(255) NOT NULL -- Nome do partido
);

PRINT 'Cria��o da tabela Partido conclu�da com sucesso!';


-- Cria��o da tabela Grau de Instu��o
IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Grau_Instrucao')
DROP TABLE dbo.Grau_Instrucao
GO

CREATE TABLE Grau_Instrucao (
    CD_GRAU_INSTRUCAO INT PRIMARY KEY, -- C�digo do grau de instru��o (chave prim�ria)
    DS_GRAU_INSTRUCAO VARCHAR(255) NOT NULL -- Descri��o do grau de instru��o
);

PRINT 'Cria��o da tabela Grau_Instrucao conclu�da com sucesso!';


-- Cria��o da tabela Ocupa��o
IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Ocupacao')
DROP TABLE dbo.Ocupacao
GO

CREATE TABLE Ocupacao (
    CD_OCUPACAO INT PRIMARY KEY, -- C�digo da ocupa��o (chave prim�ria)
    DS_OCUPACAO VARCHAR(100) NOT NULL -- Descri��o da ocupa��o
);

PRINT 'Cria��o da tabela Ocupacao conclu�da com sucesso!';


-- Cria��o da tabela Elei��o
IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Eleicao')
DROP TABLE dbo.Eleicao
GO

CREATE TABLE Eleicao (
    ANO_ELEICAO INT,
    CD_TIPO_ELEICAO INT,
    NM_TIPO_ELEICAO VARCHAR(255),
    NR_TURNO INT,
    CD_ELEICAO INT ,  -- C�digo da elei��o
    DS_ELEICAO VARCHAR(255),
    DT_ELEICAO VARCHAR(255),
	PRIMARY KEY (CD_ELEICAO, NR_TURNO)
);

PRINT 'Cria��o da tabela Eleicao conclu�da com sucesso!';

PRINT ''
PRINT 'Fim script cria��o das tabelas da atividade 1'
