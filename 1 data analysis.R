data(iris)
summary(iris)
head(iris)
library(help = "datasets")

data(longley)
head(longley)

install.packages("mlbench")
library("mlbench")

install.packages("AppliedPredictiveModeling")
library(AppliedPredictiveModeling)

ML1<-"iris.csv"
summary(ML1)
head(ML1)

data(PimaIndiansDiabetes)
head(PimaIndiansDiabetes,n=20)
dim(PimaIndiansDiabetes)

sapply(PimaIndiansDiabetes,class)###column classes 

y<-PimaIndiansDiabetes$age
cbind(freq=table(y), percentage=prop.table(table(y))*100)####how many pos or neg in diabetes column 

cbind(freq=table(y), percentage=prop.table(table(y))*100)

summary(PimaIndiansDiabetes)

sapply(PimaIndiansDiabetes[,1:8], sd)### calculate the standarad deviation 
correlations <- cor(PimaIndiansDiabetes[,1:8])### calculatre the co relations 




