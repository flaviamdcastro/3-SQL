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
    ANO_ELEICAO VARCHAR(50),
    CD_TIPO_ELEICAO VARCHAR(50),
    NM_TIPO_ELEICAO VARCHAR(255),
    NR_TURNO VARCHAR(50),  -- N�mero do turno
    CD_ELEICAO VARCHAR(50) NOT NULL,  -- C�digo da elei��o
    DS_ELEICAO VARCHAR(255),
    DT_ELEICAO VARCHAR(255),
    TP_ABRANGENCIA VARCHAR(255),
    SG_UF VARCHAR(255),
    SG_UE VARCHAR(255),
    NM_UE VARCHAR(255),
    CD_MUNICIPIO VARCHAR(50) NOT NULL,  -- C�digo do munic�pio
    NM_MUNICIPIO VARCHAR(255),
    NR_ZONA VARCHAR(50),  -- N�mero da zona eleitoral
    CD_CARGO VARCHAR(50),
    DS_CARGO VARCHAR(255),
    SQ_CANDIDATO VARCHAR(50) NOT NULL, --INT NOT NULL,  -- Identificador do candidato
    NR_CANDIDATO VARCHAR(50),
    NM_CANDIDATO VARCHAR(255),
    NM_URNA_CANDIDATO VARCHAR(255),
    NM_SOCIAL_CANDIDATO VARCHAR(255),
	CD_SITUACAO_CANDIDATURA VARCHAR(50),
	DS_SITUACAO_CANDIDATURA VARCHAR(255),
    CD_DETALHE_SITUACAO_CAND VARCHAR(50),
    DS_DETALHE_SITUACAO_CAND VARCHAR(255),
    CD_SITUACAO_JULGAMENTO VARCHAR(50),
    DS_SITUACAO_JULGAMENTO VARCHAR(255),
    CD_SITUACAO_CASSACAO VARCHAR(50),
    DS_SITUACAO_CASSACAO VARCHAR(255),
    CD_SITUACAO_DIPLOMA varchar(50),
    DS_SITUACAO_DIPLOMA VARCHAR(255),
    TP_AGREMIACAO VARCHAR(255),
    NR_PARTIDO varchar(50),
    SG_PARTIDO VARCHAR(255),
    NM_PARTIDO VARCHAR(255),
    NR_FEDERACAO VARCHAR(50),
    NM_FEDERACAO VARCHAR(255),
    SG_FEDERACAO VARCHAR(255),
    DS_COMPOSICAO_FEDERACAO VARCHAR(255),
    SQ_COLIGACAO VARCHAR(50), --INT,
    NM_COLIGACAO VARCHAR(255),
    DS_COMPOSICAO_COLIGACAO VARCHAR(255),
    ST_VOTO_EM_TRANSITO VARCHAR(50), --INT,  -- Indicador de voto em tr�nsito (1 = Sim, 0 = N�o)
    QT_VOTOS_NOMINAIS VARCHAR(50),  -- Quantidade de votos nominais
    NM_TIPO_DESTINACAO_VOTOS VARCHAR(255),
    QT_VOTOS_NOMINAIS_VALIDOS VARCHAR(50),  -- Quantidade de votos v�lidos
    CD_SIT_TOT_TURNO VARCHAR(50),  -- C�digo da situa��o total do turno
    DS_SIT_TOT_TURNO VARCHAR(50),  -- Descri��o da situa��o total do turno
    PRIMARY KEY (SQ_CANDIDATO, CD_ELEICAO, NR_TURNO, NR_ZONA),
);


-- Carga de dados para a tabela Situa��o no turmo
IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Situacao_Turno')
DROP TABLE dbo.Situacao_Turno
GO

CREATE TABLE Situacao_Turno (
    CD_SIT_TOT_TURNO VARCHAR(50),  -- C�digo da situa��o total do turno
    DS_SIT_TOT_TURNO VARCHAR(50),  -- Descri��o da situa��o total do turno
    PRIMARY KEY (CD_SIT_TOT_TURNO),
);

PRINT 'Cria��o da tabela Ocupacao conclu�da com sucesso!';


-- Carga de dados para a tabela Vota��o Nominal por Municipio e Zona
IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Votacao')
DROP TABLE dbo.Votacao
GO

CREATE TABLE Votacao (
    ANO_ELEICAO VARCHAR(50),
    CD_TIPO_ELEICAO VARCHAR(50),
    NR_TURNO VARCHAR(50),  -- N�mero do turno
    CD_ELEICAO VARCHAR(50) NOT NULL,  -- C�digo da elei��o
    TP_ABRANGENCIA VARCHAR(255),
    SG_UF VARCHAR(255),
    SG_UE VARCHAR(255),
    CD_MUNICIPIO VARCHAR(50) NOT NULL,  -- C�digo do munic�pio
    NR_ZONA VARCHAR(50),  -- N�mero da zona eleitoral
    CD_CARGO VARCHAR(50),
    SQ_CANDIDATO VARCHAR(50) NOT NULL, --INT NOT NULL,  -- Identificador do candidato
    CD_SITUACAO_CANDIDATURA VARCHAR(50),
    DS_SITUACAO_CANDIDATURA VARCHAR(255),
    CD_DETALHE_SITUACAO_CAND VARCHAR(50),
    DS_DETALHE_SITUACAO_CAND VARCHAR(255),
    CD_SITUACAO_JULGAMENTO VARCHAR(50),
    DS_SITUACAO_JULGAMENTO VARCHAR(255),
    CD_SITUACAO_CASSACAO VARCHAR(50),
    DS_SITUACAO_CASSACAO VARCHAR(255),
    CD_SITUACAO_DIPLOMA varchar(50),
    DS_SITUACAO_DIPLOMA VARCHAR(255),
    TP_AGREMIACAO VARCHAR(255),
    NR_PARTIDO varchar(50),
    SG_FEDERACAO VARCHAR(255),
    SQ_COLIGACAO VARCHAR(255),
    ST_VOTO_EM_TRANSITO VARCHAR(50), --INT,  -- Indicador de voto em tr�nsito (1 = Sim, 0 = N�o)
    QT_VOTOS_NOMINAIS VARCHAR(50),  -- Quantidade de votos nominais
    NM_TIPO_DESTINACAO_VOTOS VARCHAR(255),
    QT_VOTOS_NOMINAIS_VALIDOS VARCHAR(50),  -- Quantidade de votos v�lidos
    CD_SIT_TOT_TURNO VARCHAR(50),  -- C�digo da situa��o total do turno
    PRIMARY KEY (SQ_CANDIDATO, CD_ELEICAO, NR_TURNO, NR_ZONA),
);

PRINT 'Cria��o da tabela Votacao conclu�da com sucesso!';

PRINT ''
PRINT 'Fim script cria��o das tabelas da atividade 4'
