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

terror_selected$week_of_year <- week(terror_selected$date)#how many weeks passed
#is it holiday https://pypi.org/project/holidays/
#terror_selected$weekday <-weekdays(terror_selected$date)
#change to english - https://stackoverflow.com/questions/17031002/get-weekdays-in-english-in-r
Sys.setlocale("LC_TIME", "en_US.UTF-8")
terror_selected$weekday <-weekdays(terror_selected$date)


Sys.setlocale("LC_TIME", "pt_BR.UTF-8")


terror_selected$city <- tolower(terror_selected$city)
terror_selected$city <- gsub("district","",terror_selected$city)

terror_selected_filtered <- terror_selected %>%
  arrange(city, date) %>%  # Sort by Group and Date
  group_by(city) %>%
  mutate(TimeDifference_city_event = date - lag(date))

terror_selected_filtered$TimeDifference_city_event[is.na(terror_selected_filtered$TimeDifference_city_event)] <- terror_selected_filtered$date[is.na(terror_selected_filtered$TimeDifference_city_event)]-as.Date("1970-01-01")

###############

terror_selected_filtered <- terror_selected_filtered %>%
  arrange(country_txt, date) %>%  # Sort by Group and Date
  group_by(country_txt) %>%
  mutate(TimeDifference_country_event = date - lag(date))


terror_selected_filtered$TimeDifference_country_event[is.na(terror_selected_filtered$TimeDifference_country_event)] <- terror_selected_filtered$date[is.na(terror_selected_filtered$TimeDifference_country_event)]-as.Date("1970-01-01")

terror_selected_filtered$provstate <- tolower(terror_selected_filtered$provstate)

View(table(terror_selected_filtered$provstate))

terror_selected_filtered$provstate <- gsub('-',' ',terror_selected_filtered$provstate)
terror_selected_filtered$provstate <- gsub('ciudade de ','',terror_selected_filtered$provstate)
terror_selected_filtered$provstate <- gsub('morazán','morazan',terror_selected_filtered$provstate)
terror_selected_filtered$provstate <- gsub('maranhaos','maranhao',terror_selected_filtered$provstate)


###############

terror_selected_filtered <- terror_selected_filtered %>%
  arrange(provstate, date) %>%  # Sort by Group and Date
  group_by(country_txt) %>%
  mutate(TimeDifference_province_event = date - lag(date))


terror_selected_filtered$TimeDifference_province_event[is.na(terror_selected_filtered$TimeDifference_province_event)] <- terror_selected_filtered$date[is.na(terror_selected_filtered$TimeDifference_province_event)]-as.Date("1970-01-01")

######################################

cor(as.numeric(terror_selected_filtered$TimeDifference_city_event),as.numeric(terror_selected_filtered$TimeDifference_province_event),method = "spearman")
plot(as.numeric(terror_selected_filtered$TimeDifference_city_event),as.numeric(terror_selected_filtered$TimeDifference_province_event))

#more variables
table(terror_selected_filtered$success)
###
library(WDI)     # for World Bank goodness
library(GetBCBData)
library(OECD)

library(countrycode)

# List of countries
countries <- c(
  "Peru", "Colombia", "Chile", "Argentina", "Venezuela",
  "Ecuador", "Brazil", "Paraguay", "Bolivia",
  "Uruguay", "Cuba","Costa Rica",'Guatemala',"Mexico","El Salvador",
"Honduras","Nicaragua","Dominican Republic","Panama"
)

# Convert country names to ISO-3 codes
iso3_codes <- countrycode(countries, "country.name", "iso3c")

# Print the ISO-3 codes array
iso3_codes
#world bank data
unique(terror_selected$country_txt)
###

bmundial<- WDI(
  country = c(iso3_codes),
  #indicator = c("SP.RUR.TOTL","SP.URB.TOTL","SP.POP.TOTL","FP.CPI.TOTL.ZG","NE.TRD.GNFS.ZS","EN.ATM.CO2E.KT"),
  start = 1970,
  end = 2021,
  extra = TRUE,
  cache = NULL,
  latest = NULL,
  language = "en"
)

#is it the capital city of the country?

View(table(terror_selected_filtered$city))
View(table(terror_selected_filtered$country_txt))

library(googlesheets4)
gs4_deauth()

gs4_auth()

dados_amvox <- terror_selected_filtered
dados_amvox$TimeDifference_city_event <- as.numeric(dados_amvox$TimeDifference_city_event)
dados_amvox$TimeDifference_country_event <- as.numeric(dados_amvox$TimeDifference_country_event)
dados_amvox$TimeDifference_province_event <- as.numeric(dados_amvox$TimeDifference_province_event)


write_sheet(dados_amvox,"https://docs.google.com/spreadsheets/d/1priwDe7UXDmy9nzbXKZTDhQG9_NOB6FZafhcmQLOTfU/edit?usp=sharing",sheet = "dados")
