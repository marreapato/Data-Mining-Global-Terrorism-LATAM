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
terrorism <- terrorism %>% filter(region_txt=="South America"|region_txt=="Central America & Caribbean")#Keep South America

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

#setting a seed for random sampling
set.seed(3)#run before sampling
terror_selected_comp <- sample_n(terror_selected_comp, 10000-nrow(terror_selected_target))

terror_selected <- rbind(terror_selected_comp,terror_selected_target)

table(terror_selected$success)/nrow(terror_selected)#87,20% of success rate

#KDD and Data Mining

weekdays(terror_selected$date)#change to english - https://stackoverflow.com/questions/17031002/get-weekdays-in-english-in-r
week(terror_selected$date)#how many weeks passed
