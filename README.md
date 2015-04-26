# tidydata
I. File list
------------
Data necessary for this script is the Galaxy Smartphone accelerometer data, available here - https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

This zip includes the files:
activity_labels
features
features_info
readme
test/subject_test
test/X_test
test/Y_test
test/Inertial Signals - not used in this script
train/subject_test
train/X_test
train/Y_test
train/Inertial Signals - not used in this script

General Requirements
--------------------
All files need to be in the users working directory for the script to function.

In the script, the training and test files are merged with two other files: one to add the subject of each observation and another to add a meaningful label to the activity that was observed.  Once that data was added, the training and test observations were combined into a dataset called combined.  

The combined dataset was filtered to only include columns that were of mean values, as well as the subject and the type variable.  That filtered data was called smalldata.  From here, the data was grouped by activity, and there was an average taken for each of the observations, by subject.  This was done for all 6 activities, then combined back together into the dataset called final_data. 

This is the data that should be viewed as the final, tidy data.  You can view it by using View(final_data).

Also included in this project is a tidy data dataset of the actual data, it can be read into R (from the working directory) with the following command: read.table("tidydata.txt")

Required library/package
------------------------
The reshape2 and dplyr packages are required for this script




