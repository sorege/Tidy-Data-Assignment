## Tidy Data Assignment

##

## Set working directory, install required packages

install.packages("plyr")
library(plyr)

## Set data location url and paths for file  and download file.

url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

file <- "data.zip"

download.file(url,file, mode = "wb")    
  

## Build 2 Functions to assist in executing the tasks
# First one to read the files and set their column names,
# Second Function to Merge the Data from the Test and Train Data Sets

#Function no 1:Read Data from specified files

Read_Data <- function (filename,colNames = NULL){
  
   data <- data.frame()
 
   file <- unz(file, paste("UCI HAR Dataset",filename,sep="/"))
  
    if(is.null(colNames)){
    
    data <- read.table(file,sep="",stringsAsFactors=FALSE)
    
  } else {
    
    data <- read.table(file,sep="",col.names= colNames, stringsAsFactors=FALSE)
    
  }
  
   return(data)
  
}

## Function no 2: Merge Data into a single Data Set.

Merge_Data <- function(type, features){
  
   subject_data <- Read_Data(paste(type,"/","subject_",type,".txt",sep=""),"id")  
  
  y_data <- Read_Data(paste(type,"/","y_",type,".txt",sep=""),"activity")
  
  x_data <- Read_Data(paste(type,"/","X_",type,".txt",sep=""),features$V2)
  
    return (cbind(subject_data,y_data,x_data)) 
  
}

## We now obtain the column names from the feature.txt and use it to 
#allocate correct column names in the train and data files


features <- Read_Data("features.txt")

train <- Merge_Data("train",features) 

test <- Merge_Data("test",features) 

## Assignment 1:  Merge the Train and Test Data Sets with the correct features columns

combined_data <- rbind(train, test) 

combined_data <- arrange(combined_data, id)  # reorder data by id



## Assignment 2: Extract only the measurements on the mean and standard deviation for each measurement. 

data_set <- combined_data[,c(1,2,grep("std", colnames(combined_data)), grep("mean", colnames(combined_data)))]

## Assignment 3/4: Use descriptive activity names to name the activities in the data set.
## We read the descriptive names from the activity labels file and assign to the data

activity_labels <- Read_Data("activity_labels.txt")

data_set$activity <- factor(data_set$activity, labels=activity_labels$V2)


## Assignment 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject.



tidy_dataset <- ddply(data_set, .(activity, id), .f=function(x){ 
  
  colMeans(x[,-c(1:2)]) 
  
}) 




## Assignment 5 Rename columns with a descriptive name: 'Mean("measurement")'

Descriptive_ColName = sapply(names(tidy_dataset)[-(1:2)], function(name) paste("Mean(", name, ")", sep=""))

names(tidy_dataset) <- c("Activity", "Subject", Descriptive_ColName)


## Save the results into CSV for Git and Txt for Coursework.


write.csv(tidy_dataset, "tidy_dataset.csv", row.names = FALSE)

write.csv(tidy_dataset, "tidy_dataset.txt", row.names = FALSE) 

write.csv(names(tidy_dataset), "CodeBook_col.txt") #Save the col names to include them in CodeBook.md