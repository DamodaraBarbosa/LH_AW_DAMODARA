Lighthouse | Jornada Técnica - Dados 2024
Certificação em Dados by Indicium

🚀 Objetivo

É desenvolver um projeto prático de modelagem de dados usando *dbt* a fim de desenvolver as habilidades de transformação e modelagem de dados. O MAS (*Modern Analytics Stack*) que é uma metodologia em expansão no mundo todo e em uso por diversos times se baseia no uso dessa ferramenta.

📋 Contexto
A empresa contratou Adventure Works (AW) é uma indústria de bicicletas em franco crescimento que se orgulha de possuir mais de 500 produtos distintos, 20.000 clientes e 31.000 pedidos. Para manter seu ritmo de crescimento e se diferenciar da concorrência, a Adventure Works quer utilizar seus dados de forma estratégica, norteando suas decisões para se tornar uma empresa data driven. A diretoria da Adventure Works já listou uma série de perguntas que ela quer responder através de cruzamentos dos dados, e que devem guiar o desenvolvimento das tabelas de fatos e dimensões do data warehouse. Para iniciar o projeto e obter resultados rápidos, a opção foi iniciar pela área de vendas (sales), mas algumas tabelas de outras áreas podem ser necessárias para conseguir as informações desejadas. Em seu diagnóstico inicial, você identificou alguns sistemas que a Adventure Works utiliza e que geram dados relevantes para o negócio e que, em algum momento, devem fazer parte da infraestrutura de dados:

image


⚙️ Descrição dos dados
A Adventure Works possui um banco de dados transacional (PostgreSQL) que armazena os dados de suas diferentes áreas. Esses dados estão distribuídos em 68 tabelas divididas em 5 schemas: HR (recursos humanos), sales (vendas), production (produção) e purchasing (compras).

AdventureWorksERD

⚙️ Dicionário de dados
Para facilitar o entendimento dos dados, a Adventure Works disponibilizou um dicionário de dados necessários para seu projeto com algumas definições que eles utilizam internamente. Como o cliente utiliza atualmente relatórios exportados pelo sistema, podem ser necessárias outras tabelas para obter as informações, e cabe a você encontrar esses relacionamentos.

image (1)

image (2)

⌨️ Entregas
Diagrama conceitual do data warehouse: Modelo conceitual com as tabelas de fatos e dimensões necessárias para responder às perguntas de negócio.

Data warehouse na nuvem: Google BigQuery

Configuração e transformações de dados: DBT.

Documentação das tabelas e colunas nos marts
Testes de sources
Testes nas primary keys das tabelas de dimensão e fatos
Teste de dados
O código precisa estar em um repositório (github).
Painéis de BI: Responder as perguntas feitas anteriormente.

🛠️ Construído com:
DBT - Ferramenta de transformação de Dados
GoogleBigQuery - Data Warehouse em Nuvem
PowerBI - Ferramenta de BI.
Draw.IO - Ferramenta de Desenho e Criação de Diagramas.
✒️ Autor
Raphael Caetano da Silva - Analytics Engineering
