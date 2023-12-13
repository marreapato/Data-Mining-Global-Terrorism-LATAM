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

terror$tamanho_pais[terror$tamanho_pais==">30.000.000"] <- ">30mi"
terror$tamanho_pais[terror$tamanho_pais=="<=8000000"] <- "<=8mi"
terror$tamanho_pais[terror$tamanho_pais==">20000000 and <=30000000"] <- ">20mi and <=30mi"
terror$tamanho_pais[terror$tamanho_pais==">8000000 and <=20000000"] <- ">8mi and <=20mi"

table(terror$tamanho_pais)

quantile(terror$TimeDifference_city_event,probs = seq(0, 1, 0.1))
?quantile

terror$tempo_rel_ultimo_atk_city <- NA
terror$tempo_rel_ultimo_atk_city[terror$TimeDifference_city_event<=1] <- "<=1"
terror$tempo_rel_ultimo_atk_city[terror$TimeDifference_city_event>1&terror$TimeDifference_city_event<=20] <- ">1 and <=20"
terror$tempo_rel_ultimo_atk_city[terror$TimeDifference_city_event>20&terror$TimeDifference_city_event<=70] <- ">20 and <=70"
terror$tempo_rel_ultimo_atk_city[terror$TimeDifference_city_event>70&terror$TimeDifference_city_event<=270] <- ">70 and <=270"
terror$tempo_rel_ultimo_atk_city[terror$TimeDifference_city_event>270&terror$TimeDifference_city_event<=1170] <- ">270 and <=1170"
terror$tempo_rel_ultimo_atk_city[terror$TimeDifference_city_event>1170&terror$TimeDifference_city_event<=4510] <- ">1170 and <=4510"
terror$tempo_rel_ultimo_atk_city[terror$TimeDifference_city_event>4510&terror$TimeDifference_city_event<=7790] <- ">4510 and <=7790"
terror$tempo_rel_ultimo_atk_city[terror$TimeDifference_city_event>7790] <- ">7790"

table(terror$tempo_rel_ultimo_atk_city)

##
quantile(terror$TimeDifference_province_event,probs = seq(0, 1, 0.1))
?quantile

terror$tempo_rel_ultimo_atk_prov <- NA
terror$tempo_rel_ultimo_atk_prov[terror$TimeDifference_province_event<=1] <- "<=1"
terror$tempo_rel_ultimo_atk_prov[terror$TimeDifference_province_event>1&terror$TimeDifference_province_event<=20] <- ">1 and <=20"
terror$tempo_rel_ultimo_atk_prov[terror$TimeDifference_province_event>20&terror$TimeDifference_province_event<=30] <- ">20 and <=30"
terror$tempo_rel_ultimo_atk_prov[terror$TimeDifference_province_event>30&terror$TimeDifference_province_event<=60] <- ">30 and <=60"
terror$tempo_rel_ultimo_atk_prov[terror$TimeDifference_province_event>60&terror$TimeDifference_province_event<=140] <- ">60 and <=140"
terror$tempo_rel_ultimo_atk_prov[terror$TimeDifference_province_event>140&terror$TimeDifference_province_event<=470] <- ">140 and <=470"
terror$tempo_rel_ultimo_atk_prov[terror$TimeDifference_province_event>470] <- ">470"

table(terror$tempo_rel_ultimo_atk_prov)

##
quantile(terror$TimeDifference_country_event,probs = seq(0, 1, 0.1))
?quantile

terror$tempo_rel_ultimo_atk_count <- NA
terror$tempo_rel_ultimo_atk_count[terror$TimeDifference_country_event<=1] <- "<=1"
terror$tempo_rel_ultimo_atk_count[terror$TimeDifference_country_event>1&terror$TimeDifference_country_event<=10] <- ">1 and <=10"
terror$tempo_rel_ultimo_atk_count[terror$TimeDifference_country_event>10&terror$TimeDifference_country_event<=30] <- ">10 and <=30"
terror$tempo_rel_ultimo_atk_count[terror$TimeDifference_country_event>30] <- ">30"

table(terror$tempo_rel_ultimo_atk_count)

amvoxdados <- terror

write_sheet(amvoxdados,"https://docs.google.com/spreadsheets/d/1priwDe7UXDmy9nzbXKZTDhQG9_NOB6FZafhcmQLOTfU/edit?usp=sharing",sheet = "dados")
