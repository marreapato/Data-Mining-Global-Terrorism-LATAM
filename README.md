# Terrorismo Na América Latina

Trabalho da disciplina de Mineração de Dados - Mestrado Acadêmico do CIN UFPE

Este estudo aborda a aplicacão de mineracão de dados para apoiar decisões no combate ao terrorismo na América Latina.
Utilizando o Global Terrorism Database, foram analisados eventos ocorridos desde 1970 em 19 países.
A abordagem incluiu a construcão de modelos, como regressão logística e  ́arvores de decisão
para identificar fatores associados ao sucesso ou fracasso no combate a ataques terroristas.

[Categorização para Discussão de Colunas](https://docs.google.com/document/d/1N_wlQe09FwuMtrLqvffWfsGjZydI7bDjnUkyN1y92N4/edit?usp=sharing)

[Planilha de Artigos e Literatura](https://docs.google.com/spreadsheets/d/1-RdvLGwixrCfm9mDJd3DG8yOw0WFIPZi_hydZfRgOL4/edit?usp=sharing)

[Dados](https://docs.google.com/spreadsheets/d/1priwDe7UXDmy9nzbXKZTDhQG9_NOB6FZafhcmQLOTfU/edit#gid=587864036)

[DataMart](https://docs.google.com/spreadsheets/d/1aXMHsjPRV39VNZNo6kS6jU3FkGrysVV_sukEQz_1Cso/edit#gid=0)

[KPIs](https://docs.google.com/spreadsheets/d/19gj4KdpuyoUhdHa77sLSxh5dut5Qshsqbq06UWon_Ys/edit#gid=353932470)

[Apresentação](https://docs.google.com/presentation/d/141zi0sUzdnzKpSh2uZtMI7pIPQB5LIeS5BpcS81yFgk/edit?usp=sharing)

Os Scripts etão ordenados na ordem sugerida, no entanto eles foram apenas utilizados para construir a planilha de [dados](https://docs.google.com/spreadsheets/d/1priwDe7UXDmy9nzbXKZTDhQG9_NOB6FZafhcmQLOTfU/edit#gid=587864036) que já está disponibilizada no [link](https://docs.google.com/spreadsheets/d/1priwDe7UXDmy9nzbXKZTDhQG9_NOB6FZafhcmQLOTfU/edit#gid=587864036).

# Global Terrorism Database na América Latina

## Introdução
O terrorismo é uma ameaça global que impacta a estabilidade de países e regiões. O Global Terrorism Database (GTD), desenvolvido pelo START - Study of Terrorism and Responses to Terrorism, é um banco de dados abrangente com mais de 200.000 registros de incidentes terroristas em todo o mundo desde 1970 \cite{codebook}. Este projeto se concentra na América Latina, explorando como a mineração de dados pode ser uma ferramenta eficaz para apoiar as autoridades antiterrorismo na região.

## Objetivo
O objetivo principal é analisar 10.000 incidentes terroristas em 19 países da América Latina, utilizando o GTD. A abordagem inclui a aplicação de técnicas de mineração de dados e Descoberta do Conhecimento em Bases de Dados (KDD) para fornecer insights que auxiliem as autoridades na tomada de decisões estratégicas e táticas.

## Materiais e Métodos
### Base de Dados
- Utilização da base de dados do GTD fornecida pelo START.
- Amostra de 10.000 incidentes em 19 países da América Latina.
- Variáveis incluem informações sobre data, tipo de ataque, grupo perpetrador, tipo de alvo e sucesso do ataque.

### Processo de Mineração
- Utilização do modelo CRISP-DM (CRoss Industry Standard Process for Data Mining).
- Linguagens de programação: R para limpeza e seleção de amostra, Python para análises estatísticas e Javascript para informações sobre feriados.

### Coleta de Informações
- Integração de dados do Banco Mundial para informações socioeconômicas.
- Utilização da biblioteca date-holidays para dados sobre feriados públicos.
- Construção de Datamart para informações específicas de cada país.

### Variáveis do Dataset
- Descrição detalhada das variáveis, incluindo sucesso do combate, número de mortes, feridos, reféns, entre outras.

### Modelos Utilizados
- Árvores de decisão e algoritmo JRip para extração de conhecimento.
- Regressão logística para suporte à decisão.
- Métricas de avaliação incluem Lift, Confiança e Cobertura.

## KNIME
- Utilização da ferramenta KNIME para implementação dos modelos.
- Workflow inclui fluxos para a regressão logística e regras de indução.

## Resultados
- Fornecimento de insights sobre padrões de ataques terroristas na América Latina.
- Avaliação da eficácia de medidas antiterrorismo com base nas análises.

## Conclusão
Este projeto destaca a importância da mineração de dados na análise de incidentes terroristas na América Latina, fornecendo suporte à tomada de decisões das autoridades antiterrorismo. A utilização do GTD e técnicas avançadas de análise demonstram ser ferramentas valiosas para compreender e combater ameaças terroristas na região.
