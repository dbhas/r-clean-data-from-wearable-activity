# Code Book: Tidy Activity Data from Smartphone Dataset

### Overview
[Source](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) of original data:  ```https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip``` 

[Full description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) at the site where data was provided:  
```http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones``` 

In an experiment, raw data was collected from **30 subjects** (volunteers), performing **6 activities** (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers make up the **training data**, and 30% the test data.

### Process
1. Loading and pre-processing
    a. Load [raw Samsung data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), if not already loaded.
    b. Loads labels/activitynames/features from source.
2. Store test and training data in variables.
3. Add 'activity' and 'subject' columns at the beginning of each data set containing test/training labels.
4. Compile datasets into one file.
5. Replace numeric activity values with text values using 'activity_labels'.
6. Extracts only the measurements on the mean and standard deviation for each measurement.
7. Create an tidy data set '.txt' file with the average of each variable for each activity and each subject.

### Output
A tidy dataset ("tidydata.txt") is a 180x88 data frame with columns as follows: 

* subject_id : subject Id
* activity : activity name
* 86 mean and standard deviations average measures with feature names as column headers

## Variables
* zipdata - set location for storing raw data
* tesetdatalocation - a vector of filenames and file paths to relevant raw data 
* trainlabels - activity label Ids from ```train/y_train.txt``` (data frame)
* testlabels - activity label Ids from ```test/y_test.txt``` (data frame)
* activitynames - activity Ids and names from ```activity_labels``` (data frame)
* trainsubjects - subject Ids from ```train/subject_train.txt``` (data frame)
* testsubjects - subject Ids from  ```test/subject_test.txt``` (data frame)
* features - features from ```features.txt``` with punctuation removed and Mean and Std in proper caps for ease of readibility (character)
* classes - column classes from ```train/X_train.txt``` to make loading of data more * efficient (character)
* traindata - combines 'activity_id' and 'subject_id' columns at the beginning of ```train/X_train.txt``` data set, using features as col.names (data frame)  
* testdata - combines 'activity_id' and 'subject_id' columns at the beginning of ```test/X_test.txt``` data set, using features as col.names (data frame) 
* selectedfeatures - finds colum names in dataset with containing words 'Mean' or 'Std'
* dataset - combines traindata and testdata, with only 'Mean' and 'Std' measures (data frame)
* tidyData - summarizes dataset with averages for each variable for each activity for each subject (data frame) 