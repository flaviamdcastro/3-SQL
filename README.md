# Atividade Final - SQL Engines

Este repositório contém a entrega do trabalho final para a disciplina **SQL Engines** do **MBA em Engenharia de Dados**, conforme as instruções fornecidas. O objetivo é manipular e analisar dados do **Tribunal Superior Eleitoral (TSE)** utilizando scripts SQL.

---

## 📋 Descrição do Projeto

A Sirius Corporate foi contratada para atuar em um projeto do TSE relacionado às eleições municipais de 2024. Como engenheiro(a) de dados, você será responsável por criar e manipular bancos de dados a partir de dados fornecidos pelo TSE. Este repositório inclui scripts para criação e manipulação de tabelas, consultas SQL e procedimentos armazenados baseados nos seguintes arquivos de entrada:
- **Candidato**
- **Bem de Candidato**
- **Rede Social**
- **Votação Nominal**

---

## 🏗 Estrutura do Projeto

- **`scripts/`**: Contém os scripts SQL desenvolvidos para cada atividade.
  - **`01_criacao_tabelas.sql`**: Scripts para criação das tabelas de acordo com as especificações.
  - **`02_insercao_dados.sql`**: Scripts para inserção dos dados nas tabelas criadas.
  - **`03_consultas_analiticas.sql`**: Consultas SQL para análise e ranking dos dados.
  - **`04_procedures_views.sql`**: Criação de views e procedures solicitadas.
- **`documentacao/`**: Inclui a documentação em PDF ou slides que detalham o desenvolvimento e execução.
- **`README.md`**: Arquivo atual contendo a descrição do projeto.

---

## 🛠 Atividades Desenvolvidas

### Atividade 01: Criação de Tabelas
Criação das tabelas relacionadas ao arquivo **Candidato**:
- **Candidato**
- **UF**
- **Cargo**
- **Situação Candidatura**
- **Partido**
- **Grau de Instrução**
- **Ocupação**
- **Eleição**

**Entregáveis**:
- Script para criação das tabelas.
- Script para inserção dos registros.

---

### Atividade 02: Tabelas para Bens de Candidato
Criação das tabelas relacionadas ao arquivo **Bem de Candidato**:
- **Bens de Candidato**
- **Tipo de Bem**
- **UF** (aproveitada da Atividade 01)
- **Eleição** (aproveitada da Atividade 01)

**Entregáveis**:
- Script para criação das tabelas.
- Script para inserção dos registros.

---

### Atividade 03: Tabelas para Rede Social
Criação das tabelas relacionadas ao arquivo **Rede Social**:
- **Rede Social**
- **Tipo de Rede Social**
- **UF** (aproveitada da Atividade 01)
- **Eleição** (aproveitada da Atividade 01)
- **Candidato** (aproveitada da Atividade 01)

**Entregáveis**:
- Script para criação das tabelas.
- Script para inserção dos registros.

---

### Atividade 04: Tabelas para Votação
Criação das tabelas relacionadas ao arquivo **Votação**:
- **Votação**
- **Partido**
- **Situação Turno**
- **UF** (aproveitada da Atividade 01)
- **Eleição** (aproveitada da Atividade 01)
- **Candidato** (aproveitada da Atividade 01)

**Entregáveis**:
- Script para criação das tabelas.
- Script para inserção dos registros.

---

### Atividade 05: Ranking por Estado
Consulta que lista o número total de candidatos ao cargo de **Vereador** por estado, ordenando do maior para o menor.

---

### Atividade 06: Contagem de Votos por Cidade
Consulta para contabilizar os votos da cidade de residência para o cargo de **Prefeito**, incluindo a situação do turno.

---

### Atividade 07: Análise de Bens de Candidato
Consulta que analisa o patrimônio total dos candidatos aos cargos de **Vereador**, **Prefeito** e **Vice-Prefeito**, classificando-os conforme o valor total:
- **Patrimônio Normal**: Até R$ 999.999,99.
- **Patrimônio Milionário**: De R$ 1.000.000,00 até R$ 999.999.999,99.
- **Patrimônio Bilionário**: Acima de R$ 1.000.000.000,00.

---

### Atividade 08: Ranking de Eleitos
Consulta que identifica os candidatos eleitos ao cargo de **Vereador** e cria um ranking com base no número de votos.

---

### Atividade 09: Criação de View
Criação de uma view para exibir as informações completas dos candidatos, incluindo:
- Ocupação.
- Partido.
- Quantidade de votos.
- Valor total dos bens.
- Links das redes sociais.

---

### Atividade 10: Procedure com Parâmetro
Criação de uma procedure que recebe como parâmetro a sigla da UF e exibe:
- Informações dos candidatos.
- Valor total dos bens.
- URL das redes sociais.

---

## 📊 Links e Dados Utilizados
Os dados foram obtidos do **Tribunal Superior Eleitoral (TSE)** e estão disponíveis nos links:
- [Candidatos 2024](https://dadosabertos.tse.jus.br/dataset/candidatos-2024)
- [Resultados 2024](https://dadosabertos.tse.jus.br/dataset/resultados-2024/resource/c5e1bff9-98f1-4d3b-b944-37cd22c84112)

---

## 📝 Observações
- A entrega está organizada conforme o solicitado, com um script SQL para cada atividade.
