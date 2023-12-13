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

terror$TimeDifference_city_event_ano <- ceiling(terror$TimeDifference_city_event/365.25)
terror$TimeDifference_country_event_ano <- ceiling(terror$TimeDifference_country_event/365.25)
terror$TimeDifference_province_event_ano <- ceiling(terror$TimeDifference_province_event/365.25)

quantile(ceiling(terror$TimeDifference_city_event/365.25))
quantile(ceiling(terror$TimeDifference_country_event/365.25))
quantile(ceiling(terror$TimeDifference_province_event/365.25))

terror$tempo_rel_ultimo_atk_city_ano <- NA
terror$tempo_rel_ultimo_atk_city_ano[terror$TimeDifference_city_event_ano<=1] <- "1 ano ou menos"
terror$tempo_rel_ultimo_atk_city_ano[terror$TimeDifference_city_event_ano>1&terror$TimeDifference_city_event_ano<=9] <- "2 a 9 anos"
terror$tempo_rel_ultimo_atk_city_ano[terror$TimeDifference_city_event_ano>9] <- "10 anos ou mais"

terror$ataque_ult_ano_provincia <- NA
terror$ataque_ult_ano_provincia[terror$TimeDifference_province_event<=1] <- 1
terror$ataque_ult_ano_provincia[terror$TimeDifference_province_event>1] <- 0

table(terror$ataque_ult_ano_provincia)

##
quantile(terror$TimeDifference_country_event,probs = seq(0, 1, 0.1))
?quantile

terror$ataque_ult_ano_pais <- NA
terror$ataque_ult_ano_pais[terror$TimeDifference_country_event<=1] <- 1
terror$ataque_ult_ano_pais[terror$TimeDifference_country_event>1] <- 0

table(terror$ataque_ult_ano_pais)

amvoxdados <- terror

write_sheet(amvoxdados,"https://docs.google.com/spreadsheets/d/1priwDe7UXDmy9nzbXKZTDhQG9_NOB6FZafhcmQLOTfU/edit?usp=sharing",sheet = "dados")
