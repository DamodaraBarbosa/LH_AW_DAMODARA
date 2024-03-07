Lighthouse | Jornada Técnica - Dados 2024

Projeto de Dados by Indicium

🚀 Objetivo

É desenvolver um projeto prático de modelagem de dados usando *dbt* a fim de desenvolver as habilidades de transformação e modelagem de dados. O MAS (*Modern Analytics Stack*) que é uma metodologia em expansão no mundo todo e em uso por diversos times se baseia no uso dessa ferramenta.

📋 Contexto
A empresa contratou Adventure Works (AW) é uma indústria de bicicletas em franco crescimento que se orgulha de possuir mais de 500 produtos distintos, 20.000 clientes e 31.000 pedidos. Para manter seu ritmo de crescimento e se diferenciar da concorrência, a Adventure Works quer utilizar seus dados de forma estratégica, norteando suas decisões para se tornar uma empresa data driven. A diretoria da Adventure Works já listou uma série de perguntas que ela quer responder através de cruzamentos dos dados, e que devem guiar o desenvolvimento das tabelas de fatos e dimensões do data warehouse. Para iniciar o projeto e obter resultados rápidos, a opção foi iniciar pela área de vendas (sales), mas algumas tabelas de outras áreas podem ser necessárias para conseguir as informações desejadas. Em seu diagnóstico inicial, você identificou alguns sistemas que a Adventure Works utiliza e que geram dados relevantes para o negócio e que, em algum momento, devem fazer parte da infraestrutura de dados:

![image](https://github.com/DamodaraBarbosa/LH_AW_DAMODARA/assets/107199898/5c2e5c69-b8d5-41e5-a6f1-0fda2d22812f)

⚙️ Descrição dos dados
A Adventure Works possui um banco de dados transacional (PostgreSQL) que armazena os dados de suas diferentes áreas. Esses dados estão distribuídos em 68 tabelas divididas em 5 schemas: HR (recursos humanos), sales (vendas), production (produção) e purchasing (compras).

![image](https://github.com/DamodaraBarbosa/LH_AW_DAMODARA/assets/107199898/908b1c10-60aa-4d1f-b449-6f4c81ebe0eb)

⚙️ Dicionário de dados
Para facilitar o entendimento dos dados, a Adventure Works disponibilizou um dicionário de dados necessários para seu projeto com algumas definições que eles utilizam internamente. Como o cliente utiliza atualmente relatórios exportados pelo sistema, podem ser necessárias outras tabelas para obter as informações, e cabe a você encontrar esses relacionamentos.

![image](https://github.com/DamodaraBarbosa/LH_AW_DAMODARA/assets/107199898/6a8ed232-8763-4d5b-a3a4-5b367f5969db)

![image](https://github.com/DamodaraBarbosa/LH_AW_DAMODARA/assets/107199898/1138b90b-38ab-44da-9206-f1da44f4fe23)

📊 Etapas

* Foi feito o *fork* no ![repositório](https://github.com/techindicium/academy-dbt) e a partir dos *seeds* usando o `dbt cloud` os dados *raw* foram carregados no *BigQuery*.

![image](https://github.com/DamodaraBarbosa/LH_AW_DAMODARA/assets/107199898/9ce5bfab-f9c9-4800-94cd-f065d907f0d5)

* Definição das tabelas source no arquivo source.yml.
  
* Criação das *stagings* das tabelas. A figura mostra um exemplo, no caso a *staging* de produtos.

  ![image](https://github.com/DamodaraBarbosa/LH_AW_DAMODARA/assets/107199898/0448954c-1a5f-413a-95e1-5eef0dbfd2aa)

* Após a criação das *stagins*, estas foram utilizadas para definição das fatos e dimensões:

 ![image](https://github.com/DamodaraBarbosa/LH_AW_DAMODARA/assets/107199898/2b13ca26-e6b2-4185-93d7-10e0362f06c8)

 * E as tabelas foram documentadas utilizando arquivos .yml

   ![image](https://github.com/DamodaraBarbosa/LH_AW_DAMODARA/assets/107199898/5423f6d0-6a8b-4e76-a5ea-844c2960e1bb)

* Ao rodar os testes, todos passaram, inclusive o teste de dados:

 ![image](https://github.com/DamodaraBarbosa/LH_AW_DAMODARA/assets/107199898/0f85359b-fc00-4fef-b18f-783ec6a62285)

Com os dados transformados e testados, as fatos e dimensões foram subidas para o *BigQuery* e a partir daí a fonte de dados foi conectada ao *Power BI* e ao *Google Colab*.

⌨️ Entregas
Diagrama conceitual do data warehouse: Modelo conceitual com as tabelas de fatos e dimensões necessárias para responder às perguntas de negócio.

Data warehouse na nuvem: Google BigQuery

Configuração e transformações de dados: DBT.

Estimativa de demanda com séries temporais.

Documentação das tabelas e colunas nos marts
Testes de schema
Teste de dados
O código precisa estar em um repositório (github).

🛠️ Construído com:
DBT - Ferramenta de transformação de Dados
GoogleBigQuery - Data Warehouse em Nuvem
PowerBI - Ferramenta de BI.
Google Colab - ambiente de desenvolvimento python
Draw.IO - Ferramenta de Desenho e Criação de Diagramas.

✒️ Autor
Damodara Barbosa - Analista de Dados
