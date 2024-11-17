-- Criação do banco de dados
IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = 'EleicaoDB')
BEGIN
    CREATE DATABASE EleicaoDB; -- Cria o banco de dados
END;

GO

-- Configuração de uso do banco de dados
USE EleicaoDB;
GO

-- Carga de dados para a tabela Temporária
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
	CD_ELEICAO INT,  -- Código da eleição
	DS_ELEICAO VARCHAR(255),
	DT_ELEICAO VARCHAR(255),
	TP_ABRANGENCIA VARCHAR(255),
	SG_UF CHAR(10),
	SG_UE VARCHAR(255),
	NM_UE VARCHAR(255),
	CD_CARGO INT, -- Código do cargo
	DS_CARGO VARCHAR(255),
	SQ_CANDIDATO VARCHAR(50), -- Identificador único do candidato
	NR_CANDIDATO VARCHAR(50) NOT NULL,  -- Número do candidato
	NM_CANDIDATO VARCHAR(255) NOT NULL,  -- Nome completo do candidato
	NM_URNA_CANDIDATO VARCHAR(50) NOT NULL,  -- Nome do candidato na urna
	NM_SOCIAL_CANDIDATO VARCHAR(255),  -- Nome social do candidato
	NR_CPF_CANDIDATO VARCHAR(50), --UNIQUE NOT NULL,  -- CPF do candidato (único)
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
	SQ_COLIGACAO CHAR(50), --INT,  -- Sequencial da coligação
	NM_COLIGACAO VARCHAR(255),
	DS_COMPOSICAO_COLIGACAO VARCHAR(255),
	SG_UF_NASCIMENTO VARCHAR(255),
	DT_NASCIMENTO DATE,  -- Data de nascimento do candidato
	NR_TITULO_ELEITORAL_CANDIDATO CHAR(50),  -- Número do título eleitoral (único)
	CD_GENERO INT CHECK (CD_GENERO IN (2, 4)),  -- Código do gênero (2: Masculino, 4: Feminino)
	DS_GENERO VARCHAR(255),
	CD_GRAU_INSTRUCAO INT,  -- Código do grau de instrução
	DS_GRAU_INSTRUCAO VARCHAR(255),
	CD_ESTADO_CIVIL INT,  -- Código do estado civil
	DS_ESTADO_CIVIL VARCHAR(255),
	CD_COR_RACA INT,  -- Código da cor/raça
	DS_COR_RACA VARCHAR(255),
	CD_OCUPACAO INT,  -- Código da ocupação
	DS_OCUPACAO VARCHAR(100),  -- Descrição da ocupação
	CD_SIT_TOT_TURNO INT, -- Código da situção total turno
	DS_SIT_TOT_TURNO VARCHAR(255),
	PRIMARY KEY (SQ_CANDIDATO, CD_ELEICAO, NR_TURNO)
);

PRINT 'Criação da tabela Temporaria concluída com sucesso!';



-- Criação da tabela Candidato
IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Candidato')
DROP TABLE dbo.Candidato
GO

CREATE TABLE Candidato (
	NR_TURNO INT,
	CD_ELEICAO INT,  -- Código da eleição
	DS_ELEICAO VARCHAR(255),
	DT_ELEICAO VARCHAR(255),
	TP_ABRANGENCIA VARCHAR(255),
	SG_UF CHAR(10),
	SG_UE VARCHAR(255),
	CD_CARGO INT, -- Código do cargo
	SQ_CANDIDATO VARCHAR(50), -- Identificador único do candidato
	NR_CANDIDATO VARCHAR(50) NOT NULL,  -- Número do candidato
	NM_CANDIDATO VARCHAR(255) NOT NULL,  -- Nome completo do candidato
	NM_URNA_CANDIDATO VARCHAR(50) NOT NULL,  -- Nome do candidato na urna
	NM_SOCIAL_CANDIDATO VARCHAR(255),  -- Nome social do candidato
	NR_CPF_CANDIDATO VARCHAR(50), --UNIQUE NOT NULL,  -- CPF do candidato (único)
	DS_EMAIL VARCHAR(100),  -- Email do candidato
	CD_SITUACAO_CANDIDATURA INT,
	TP_AGREMIACAO VARCHAR(255),
	NR_PARTIDO INT,
	SG_UF_NASCIMENTO VARCHAR(255),
	DT_NASCIMENTO DATE,  -- Data de nascimento do candidato
	NR_TITULO_ELEITORAL_CANDIDATO CHAR(50),  -- Número do título eleitoral (único)
	CD_GENERO INT CHECK (CD_GENERO IN (2, 4, -4)),  -- Código do gênero (2: Masculino, 4: Feminino)
	DS_GENERO VARCHAR(255),
	CD_GRAU_INSTRUCAO INT,  -- Código do grau de instrução
	CD_ESTADO_CIVIL INT,  -- Código do estado civil
	DS_ESTADO_CIVIL VARCHAR(255),
	CD_COR_RACA INT,  -- Código da cor/raça
	DS_COR_RACA VARCHAR(255),
	CD_OCUPACAO INT,  -- Código da ocupação
	CD_SIT_TOT_TURNO INT, -- Código da situção total turno
	DS_SIT_TOT_TURNO VARCHAR(255),
	PRIMARY KEY (SQ_CANDIDATO, CD_ELEICAO, NR_TURNO)
);

