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

terror_selected <- terrorism %>% select(iyear,imonth,iday,country_txt,provstate,city,success,nkill,nkillter,nwound,nperpcap,nhostkid)
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

terror_selected2 <- terrorism %>% select(iyear,imonth,iday,country_txt,provstate,city,success,nkill,nkillter,nwound,nperpcap,nhostkid)
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
terror_selected$nhostkid[terror_selected$nhostkid<0] <- NA
terror_selected$nkill[terror_selected$nkill<0] <- NA
terror_selected$nkillter[terror_selected$nkillter<0] <- NA
terror_selected$nperpcap[terror_selected$nperpcap<0] <- NA


table(terror_selected$success)/nrow(terror_selected)#87,20% of success rate
table(terror_selected$country_txt)

#KDD and Data Mining

#terror_selected$week_of_year <- week(terror_selected$date)#how many weeks passed
#is it holiday https://pypi.org/project/holidays/
#terror_selected$weekday <-weekdays(terror_selected$date)
#change to english - https://stackoverflow.com/questions/17031002/get-weekdays-in-english-in-r
Sys.setlocale("LC_TIME", "en_US.UTF-8")
terror_selected$weekday <-weekdays(terror_selected$date)


Sys.setlocale("LC_TIME", "pt_BR.UTF-8")
###############################################################33

library(googlesheets4)
gs4_deauth()

gs4_auth()

(chfgvrn <- read_sheet("https://docs.google.com/spreadsheets/d/1aXMHsjPRV39VNZNo6kS6jU3FkGrysVV_sukEQz_1Cso/edit#gid=0",sheet = "Chefe de Governo Militar?"))
(elec <- read_sheet("https://docs.google.com/spreadsheets/d/1aXMHsjPRV39VNZNo6kS6jU3FkGrysVV_sukEQz_1Cso/edit#gid=0",sheet = "TeveEleicaoNacional? (Direta & Chefe de Estado)"))
(cidadecap <- read_sheet("https://docs.google.com/spreadsheets/d/1aXMHsjPRV39VNZNo6kS6jU3FkGrysVV_sukEQz_1Cso/edit#gid=0",sheet = "Cidades Grandes e Capitais"))
(feriado <- read_sheet("https://docs.google.com/spreadsheets/d/1aXMHsjPRV39VNZNo6kS6jU3FkGrysVV_sukEQz_1Cso/edit#gid=0",sheet = "feriados"))


chfgvrn_sel <- chfgvrn %>% select(country_txt,iyear,ChefedeGovernoMilitar)

terror_selected=left_join(terror_selected,chfgvrn_sel,by=c("iyear","country_txt"))


elec_sel <- elec %>% select(country_txt,iyear,eleicaonacionaldireta)

terror_selected=left_join(terror_selected,elec_sel,by=c("iyear","country_txt"))

cidadecap_sel <- cidadecap %>% select(country_txt,CidadeOuCapital,city)

terror_selected=left_join(terror_selected,cidadecap_sel,by=c("country_txt","city"))
#######################33333

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
  group_by(provstate) %>%
  mutate(TimeDifference_province_event = date - lag(date))


terror_selected_filtered$TimeDifference_province_event[is.na(terror_selected_filtered$TimeDifference_province_event)] <- terror_selected_filtered$date[is.na(terror_selected_filtered$TimeDifference_province_event)]-as.Date("1970-01-01")


######################################

cor(as.numeric(terror_selected_filtered$TimeDifference_city_event),as.numeric(terror_selected_filtered$TimeDifference_province_event),method = "spearman")
plot(as.numeric(terror_selected_filtered$TimeDifference_city_event),as.numeric(terror_selected_filtered$TimeDifference_province_event))

#more variables
table(terror_selected_filtered$success)
###
library(WDI)     # for World Bank goodness
library(wbstats)
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

# Convert country names to ISO-3 codes
iso2_codes <- countrycode(countries, "country.name", "iso2c")
iso2_codes

terror_selected_filtered$iso2c <- countrycode(terror_selected_filtered$country_txt, "country.name", "iso2c")

feriado_sel <- feriado %>% select(date=startDate,iso2c=Country,Type) %>% filter(Type=="public")

terror_selected_filtered$id <- seq(1,nrow(terror_selected_filtered))

terror_selected_filteredmk=left_join(terror_selected_filtered,feriado_sel,by=c("iso2c","date"))

terror_selected_filtered <- terror_selected_filteredmk %>% distinct(id, .keep_all = TRUE)

###
#?wb_data
#populationl growth
gdp_data <- wb_data(country=iso3_codes, indicator = "SP.POP.GROW",start_date = 1970,end_date = 2021)

gdp_data$country <- tolower(gdp_data$country)

