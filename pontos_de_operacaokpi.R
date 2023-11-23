library(googlesheets4)
library(tidyverse)


dados <- read_sheet("https://docs.google.com/spreadsheets/d/1p01w5mzwlKTcMhwyVpYDPNReN7oYkTfPoLCnhysRm0g/edit#gid=1741817179","probabilidades_fracasso")

quantis=quantile(as.numeric(dados$`P (success=1)`),c(0,.10,.20,.30,.40,.50,.60,.70,.80,.90,1))

dados$categorias=NULL
dados$`P (success=1)` <- as.numeric(dados$`P (success=1)`)
dados$categorias[dados$`P (success=1)`<=0.07] <- 100
dados$categorias[dados$`P (success=1)`>0.07&dados$`P (success=1)`<=0.09] <- 90
dados$categorias[dados$`P (success=1)`>0.09&dados$`P (success=1)`<=0.11] <- 80
dados$categorias[dados$`P (success=1)`>0.11&dados$`P (success=1)`<=0.14] <- 70
dados$categorias[dados$`P (success=1)`>0.14&dados$`P (success=1)`<=0.16] <- 60
dados$categorias[dados$`P (success=1)`>0.16&dados$`P (success=1)`<=0.17] <- 50
dados$categorias[dados$`P (success=1)`>0.17&dados$`P (success=1)`<=0.18] <- 40
dados$categorias[dados$`P (success=1)`>0.18&dados$`P (success=1)`<=0.2] <- 30
dados$categorias[dados$`P (success=1)`>0.2&dados$`P (success=1)`<=0.24] <- 20
dados$categorias[dados$`P (success=1)`>0.24&dados$`P (success=1)`<=0.29] <- 10
dados$categorias[dados$`P (success=1)`>0.29] <- 0

dados$nkill <- as.numeric(dados$nkill)
dados$nkillter <- as.numeric(dados$nkillter)
dados$nwound <- as.numeric(dados$nwound)
dados$nperpcap <- as.numeric(dados$nperpcap)
dados$nhostkid <- as.numeric(dados$nhostkid)

df <- dados %>% group_by(categorias) %>% summarise(mortes=sum(nkill,na.rm=T),refens=sum(nhostkid,na.rm=T),perpcap=sum(nperpcap,na.rm=T),feridos=sum(nwound,na.rm=T),mortester=sum(nkillter,na.rm=T),scoremin=min(round(`P (success=1)`,3)))

plot(df$categorias,df$refens,type="l")


write_sheet(df,"https://docs.google.com/spreadsheets/d/1p01w5mzwlKTcMhwyVpYDPNReN7oYkTfPoLCnhysRm0g/edit#gid=1741817179",sheet = "scores_kpis")
