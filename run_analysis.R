## This file has been created for Coursera course as a assigment
## Created by Jouni Huopana 22 April 2015
## Works only with particular input data files

#A.***********************************************************************
## Reading common features data and reformating naming

directory <- "UCI HAR Dataset"

filename <- "features.txt"
filepath <- paste(directory, filename, sep="\\")
features <- read.table(filepath)
## Changing feature names from factors to characters
features[, 2] <- sapply(features[, 2], as.character)
## Replacing characters to be more readable
features[, 2] <- gsub("-","_",features[, 2]) 
features[, 2] <- gsub("\\(","",features[, 2]) 
features[, 2] <- gsub("\\)","",features[, 2]) 
features[, 2] <- gsub(",","To",features[, 2])

filename <- "activity_labels.txt"
filepath <- paste(directory, filename, sep="\\")
activityLabels <- read.table(filepath)

#B.***********************************************************************
## Reading "training" data

directory <- "UCI HAR Dataset\\train"

filename <- "subject_train.txt"
filepath <- paste(directory, filename, sep="\\")
subject_train <- read.table(filepath)

filename <- "y_train.txt"
filepath <- paste(directory, filename, sep="\\")
y_train <- read.table(filepath)
y_train <- activityLabels$V2[y_train$V1]

filename <- "X_train.txt"
filepath <- paste(directory, filename, sep="\\")
X_train <- read.table(filepath,col.names=features$V2)

## Combining read data into a sinlge set
TrainData <- X_train
TrainData$activity <- y_train
TrainData$subject <- as.factor(subject_train$V1)

#C.***********************************************************************
## Reading "test" data

directory <- "UCI HAR Dataset\\test"

filename <- "subject_test.txt"
filepath <- paste(directory, filename, sep="\\")
subject_test <- read.table(filepath)

filename <- "y_test.txt"
filepath <- paste(directory, filename, sep="\\")
y_test <- read.table(filepath)
y_test <- activityLabels$V2[y_test$V1]

filename <- "X_test.txt"
filepath <- paste(directory, filename, sep="\\")
X_test <- read.table(filepath,col.names=features$V2)

## Combining read data into a sinlge set
TestData <- X_test
TestData$activity <- y_test
TestData$subject <- as.factor(subject_test$V1)

#1.***********************************************************************
## Merging training and test data
mainData <- rbind(TrainData, TestData) 

#2.***********************************************************************
## Finding mean and std columns
meanNames <- grep("mean",names(mainData),ignore.case=TRUE,value=TRUE)
stdNames  <- grep("std",names(mainData),ignore.case=TRUE,value=TRUE)
## Reducing data to only mean and stadard deviation for 
## each subject and activity
reducedData <- mainData[c("subject","activity",meanNames,stdNames)]

#3.***********************************************************************
## Calculating the mean for each subject and activity with "dplyr-package"
## and creating the new tidy data
library("dplyr")
tidyData <- reducedData %>% group_by(subject, activity) %>% summarise_each(funs(mean))

## Writing tidy data to a txt file
write.table(tidyData, file ="tidyData.txt" ,row.name=FALSE)








