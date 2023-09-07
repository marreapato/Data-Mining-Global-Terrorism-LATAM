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

terr_df <- terrorism[,-c(1,2,4,5,6,9,11,13,19,25,26,30,32,34,36,38,39,40,42,43,44,,46,47,48,50)]
