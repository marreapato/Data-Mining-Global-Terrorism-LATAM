#precisamos de algo que justifique a estratificação por região
library(tidyverse)
library(readxl)
library(DT)
library(data.table)
library(stringr)#string manipulation

#calling data
terror <- fread("C:\\Users\\lucas\\OneDrive\\Área de Trabalho\\TrabalhoDM\\globalterrorismdb_0522dist.csv")
#
colnames(terror)
terrorism <- terror

#filter only labels that are terrorist attack (no doubt)

terrorism <- terrorism %>% filter(doubtterr!=1)#remove those with doubt
terrorism <- terrorism %>% filter(region_txt=="South America")#Keep South America

#variable selection

terror_selected <- terrorism %>% select(iyear,imonth,iday,country_txt,provstate,city,success)
terror_selected <- terror_selected %>% filter(iday>0)#filtering unknown dates

#padding string to the size of 2 (adding 0 to the left of size 1)
terror_selected$iday <- str_pad(terror_selected$iday,2, pad = "0")
terror_selected$imonth <- str_pad(terror_selected$imonth,2, pad = "0")

terror_selected$date <- paste(terror_selected$iyear,"-",terror_selected$imonth,"-",terror_selected$iday,sep="")

sum(is.na(terror_selected$iday))
as.Date(terror_selected$date)
