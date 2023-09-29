library(tidyverse)
library(data.table)# to use fread

#reading mfeat-zer data
df <- fread("C:\\Users\\lucas\\OneDrive\\Área de Trabalho\\TrabalhoAM\\mfeat-zer")


set.seed(1)
gk <- as.matrix(sample_n(df,10,replace=F))#prototypes
#each gk is a gkp vector 
#p is 47 in mfeat-zer

set.seed(1)
uk <- as.data.frame(t(t(replicate(10, diff(c(0, sort(sample(seq(0.05, 0.95, 0.05), 9)), 1))))))#pertinence matrix

sum(uk$V1)

uk <- as.matrix(uk)

colSums(uk)#each col sums 1

sd(gk[1,])#sd of prototype 1

sd_values <- apply(as.matrix(df), 1, sd, na.rm=TRUE)#standard deviaton by prototypw

#ongoing
kernel <- exp((-1/2)*sum(((as.matrix(df)[1,]-gk[1,])/sd_values[1])^2))
kernel=matrix(nrow = 2000,ncol = 10)

for(i in 1:nrow(gk)){

  for(k in 1:nrow(df)){  
    
  kernel[k,i] <- exp((-1/2)*sum(((as.matrix(df)[k,]-gk[i,])/sd_values[k])^2))
  
  }
}


