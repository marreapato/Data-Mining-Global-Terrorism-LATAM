library(googlesheets4)
library(tidyverse)


dados <- read_sheet("https://docs.google.com/spreadsheets/d/19gj4KdpuyoUhdHa77sLSxh5dut5Qshsqbq06UWon_Ys/edit#gid=198130542","probabilidades_fracasso")

quantis=quantile(as.numeric(dados$`P (success=1)`),c(0,.10,.20,.30,.40,.50,.60,.70,.80,.90,1))

dados$categorias=NULL
dados$`P (success=1)` <- as.numeric(dados$`P (success=1)`)
dados$categorias[dados$`P (success=1)`<=0.09857292] <- 100
dados$categorias[dados$`P (success=1)`>0.09857292&dados$`P (success=1)`<=0.11538461] <- 90
dados$categorias[dados$`P (success=1)`>0.11538461&dados$`P (success=1)`<=0.13411411] <- 80
dados$categorias[dados$`P (success=1)`>0.13411411&dados$`P (success=1)`<=0.14096587] <- 70
dados$categorias[dados$`P (success=1)`>0.14096587&dados$`P (success=1)`<=0.1572457] <- 60
dados$categorias[dados$`P (success=1)`>0.1572457&dados$`P (success=1)`<=0.17073427 ] <- 50
dados$categorias[dados$`P (success=1)`>0.17073427 &dados$`P (success=1)`<=0.18362343 ] <- 40
dados$categorias[dados$`P (success=1)`>0.18362343 &dados$`P (success=1)`<=0.20156715] <- 30
dados$categorias[dados$`P (success=1)`>0.20156715&dados$`P (success=1)`<=0.21563426 ] <- 20
dados$categorias[dados$`P (success=1)`>0.21563426&dados$`P (success=1)`<=0.31307287] <- 10


dados$nkill <- as.numeric(dados$nkill)
dados$nkillter <- as.numeric(dados$nkillter)
dados$nwound <- as.numeric(dados$nwound)
dados$nperpcap <- as.numeric(dados$nperpcap)
dados$nhostkid <- as.numeric(dados$nhostkid)

df <- dados %>% group_by(categorias) %>% summarise(total=n(),mortes=sum(nkill,na.rm=T),refens=sum(nhostkid,na.rm=T),perpcap=sum(nperpcap,na.rm=T),feridos=sum(nwound,na.rm=T),mortester=sum(nkillter,na.rm=T),scorequant=paste(min(round(`P (success=1)`,3)),"-",max(round(`P (success=1)`,3))))

plot(df$categorias,df$refens,type="l")


write_sheet(df,"https://docs.google.com/spreadsheets/d/19gj4KdpuyoUhdHa77sLSxh5dut5Qshsqbq06UWon_Ys/edit#gid=198130542",sheet = "scores_kpis")
