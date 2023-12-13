#precisamos de algo que justifique a estratificação por região
library(tidyverse)
library(readxl)
library(DT)
library(data.table)
library(stringr)#string manipulation

#calling data
terrorferiados <- fread("C:\\Users\\lucas\\OneDrive\\Área de Trabalho\\TrabalhoDM\\holidays_all_countries.csv")

terrorferiados <- terrorferiados[,c(1,4,5,7)]
colnames(terrorferiados) <- c("startDate","Holiday","Type","Country")
#
#KDD and Data Mining


library(googlesheets4)
gs4_deauth()

gs4_auth()

dados_amvox <- as.data.frame(terrorferiados)

write_sheet(dados_amvox,"https://docs.google.com/spreadsheets/d/1aXMHsjPRV39VNZNo6kS6jU3FkGrysVV_sukEQz_1Cso/edit#gid=0",sheet = "feriados")
