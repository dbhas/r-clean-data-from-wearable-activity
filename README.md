# Getting and Cleaning Data Course Project
Coursework Assignment for Getting and Cleaning Data (JHU) on [coursera.org](http://www.coursera.org/course/getdata/)  
  
The R script in this repo is designed to tidy Samsung wearable data for later analysis.  
  
The **run_analysis.R** script does the following:
(slightly different order than 5 steps suggested in course)

1. Loading and pre-processing
    a. Load [raw Samsung data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), if not already loaded.
    b. Loads labels/activitynames/features from source.
2. Store test and training data in variables.
3. Add 'activity' and 'subject' columns at the beginning of each data set containing test/training labels.
4. Compile datasets into one file.
5. Replace numeric activity values with text values using 'activity_labels'.
6. Extracts only the measurements on the mean and standard deviation for each measurement.
7. Create an tidy data set '.txt' file with the average of each variable for each activity and each subject.
  
The **CodeBook.md** file describes the variables, the data, and transformations performed to clean up the data.  