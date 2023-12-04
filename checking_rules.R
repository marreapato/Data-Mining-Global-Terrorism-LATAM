library(googlesheets4)
library(tidyverse)


dados <- read_sheet("https://docs.google.com/spreadsheets/d/1priwDe7UXDmy9nzbXKZTDhQG9_NOB6FZafhcmQLOTfU/edit#gid=587864036","dados")

nrow(dados)
table(dados$success)/nrow(dados)
#rule 1
table(dados$tamanho_pais)
dado30 <- dados %>% filter(tamanho_pais=="mais de 30mi")
table(dado30$success)/nrow(dado30)

dado30higher <- dado30 %>% filter(popgrow_higher_than_latam==0)
table(dado30higher$success)/nrow(dado30higher)

dado30higherele <- dado30higher %>% filter(eleicaonacionaldireta==1)
table(dado30higherele$success)/nrow(dado30higherele)

dado30higherelefr <- dado30higherele %>% filter(weekday=="Friday")
table(dado30higherelefr$success)/nrow(dado30higherelefr)

#2 regra

dado30highercap <- dado30higher %>% filter(CidadeOuCapital==1)
table(dado30highercap$success)/nrow(dado30highercap)

#3 regra

dadocap <- dados %>% filter(CidadeOuCapital==1)
table(dadocap$success)/nrow(dadocap)

dadocapgr1 <- dadocap %>% filter(popgrow_higher_than_latam==1)
table(dadocapgr1$success)/nrow(dadocapgr1)

dadocapgr1820 <- dadocapgr1 %>% filter(tamanho_pais=="entre 8mi e 20mi")
table(dadocapgr1820$success)/nrow(dadocapgr1820)

dadocapgr1820atq <- dadocapgr1820 %>% filter(ataque_ult_ano_provincia==1)
table(dadocapgr1820atq$success)/nrow(dadocapgr1820atq)

dadocapgr1820atqth <- dadocapgr1820atq %>% filter(weekday=="Thursday")
table(dadocapgr1820atqth$success)/nrow(dadocapgr1820atqth)

dadocapgr1820atqthele <- dadocapgr1820atqth %>% filter(eleicaonacionaldireta==1)
table(dadocapgr1820atqthele$success)/nrow(dadocapgr1820atqthele)

#4 regra

dado30higheratqp <- dado30higher %>% filter(ataque_ult_ano_pais==1)
table(dado30higheratqp$success)/nrow(dado30higheratqp)

dado30higheratqpwed <- dado30higheratqp %>% filter(weekday=="Wednesday")
table(dado30higheratqpwed$success)/nrow(dado30higheratqpwed)

dado30higheratqpwedatq <- dado30higheratqpwed %>% filter(ataque_ult_ano_provincia==1)
table(dado30higheratqpwedatq$success)/nrow(dado30higheratqpwedatq)

dado30higheratqpwedatqcit <- dado30higheratqpwedatq %>% filter(CidadeOuCapital==0)
table(dado30higheratqpwedatqcit$success)/nrow(dado30higheratqpwedatqcit)

dado30higheratqpwedatqcitnel <- dado30higheratqpwedatqcit %>% filter(eleicaonacionaldireta==0)
table(dado30higheratqpwedatqcitnel$success)/nrow(dado30higheratqpwedatqcitnel)

dado30higheratqpwedatqcitnelatqc <- dado30higheratqpwedatqcitnel %>% filter(tempo_rel_ultimo_atk_city_ano=="1 ano ou menos")
table(dado30higheratqpwedatqcitnelatqc$success)/nrow(dado30higheratqpwedatqcitnelatqc)

dado30higheratqpwedatqcitnelatqcfer <- dado30higheratqpwedatqcitnelatqc %>% filter(feriado_oucomemo==0)
table(dado30higheratqpwedatqcitnelatqcfer$success)/nrow(dado30higheratqpwedatqcitnelatqcfer)
