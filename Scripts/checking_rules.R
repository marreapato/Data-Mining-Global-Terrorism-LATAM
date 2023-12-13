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

#rule 5

dadocapgr0 <- dadocap %>% filter(popgrow_higher_than_latam==0)
table(dadocapgr0$success)/nrow(dadocapgr0)

dadocapgr08mi <- dadocapgr0 %>% filter(tamanho_pais=="menor ou igual a 8mi")
table(dadocapgr08mi$success)/nrow(dadocapgr08mi)


dadocapgr08mimil <- dadocapgr08mi %>% filter(ChefedeGovernoMilitar==0)
table(dadocapgr08mimil$success)/nrow(dadocapgr08mimil)

dadocapgr08mimilfr <- dadocapgr08mimil %>% filter(weekday=="Friday")
table(dadocapgr08mimilfr$success)/nrow(dadocapgr08mimilfr)
#rule 6 made already in slide

#rule 7

dadocapatqp<- dadocapgr1 %>% filter(ataque_ult_ano_pais==0)
table(dadocapatqp$success)/nrow(dadocapatqp)

dadocapatqp8mi<- dadocapatqp %>% filter(tamanho_pais=="menor ou igual a 8mi")
table(dadocapatqp8mi$success)/nrow(dadocapatqp8mi)

dadocapatqp8mimil<- dadocapatqp8mi %>% filter(ChefedeGovernoMilitar==0)
table(dadocapatqp8mimil$success)/nrow(dadocapatqp8mimil)

dadocapatqp8mimilcit <- dadocapatqp8mimil %>% filter(tempo_rel_ultimo_atk_city_ano=="2 a 9 anos")
table(dadocapatqp8mimilcit$success)/nrow(dadocapatqp8mimilcit)

dadocapatqp8mimilcitele <- dadocapatqp8mimilcit %>% filter(eleicaonacionaldireta==0)
table(dadocapatqp8mimilcitele$success)/nrow(dadocapatqp8mimilcitele)

#rule 8

dado30highereletu <- dado30higherele %>% filter(weekday=="Tuesday")
table(dado30highereletu$success)/nrow(dado30highereletu)

dado30highereletu10mais <- dado30highereletu %>% filter(tempo_rel_ultimo_atk_city_ano=="10 anos ou mais")
table(dado30highereletu10mais$success)/nrow(dado30highereletu10mais)


#rule 9


dadocapatqpmil<- dadocapatqp %>% filter(ChefedeGovernoMilitar==0)
table(dadocapatqpmil$success)/nrow(dadocapatqpmil)

dadocapatqpmil8mi<- dadocapatqpmil %>% filter(tamanho_pais=="menor ou igual a 8mi")
table(dadocapatqpmil8mi$success)/nrow(dadocapatqpmil8mi)

dadocapatqpmil8miwee <- dadocapatqpmil8mi %>% filter(weekday=="Tuesday")
table(dadocapatqpmil8miwee$success)/nrow(dadocapatqpmil8miwee)

#rule 10

dado30higheratqpwsat <- dado30higheratqp %>% filter(weekday=="Saturday")
table(dado30higheratqpwsat$success)/nrow(dado30higheratqpwsat)

dado30higheratqpwsat1men <- dado30higheratqpwsat %>% filter(tempo_rel_ultimo_atk_city_ano=="1 ano ou menos")
table(dado30higheratqpwsat1men$success)/nrow(dado30higheratqpwsat1men)

dado30higheratqpwsat1menprv <- dado30higheratqpwsat1men %>% filter(ataque_ult_ano_provincia==1)
table(dado30higheratqpwsat1menprv$success)/nrow(dado30higheratqpwsat1menprv)

dado30higheratqpwsat1menprvcit <- dado30higheratqpwsat1menprv %>% filter(CidadeOuCapital==1)
table(dado30higheratqpwsat1menprvcit$success)/nrow(dado30higheratqpwsat1menprvcit)

#rule 11

dado30higher1an <- dado30higher %>% filter(tempo_rel_ultimo_atk_city_ano=="1 ano ou menos")
table(dado30higher1an$success)/nrow(dado30higher1an)

dado30higher1anatq <- dado30higher1an %>% filter(ataque_ult_ano_provincia==1)
table(dado30higher1anatq$success)/nrow(dado30higher1anatq)


#rule 12 done

#rule 13


dado30higheratqpcap0 <- dado30higheratqp %>% filter(CidadeOuCapital==0)
table(dado30higheratqpcap0$success)/nrow(dado30higheratqpcap0)

dado30higheratqpcap0ele <- dado30higheratqpcap0 %>% filter(eleicaonacionaldireta==1)
table(dado30higheratqpcap0ele$success)/nrow(dado30higheratqpcap0ele)

dado30higheratqpcap0eleprv <- dado30higheratqpcap0ele %>% filter(ataque_ult_ano_provincia==0)
table(dado30higheratqpcap0eleprv$success)/nrow(dado30higheratqpcap0eleprv)

#rule 14

dadocapgr1820wed <- dadocapgr1820 %>% filter(weekday=="Wednesday")
table(dadocapgr1820wed$success)/nrow(dadocapgr1820wed)


dadocapgr1820wedatq <- dadocapgr1820wed %>% filter(ataque_ult_ano_pais==1)
table(dadocapgr1820wedatq$success)/nrow(dadocapgr1820wedatq)
