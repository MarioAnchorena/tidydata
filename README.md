# tidydata
## Introduction
One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 

A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  
## Steps taken
I've developed an R script called run_analysis.R has the function of cleaning and ordering the data set provided before. The script does the following: 

1. Downloads the dataset
2. Merges the training and the test sets to create one dataset.
3. Extracts only the measurements on the mean and standard deviation for each measurement. 
4. Uses descriptive activity names to name the activities in the dataset
5. Appropriately labels the data set with descriptive variable names. 
6. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
7. Saves the dataset to a fwf.

## Files in this repository
1. run_analysis.R: R code that cleans the dataset provided
2. tidydataset.txt: Cleaned dataset
3. codebook.md: Explains the variables in the tidydataset
