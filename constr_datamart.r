#precisamos de algo que justifique a estratificação por região
library(tidyverse)
library(readxl)
library(DT)
library(data.table)
library(stringr)#string manipulation

#calling data
terror <- fread("C:\\Users\\lucas\\OneDrive\\Área de Trabalho\\TrabalhoDM\\globalterrorismdb_0522dist.csv")
#

#library(googlesheets4)
#gs4_deauth()

#gs4_auth()

#write_sheet(as.data.frame(table(colnames(terror))),"https://docs.google.com/spreadsheets/d/1b76JLiXEMQjBxDfiCXPlvhMe9Bajkdmximw1nQHhFHw/edit?usp=sharing",sheet = "dados")



terrorism <- terror

#filter only labels that are terrorist attack (no doubt)

terrorism <- terrorism %>% filter(doubtterr!=1)#remove those with doubt
terrorism <- terrorism# %>% filter(region_txt=="South America"|region_txt=="Central America & Caribbean")#Keep South America
terrorism <- terrorism %>%
  filter(country_txt == "Argentina" |
           country_txt == "Bolivia" |
           country_txt == "Brazil" |
           country_txt == "Chile" |
           country_txt == "Colombia" |
           country_txt == "Costa Rica" |
           country_txt == "Cuba" |
           country_txt == "Dominican Republic" |
           country_txt == "Ecuador" |
           country_txt == "El Salvador" |
           country_txt == "Guatemala" |
           country_txt == "Honduras" |
           country_txt == "Mexico" |
           country_txt == "Nicaragua" |
           country_txt == "Panama" |
           country_txt == "Paraguay" |
           country_txt == "Peru" |
           country_txt == "Uruguay" |
           country_txt == "Venezuela")
#variable selection

terror_selected <- terrorism %>% select(iyear,imonth,iday,country_txt,provstate,city,success)
terror_selected <- terror_selected %>% filter(iday>0)#filtering unknown dates
terror_selected <- terror_selected %>% filter(provstate!="Unknown")#filtering unknown provinvies
terror_selected <- terror_selected %>% filter(city!="Unknown")#filtering unknown cities

#looking for NAs
sum(is.na(terror_selected$city))
sum(is.na(terror_selected$provstate))
#
table(terror_selected$success)/10000#12,67% in the target class

#padding string to the size of 2 (adding 0 to the left of size 1)
terror_selected$iday <- str_pad(terror_selected$iday,2, pad = "0")
terror_selected$imonth <- str_pad(terror_selected$imonth,2, pad = "0")

terror_selected$date <- paste(terror_selected$iyear,"-",terror_selected$imonth,"-",terror_selected$iday,sep="")

terror_selected$date <- as.Date(terror_selected$date)

sum(is.na(terror_selected$date))#no NAs

#preprocessed data

#loading more data

df_terrorism2021 <- read_xlsx("C:\\Users\\lucas\\OneDrive\\Área de Trabalho\\TrabalhoDM\\globalterrorismdb_2021Jan-June_1222dist.xlsx")


#filter only labels that are terrorist attack (no doubt)

terrorism <- df_terrorism2021 %>% filter(doubtterr!=1)#remove those with doubt
terrorism <- terrorism#Keep South America
terrorism <- terrorism %>%
  filter(country_txt == "Argentina" |
           country_txt == "Bolivia" |
           country_txt == "Brazil" |
           country_txt == "Chile" |
           country_txt == "Colombia" |
           country_txt == "Costa Rica" |
           country_txt == "Cuba" |
           country_txt == "Dominican Republic" |
           country_txt == "Ecuador" |
           country_txt == "El Salvador" |
           country_txt == "Guatemala" |
           country_txt == "Honduras" |
           country_txt == "Mexico" |
           country_txt == "Nicaragua" |
           country_txt == "Panama" |
           country_txt == "Paraguay" |
           country_txt == "Peru" |
           country_txt == "Uruguay" |
           country_txt == "Venezuela")

#variable selection

terror_selected2 <- terrorism %>% select(iyear,imonth,iday,country_txt,provstate,city,success)
terror_selected2 <- terror_selected2 %>% filter(iday>0)#filtering unknown dates
terror_selected2 <- terror_selected2 %>% filter(provstate!="Unknown")#filtering unknown provinvies
terror_selected2 <- terror_selected2 %>% filter(city!="Unknown")#filtering unknown cities

#looking for NAs
sum(is.na(terror_selected2$city))
sum(is.na(terror_selected2$provstate))
#
table(terror_selected2$success)/10000#12,67% in the target class

#padding string to the size of 2 (adding 0 to the left of size 1)
terror_selected2$iday <- str_pad(terror_selected2$iday,2, pad = "0")
terror_selected2$imonth <- str_pad(terror_selected2$imonth,2, pad = "0")

terror_selected2$date <- paste(terror_selected2$iyear,"-",terror_selected2$imonth,"-",terror_selected2$iday,sep="")

terror_selected2$date <- as.Date(terror_selected2$date)

sum(is.na(terror_selected2$date))#no NAs

###join data

terror_selected <- rbind(terror_selected,terror_selected2)

terror_selected_target <- terror_selected %>% filter(success==0)
terror_selected_comp <- terror_selected %>% filter(success==1)
terror_selected_comp <- terror_selected_comp %>% filter(country_txt!="Falkland Islands")

#setting a seed for random sampling
set.seed(2)#run before sampling
terror_selected_comp <- sample_n(terror_selected_comp, 10000-nrow(terror_selected_target))


terror_selected <- rbind(terror_selected_comp,terror_selected_target)

table(terror_selected$success)/nrow(terror_selected)#87,20% of success rate
table(terror_selected$country_txt)

#KDD and Data Mining


library(googlesheets4)
gs4_deauth()

gs4_auth()

dados_amvox <- terror_selected %>% group_by(country_txt,iyear) %>% summarise(total=n())
table(dados_amvox$country_txt)

write_sheet(dados_amvox,"https://docs.google.com/spreadsheets/d/1aXMHsjPRV39VNZNo6kS6jU3FkGrysVV_sukEQz_1Cso/edit#gid=0",sheet = "Presidente Militar?")
