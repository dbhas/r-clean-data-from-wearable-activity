## Getting and Cleaning Data Course Project
Coursework Assignment for Getting and Cleaning Data (JHU) on [coursera.org](http://www.coursera.org/courses/getdata/)  
  
The R script in this repo is designed to tidy Samsung wearable data for later analysis.  
  
The **run_analysis.R** script does the following:

1. Loads [raw Samsung data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), if not already loaded.

2. Merges the training and the test sets to create one data set.

3. Extracts only the measurements on the mean and standard deviation for each measurement.

4. Uses descriptive activity names to name the activities in the data set.

5. Appropriately labels the data set with descriptive variable names.

6. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  
The **CodeBook.md** file describes the variables, the data, and transformations performed to clean up the data.  