gdp_data_sel <- gdp_data %>% select(iso3_codes=iso3c,SP.POP.GROW,iyear=date)

terror_selected_filtered$iso3_codes <- countrycode(terror_selected_filtered$country_txt, "country.name", "iso3c")

terror_selected_filtered_plus=left_join(terror_selected_filtered,gdp_data_sel,by=c("iyear","iso3_codes"))

sum(is.na(terror_selected_filtered_plus$SP.POP.GROW))#no na

gdp_data <- wb_data(country="LCN", indicator = "SP.POP.GROW",start_date = 1970,end_date = 2021)#REGIONS ONLY

gdp_data_sel <- gdp_data %>% select(world_grow=SP.POP.GROW,iyear=date)

terror_selected_filtered_plus=left_join(terror_selected_filtered_plus,gdp_data_sel,by=c("iyear"))

terror_selected_filtered_plus$popgrow_higher_than_latam <- if_else(terror_selected_filtered_plus$SP.POP.GROW>terror_selected_filtered_plus$world_grow,1,0)

terror_selected_filtered_plus <- terror_selected_filtered_plus %>% select(!world_grow)

#############
gdp_data <- wb_data(country=iso3_codes, indicator = "SP.POP.TOTL",start_date = 1970,end_date = 2021)

gdp_data$country <- tolower(gdp_data$country)

gdp_data_sel <- gdp_data %>% select(iso3_codes=iso3c,country_population=SP.POP.TOTL,iyear=date)

terror_selected_filtered_plus=left_join(terror_selected_filtered_plus,gdp_data_sel,by=c("iyear","iso3_codes"))

terror_selected_filtered_plus$Type[!is.na(terror_selected_filtered_plus$Type)] <- 1
terror_selected_filtered_plus$Type[is.na(terror_selected_filtered_plus$Type)] <- 0
#
#dfind=wb_indicators()
terror_selected_filtered_plus <- terror_selected_filtered_plus %>% select(!c(id,iyear,imonth,iday,iso2c,iso3_codes))
colnames(terror_selected_filtered_plus)[18] <- "feriado_oucomemo"
##################################3
dados_amvox <- terror_selected_filtered_plus
dados_amvox$TimeDifference_city_event <- as.numeric(dados_amvox$TimeDifference_city_event)
dados_amvox$TimeDifference_country_event <- as.numeric(dados_amvox$TimeDifference_country_event)
dados_amvox$TimeDifference_province_event <- as.numeric(dados_amvox$TimeDifference_province_event)
dados_amvox$SP.POP.GROW <- as.character(dados_amvox$SP.POP.GROW)


write_sheet(dados_amvox,"https://docs.google.com/spreadsheets/d/1priwDe7UXDmy9nzbXKZTDhQG9_NOB6FZafhcmQLOTfU/edit?usp=sharing",sheet = "dados")
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

#terror_selected$week_of_year <- week(terror_selected$date)#how many weeks passed
#is it holiday https://pypi.org/project/holidays/
#terror_selected$weekday <-weekdays(terror_selected$date)
#change to english - https://stackoverflow.com/questions/17031002/get-weekdays-in-english-in-r
Sys.setlocale("LC_TIME", "en_US.UTF-8")
terror_selected$weekday <-weekdays(terror_selected$date)


Sys.setlocale("LC_TIME", "pt_BR.UTF-8")
###############################################################33

library(googlesheets4)
gs4_deauth()

gs4_auth()

(chfgvrn <- read_sheet("https://docs.google.com/spreadsheets/d/1aXMHsjPRV39VNZNo6kS6jU3FkGrysVV_sukEQz_1Cso/edit#gid=0",sheet = "Chefe de Governo Militar?"))
(elec <- read_sheet("https://docs.google.com/spreadsheets/d/1aXMHsjPRV39VNZNo6kS6jU3FkGrysVV_sukEQz_1Cso/edit#gid=0",sheet = "TeveEleicaoNacional? (Direta & Chefe de Estado)"))
(cidadecap <- read_sheet("https://docs.google.com/spreadsheets/d/1aXMHsjPRV39VNZNo6kS6jU3FkGrysVV_sukEQz_1Cso/edit#gid=0",sheet = "Cidades Grandes e Capitais"))
(feriado <- read_sheet("https://docs.google.com/spreadsheets/d/1aXMHsjPRV39VNZNo6kS6jU3FkGrysVV_sukEQz_1Cso/edit#gid=0",sheet = "feriados"))


chfgvrn_sel <- chfgvrn %>% select(country_txt,iyear,ChefedeGovernoMilitar)

terror_selected=left_join(terror_selected,chfgvrn_sel,by=c("iyear","country_txt"))


elec_sel <- elec %>% select(country_txt,iyear,eleicaonacionaldireta)

