
-- Configura��o de uso do banco de dados
USE EleicaoDB;
GO

-- Carga de dados para a tabela Temporaria
IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Temporaria')
DROP TABLE dbo.Temporaria
GO

CREATE TABLE Temporaria (
    DT_GERACAO VARCHAR(255),
    HH_GERACAO VARCHAR(255),
    ANO_ELEICAO VARCHAR(255),
    CD_TIPO_ELEICAO VARCHAR(255),
    NM_TIPO_ELEICAO VARCHAR(255),
    CD_ELEICAO VARCHAR(255),
    DS_ELEICAO VARCHAR(255),
    DT_ELEICAO VARCHAR(255),
    SG_UF VARCHAR(255),
    SG_UE VARCHAR(255),
    NM_UE VARCHAR(255),
    SQ_CANDIDATO VARCHAR(50), --INT NOT NULL,  -- Identificador do candidato
    NR_ORDEM_BEM_CANDIDATO VARCHAR(50) NOT NULL,  -- N�mero da ordem do bem
    CD_TIPO_BEM_CANDIDATO VARCHAR(50),  -- C�digo do tipo de bem
	DS_TIPO_BEM_CANDIDATO VARCHAR(255), -- Descri��o do tipo de bem
    DS_BEM_CANDIDATO VARCHAR(255),  -- Descri��o do bem
    VR_BEM_CANDIDATO DECIMAL(20,2) NOT NULL, -- NUMERIC (15, 2),  -- Valor do bem
    DT_ULT_ATUAL_BEM_CANDIDATO VARCHAR(50),  -- Data da �ltima atualiza��o do bem
    HH_ULT_ATUAL_BEM_CANDIDATO VARCHAR(50),  -- Hora da �ltima atualiza��o do bem
    PRIMARY KEY (SQ_CANDIDATO, NR_ORDEM_BEM_CANDIDATO),
    CHECK (VR_BEM_CANDIDATO >= 0) -- Valor do bem n�o pode ser negativo
);



-- Cria��o da tabela Tipo de Bem
IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Tipo_Bem')
DROP TABLE dbo.Tipo_Bem
GO

CREATE TABLE Tipo_bem (
    CD_TIPO_BEM_CANDIDATO INT PRIMARY KEY, -- C�digo do tipo de bem (chave prim�ria)
    DS_TIPO_BEM_CANDIDATO VARCHAR(255) -- Descri��o do tipo de bem
);

PRINT 'Cria��o da tabela Tipo de Bem conclu�da com sucesso!';


-- Cria��o da tabela Bem do Candidato
IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Bem_Candidato')
DROP TABLE dbo.Bem_Candidato
GO

CREATE TABLE Bem_Candidato (
    ANO_ELEICAO VARCHAR(255),
    CD_TIPO_ELEICAO VARCHAR(255),
    NM_TIPO_ELEICAO VARCHAR(255),
    CD_ELEICAO VARCHAR(255),
    DS_ELEICAO VARCHAR(255),
    DT_ELEICAO VARCHAR(255),
    SG_UF VARCHAR(255),
    SG_UE VARCHAR(255),
    NM_UE VARCHAR(255),
    SQ_CANDIDATO VARCHAR(50), --INT NOT NULL,  -- Identificador do candidato
    NR_ORDEM_BEM_CANDIDATO SMALLINT NOT NULL,  -- N�mero da ordem do bem
    CD_TIPO_BEM_CANDIDATO INT,  -- C�digo do tipo de bem
    DS_BEM_CANDIDATO VARCHAR(255),  -- Descri��o do bem
    VR_BEM_CANDIDATO DECIMAL(20,2) NOT NULL,  -- Valor do bem
    DT_ULT_ATUAL_BEM_CANDIDATO DATE,  -- Data da �ltima atualiza��o do bem
    HH_ULT_ATUAL_BEM_CANDIDATO TIME,  -- Hora da �ltima atualiza��o do bem
    PRIMARY KEY (SQ_CANDIDATO, NR_ORDEM_BEM_CANDIDATO),
    CHECK (VR_BEM_CANDIDATO >= 0) -- Valor do bem n�o pode ser negativo
);

PRINT 'Cria��o da tabela Bem do Candidato conclu�da com sucesso!';

PRINT ''
PRINT 'Fim script cria��o das tabelas da atividade 2'