PRINT 'Criação da tabela Candidato concluída com sucesso!';


-- Criação da tabela UF
IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'UF')
DROP TABLE dbo.UF
GO

CREATE TABLE UF (
    SG_UF CHAR(2) , -- Sigla da Unidade Federativa (chave primária)
	SG_UE CHAR(10), -- Código do Município
    NM_UE VARCHAR(100) NOT NULL, -- Nome da Unidade Federativa
    PRIMARY KEY (SG_UF,SG_UE)
);

PRINT 'Criação da tabela UF concluída com sucesso!';


-- Criação da tabela Cargo
IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Cargo')
DROP TABLE dbo.Cargo
GO

CREATE TABLE Cargo (
    CD_CARGO INT PRIMARY KEY, -- Código do cargo (chave primária)
    DS_CARGO VARCHAR(255) NOT NULL -- Descrição do cargo
);

PRINT 'Criação da tabela Cargo concluída com sucesso!';

-- Criação da tabela Situação da Candidatura
IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Situacao_Candidatura')
DROP TABLE dbo.Situacao_Candidatura
GO

CREATE TABLE Situacao_Candidatura (
    CD_SITUACAO_CANDIDATURA INT PRIMARY KEY, -- Código da situação da candidatura (chave primária)
    DS_SITUACAO_CANDIDATURA VARCHAR(255) NOT NULL -- Descrição da situação da candidatura
);

PRINT 'Criação da tabela Situacao_Candidatura concluída com sucesso!';


-- Criação da tabela Partido
IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Partido')
DROP TABLE dbo.Partido
GO

CREATE TABLE Partido (
    NR_PARTIDO INT PRIMARY KEY, -- Número do partido (chave primária)
    SG_PARTIDO CHAR(50), -- Sigla do partido
    NM_PARTIDO VARCHAR(255) NOT NULL -- Nome do partido
);

PRINT 'Criação da tabela Partido concluída com sucesso!';


-- Criação da tabela Grau de Instução
IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Grau_Instrucao')
DROP TABLE dbo.Grau_Instrucao
GO

CREATE TABLE Grau_Instrucao (
    CD_GRAU_INSTRUCAO INT PRIMARY KEY, -- Código do grau de instrução (chave primária)
    DS_GRAU_INSTRUCAO VARCHAR(255) NOT NULL -- Descrição do grau de instrução
);

PRINT 'Criação da tabela Grau_Instrucao concluída com sucesso!';


-- Criação da tabela Ocupação
IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Ocupacao')
DROP TABLE dbo.Ocupacao
GO

CREATE TABLE Ocupacao (
    CD_OCUPACAO INT PRIMARY KEY, -- Código da ocupação (chave primária)
    DS_OCUPACAO VARCHAR(100) NOT NULL -- Descrição da ocupação
);

PRINT 'Criação da tabela Ocupacao concluída com sucesso!';


-- Criação da tabela Eleição
IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Eleicao')
DROP TABLE dbo.Eleicao
GO

CREATE TABLE Eleicao (
    ANO_ELEICAO INT,
    CD_TIPO_ELEICAO INT,
    NM_TIPO_ELEICAO VARCHAR(255),
    NR_TURNO INT,
    CD_ELEICAO INT ,  -- Código da eleição
    DS_ELEICAO VARCHAR(255),
    DT_ELEICAO VARCHAR(255),
	PRIMARY KEY (CD_ELEICAO, NR_TURNO)
);

PRINT 'Criação da tabela Eleicao concluída com sucesso!';

PRINT ''
PRINT 'Fim script criação das tabelas da atividade 1'
