#precisamos de algo que justifique a estratificação por região
library(tidyverse)
library(readxl)
library(DT)
library(data.table)

terror <- fread("C:\\Users\\lucas\\OneDrive\\Área de Trabalho\\TrabalhoDM\\globalterrorismdb_0522dist.csv")
#describe(terrorism)
colnames(terror)
terrorism <- terror
#describing data by region


avgkill=terrorism %>% group_by(region=region_txt) %>%summarise(mean=round( mean(nkill,na.rm = T)),ataques=n())
avgkill
#merica do sul tem 19846 ataques

terr_df <- terrorism[,-c(1,2,4,5,6,8,9,11,13,19,25,26,30,32,34,36,38,39,40,42,43,44,46,47,48,50)]
terr_df <- terr_df[,-c(25,26,28,29,32,33,35,37,39,48)]
terr_df <- terr_df[,-c(47,49,50,51,53,54,100)]
#rstudioapi::writeRStudioPreference("data_viewer_max_columns", 150L)
terr_df <- terr_df[,-c(49,51,52,53,55,56,65,68,72,73,81,82,85,86,87,88,89)]


View(table(terr_df$ishostkid))
 #16669 casos de sequestro

sum(terr_df$nhostkid>0,na.rm=T)
