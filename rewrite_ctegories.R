library(readxl)
library(DT)
library(tidyverse)
library(data.table)
library(stringr)#string manipulation

library(googlesheets4)
gs4_deauth()

gs4_auth()

#calling data
terror <- read_sheet("https://docs.google.com/spreadsheets/d/1priwDe7UXDmy9nzbXKZTDhQG9_NOB6FZafhcmQLOTfU/edit?usp=sharing",sheet = "dados")

terror$tamanho_pais[terror$tamanho_pais==">30mi"] <- "mais de 30mi"
terror$tamanho_pais[terror$tamanho_pais=="<=8mi"] <- "menor ou igual a 8mi"
terror$tamanho_pais[terror$tamanho_pais==">20mi and <=30mi"] <- "entre 20mi e 30mi"
terror$tamanho_pais[terror$tamanho_pais==">8mi and <=20mi"] <- "entre 8mi e 20mi"

table(terror$tamanho_pais)

quantile(terror$TimeDifference_city_event,probs = seq(0, 1, 0.1))
?quantile

terror$tempo_rel_ultimo_atk_city <- NA
terror$tempo_rel_ultimo_atk_city[terror$tempo_rel_ultimo_atk_city=="<=1"] <- "menor ou igual a 1"
terror$tempo_rel_ultimo_atk_city[terror$tempo_rel_ultimo_atk_city==">1 and <=20"] <- "entre 1 e 20"
terror$tempo_rel_ultimo_atk_city[terror$tempo_rel_ultimo_atk_city==">20 and <=70"] <- "entre 20 e 70"
terror$tempo_rel_ultimo_atk_city[terror$tempo_rel_ultimo_atk_city==">70 and <=270"] <- "entre 70 e 270"
terror$tempo_rel_ultimo_atk_city[terror$tempo_rel_ultimo_atk_city==">270 and <=1170"] <- "entre 270 e 1170"
terror$tempo_rel_ultimo_atk_city[terror$tempo_rel_ultimo_atk_city==">1170 and <=4510"] <- "entre 1170 e 4510"
terror$tempo_rel_ultimo_atk_city[terror$tempo_rel_ultimo_atk_city==">4510 and <=7790"] <- "entre 4510 e 7790"
terror$tempo_rel_ultimo_atk_city[terror$tempo_rel_ultimo_atk_city==">7790"] <- "mais de 7790"

table(terror$tempo_rel_ultimo_atk_city)

##
quantile(terror$TimeDifference_province_event,probs = seq(0, 1, 0.1))
?quantile

terror$tempo_rel_ultimo_atk_prov <- NA
terror$tempo_rel_ultimo_atk_prov[terror$tempo_rel_ultimo_atk_prov=="<=1"] <- "menor ou igual a 1"
terror$tempo_rel_ultimo_atk_prov[terror$tempo_rel_ultimo_atk_prov==">1 and <=20"] <- "entre 1 e 20"
terror$tempo_rel_ultimo_atk_prov[terror$tempo_rel_ultimo_atk_prov==">20 and <=30"] <- "entre 20 e 30"
terror$tempo_rel_ultimo_atk_prov[terror$tempo_rel_ultimo_atk_prov==">30 and <=60"] <- "entre 30 e 60"
terror$tempo_rel_ultimo_atk_prov[terror$tempo_rel_ultimo_atk_prov==">60 and <=140"] <- "entre 60 e 140"
terror$tempo_rel_ultimo_atk_prov[terror$tempo_rel_ultimo_atk_prov==">140 and <=470"] <- "entre 140 e 470"
terror$tempo_rel_ultimo_atk_prov[terror$tempo_rel_ultimo_atk_prov==">470"] <- "mais de 470"

table(terror$tempo_rel_ultimo_atk_prov)

##
quantile(terror$TimeDifference_country_event,probs = seq(0, 1, 0.1))
?quantile

terror$tempo_rel_ultimo_atk_count <- NA
terror$tempo_rel_ultimo_atk_count[terror$tempo_rel_ultimo_atk_count=="<=1"] <- "menor ou igual a 1"
terror$tempo_rel_ultimo_atk_count[terror$tempo_rel_ultimo_atk_count==">1 and <=10"] <- "entre 1 e 10"
terror$tempo_rel_ultimo_atk_count[terror$tempo_rel_ultimo_atk_count==">10 and <=30"] <- "entre 10 e 30"
terror$tempo_rel_ultimo_atk_count[terror$tempo_rel_ultimo_atk_count==">30"] <- "mais de 30"

table(terror$tempo_rel_ultimo_atk_count)

amvoxdados <- terror

write_sheet(amvoxdados,"https://docs.google.com/spreadsheets/d/1priwDe7UXDmy9nzbXKZTDhQG9_NOB6FZafhcmQLOTfU/edit?usp=sharing",sheet = "dados")
