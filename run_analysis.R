## run_analysis.R
## author: dbhas
#
# The purpose of this R script is to clean accelerometer data from 
# Samsung Galaxy smartphones to produce a tidy data set 
# with the average of each variable for each activity and each subject.

# Steps to do this as follows: 
# (slightly different order than 5 steps suggested in course)
# 0a.If './data' folder doesn't exist, load source data; 
# 0b.load labels/activitynames/features from source.
# 1. Store test and training data in variables
# 2. Add 'activity' and 'subject' columns at the beginning of each data set containing test/training labels.
# 3. Compile datasets into one file
# 4. Replace numeric activity values with text values using 'activity_labels'
# 5. Extracts only the measurements on the mean and standard deviation for each measurement.
# 6. Create an tidy data set '.txt' file with the average of each variable for each activity
#     and each subject.

# 0a. Load data.zip from source into './data' if not done so already.
#library(dplyr) # needed for merge function
library(reshape) # needed for melt function
library(plyr) # needed for merge and ddply functions

extractPath <- 
  function(filenames, sourceUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                      destfile = "./data/data.zip"){
  
  if (!file.exists("data")) {
    dir.create("data")
    download.file(sourceUrl, destfile=destfile, method="internal",quiet=TRUE)
  }
  
  filesPath <- data.frame()
  sourceFileList <- unzip(destfile,list=TRUE)
  filePath <- lapply(filenames,
                     function(x) 
                       sourceFileList[grep(paste("/",x,".txt",sep=""),
                                                     sourceFileList$Name),"Name"])
  return (data.frame(cbind(filenames,filePath)))
}

zipdata<-"./data/data.zip"
testdatalocations <- extractPath(
  list("X_train","y_train","X_test","y_test","activity_labels", "features", "subject_train","subject_test"),
  destfile=zipdata)

##0b. load relevant label/ activity names/ features to be used for remaining steps

trainlabels <- read.table(unz(zipdata,testdatalocations[2,2]),sep="",
                          header=FALSE,col.names=c("activity_id"))
testlabels <- read.table(unz(zipdata,testdatalocations[4,2]),sep="",
                         header=FALSE,col.names=c("activity_id"))
activitynames <- read.table(unz(zipdata,testdatalocations[5,2]),sep="",
                            header=FALSE, col.names=c("activity_id","activity"))
trainsubjects <- read.table(unz(zipdata,testdatalocations[7,2]),sep="",
                            header=FALSE,col.names=c("subject_id"))
testsubjects <- read.table(unz(zipdata,testdatalocations[8,2]),sep="",
                            header=FALSE,col.names=c("subject_id"))
features <- read.table(unz(zipdata,testdatalocations[6,2]),sep="",
                       header=FALSE, col.names=c("feature_id","feature"))

## remove punctuation from features, make camelCaps for easier readability,
## when using features as column headers
  features <- gsub("[[:punct:]]","",features[,2])
  features <- gsub("mean","Mean",features)
  features <- gsub("std","Std",features)

# 1. Store test and training data in variables
## first get colClasses, then read full dataset with colClasses specified (faster read)

classes <- sapply(read.table(unz(zipdata,testdatalocations[1,2]),sep="",header=FALSE, nrows=1), class)

traindata <- read.table(unz(zipdata,testdatalocations[1,2]),
                        sep="",header=FALSE, colClasses=classes, col.names=features)
testdata <- read.table(unz(zipdata,testdatalocations[3,2]),sep="",
                       header=FALSE, colClasses=classes,col.names=features)

# 2. Add 'activity' and 'subject' columns at the beginning of each data set containing test/training labels.
traindata <- cbind(trainlabels,trainsubjects,traindata)
testdata <- cbind(testlabels,testsubjects,testdata)

# 3. Compile datasets into one file
dataset <- rbind(traindata,testdata)

# 4. Replace numeric activity values with text values using 'activity_labels'
dataset <- merge(activitynames,dataset,by.x="activity_id",by.y="activity_id",all=TRUE)

# 5. Extracts only the measurements on the mean and standard deviation for each measurement.
## Include subject_id and activitynames
selectedfeatures <- grep("Mean|Std",names(dataset), value=T)
dataset <- dataset[,c("activity","subject_id",selectedfeatures)]

# 6. Create an tidy data set '.txt' file with the average of each variable for each activity
tidyData <- ddply(dataset,.(subject_id,activity),numcolwise(mean))

write.table(tidyData,"tidydata.txt",row.name=FALSE)
