getwd()
library(dplyr)
library(lubridate)
install.packages("Hmisc")
library(Hmisc)
df <- read.csv("test.csv", stringsAsFactors = FALSE , header = TRUE)
train <-read.csv("train.csv" ,  stringsAsFactors = FALSE , header = TRUE )
train$istrain <- TRUE
df$istrain <- FALSE
df$Survived <- NA
head(df)
head(train)
str(df)
str(train)

nrow(df)
nrow(train)
names(df)
names(train)

titanic.full <- rbind(df , train)
nrow(titanic.full)
names(titanic.full)

titanic.full$Pclass <-as.factor(titanic.full$Pclass)
titanic.full$Embarked <- as.factor(titanic.full$Embarked)
titanic.full$Sex <-as.factor(titanic.full$Sex)


table(titanic.full$Embarked)
titanic.full[titanic.full$Embarked=='' ,'Embarked'] <- 'S' ### replacing na with the mode

table(is.na(titanic.full$Age))
age.median<-median(titanic.full$Age , na.rm = TRUE)
titanic.full[is.na(titanic.full$Age), 'Age'] <- age.median
table(is.na(titanic.full$Age))

boxplot(titanic.full$Fare)

Fare.median<-median(titanic.full$Fare , na.rm = TRUE)
titanic.full[is.na(titanic.full$Fare), 'Fare'] <- Fare.median
table(is.na(titanic.full$Fare))

titanic.train <- titanic.full[titanic.full$istrain == 'TRUE',] ####cleaned train data
str(titanic.train)
nrow(titanic.train)

titanic.test<-titanic.full[titanic.full$istrain ==FALSE ,]#### cleaned test data
str(titanic.test)
nrow(titanic.test)
head(titanic.test$Survived , 100)


str(titanic.full)
table(titanic.full$Survived)
is.atomic(titanic.full$Survived)

titanic.train$Survived <- as.factor(titanic.train$Survived)
table(titanic.train$Survived) 

str(titanic.train)

survived.equation <-"Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked "
survived.formula <- as.formula(survived.equation)
install.packages("randomForest")
library("randomForest")
titanic.model<- randomForest(formula=survived.formula , data=titanic.train , ntree=500, mtry =sqrt(7), nodesize = .01*nrow(titanic.train))
features.equation <- 'Pclass + Sex + Age + SibSp + Parch + Fare + Embarked'
Survived <- predict(titanic.model, newdata=titanic.test)

PassengerId <-titanic.test$PassengerId
output.df <-as.data.frame(PassengerId)
output.df$Survived <- Survived
tail(output.df)

write.csv(output.df , file="kaggle_submission.csv" , row.names= FALSE)