terror_selected=left_join(terror_selected,elec_sel,by=c("iyear","country_txt"))

cidadecap_sel <- cidadecap %>% select(country_txt,CidadeOuCapital,city)

terror_selected=left_join(terror_selected,cidadecap_sel,by=c("country_txt","city"))
#######################33333

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
  group_by(provstate) %>%
  mutate(TimeDifference_province_event = date - lag(date))


terror_selected_filtered$TimeDifference_province_event[is.na(terror_selected_filtered$TimeDifference_province_event)] <- terror_selected_filtered$date[is.na(terror_selected_filtered$TimeDifference_province_event)]-as.Date("1970-01-01")


######################################

cor(as.numeric(terror_selected_filtered$TimeDifference_city_event),as.numeric(terror_selected_filtered$TimeDifference_province_event),method = "spearman")
plot(as.numeric(terror_selected_filtered$TimeDifference_city_event),as.numeric(terror_selected_filtered$TimeDifference_province_event))

#more variables
table(terror_selected_filtered$success)
###
library(WDI)     # for World Bank goodness
library(wbstats)
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

# Convert country names to ISO-3 codes
iso2_codes <- countrycode(countries, "country.name", "iso2c")
iso2_codes

terror_selected_filtered$iso2c <- countrycode(terror_selected_filtered$country_txt, "country.name", "iso2c")

feriado_sel <- feriado %>% select(date=startDate,iso2c=Country,Type) %>% filter(Type=="public")

terror_selected_filtered$id <- seq(1,nrow(terror_selected_filtered))

terror_selected_filteredmk=left_join(terror_selected_filtered,feriado_sel,by=c("iso2c","date"))

terror_selected_filtered <- terror_selected_filteredmk %>% distinct(id, .keep_all = TRUE)

###
#?wb_data
#populationl growth
gdp_data <- wb_data(country=iso3_codes, indicator = "SP.POP.GROW",start_date = 1970,end_date = 2021)

gdp_data$country <- tolower(gdp_data$country)

gdp_data_sel <- gdp_data %>% select(iso3_codes=iso3c,SP.POP.GROW,iyear=date)

terror_selected_filtered$iso3_codes <- countrycode(terror_selected_filtered$country_txt, "country.name", "iso3c")

terror_selected_filtered_plus=left_join(terror_selected_filtered,gdp_data_sel,by=c("iyear","iso3_codes"))

sum(is.na(terror_selected_filtered_plus$SP.POP.GROW))#no na

gdp_data <- wb_data(country="LCN", indicator = "SP.POP.GROW",start_date = 1970,end_date = 2021)#REGIONS ONLY

gdp_data_sel <- gdp_data %>% select(world_grow=SP.POP.GROW,iyear=date)

terror_selected_filtered_plus=left_join(terror_selected_filtered_plus,gdp_data_sel,by=c("iyear"))

terror_selected_filtered_plus$popgrow_higher_than_latam <- if_else(terror_selected_filtered_plus$SP.POP.GROW>terror_selected_filtered_plus$world_grow,1,0)

terror_selected_filtered_plus <- terror_selected_filtered_plus %>% select(!world_grow)

#############
gdp_data <- wb_data(country=iso3_codes, indicator = "SP.POP.TOTL",start_date = 1970,end_date = 2021)

gdp_data$country <- tolower(gdp_data$country)

gdp_data_sel <- gdp_data %>% select(iso3_codes=iso3c,country_population=SP.POP.TOTL,iyear=date)

terror_selected_filtered_plus=left_join(terror_selected_filtered_plus,gdp_data_sel,by=c("iyear","iso3_codes"))

terror_selected_filtered_plus$Type[!is.na(terror_selected_filtered_plus$Type)] <- 1
terror_selected_filtered_plus$Type[is.na(terror_selected_filtered_plus$Type)] <- 0
#
#dfind=wb_indicators()
terror_selected_filtered_plus <- terror_selected_filtered_plus %>% select(!c(id,iyear,imonth,iday,iso2c,iso3_codes))
##################################3
dados_amvox <- terror_selected_filtered_plus
dados_amvox$TimeDifference_city_event <- as.numeric(dados_amvox$TimeDifference_city_event)
dados_amvox$TimeDifference_country_event <- as.numeric(dados_amvox$TimeDifference_country_event)
dados_amvox$TimeDifference_province_event <- as.numeric(dados_amvox$TimeDifference_province_event)
dados_amvox$SP.POP.GROW <- as.character(dados_amvox$SP.POP.GROW)


write_sheet(dados_amvox,"https://docs.google.com/spreadsheets/d/1priwDe7UXDmy9nzbXKZTDhQG9_NOB6FZafhcmQLOTfU/edit?usp=sharing",sheet = "dados")
