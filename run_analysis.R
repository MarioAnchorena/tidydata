library(data.table)
library(stringr)
library(dplyr)

## Download data if it hasn't been downloaded
if (!file.exists("UCI HAR Dataset")){
    fileurl="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileurl,destfile = "./messy.zip",method="curl")
    unzip("./messy.zip")}

## fread files (faster than other read functions) that we are going to use
files=list.files("UCI HAR Dataset",recursive=TRUE)[c(1,2,14,15,16,26,27,28)]
files=file.path("UCI HAR Dataset",files)
filenames=str_extract(basename(files),"\\w+")
for (i in 1:8) {assign(filenames[i],fread(files[i]))} #Assign names to files

## Merges the training and the test sets to create one data set.
test=cbind(subject_test,y_test,X_test) # Bind train and test data
train=cbind(subject_train,y_train,X_train)
tt=rbind(test,train)
names(tt)[1:2]=c("ID","ACT") #Names for first two columns
tt=tt[order(tt$ID,tt$ACT),] #Order data

## Extracts only the measurements on the mean and standard deviation for each measurement. 
msdindx=sort(c(grep("mean\\(",features[[2]]),grep("std",features[[2]]))) #Index of columns with mean a std measurements
tt=tt[,.SD,.SDcols=c(1,2,msdindx+2)] #Selecting columns containing only the mean and std measurements

## Uses descriptive activity names to name the activities in the data set
names(activity_labels)=c("ACT","ACTnames") #Activity_labels file contains all activity names
tt = merge(tt,activity_labels,sort=FALSE) #Merging tt and activity_labels by activity (ACT)
tt = tt %>% relocate(c(ACT,ACTnames),.after=ID) #Ordering columns in this order: ID, ACT, ACTnames, measurements

## Appropriately labels the data set with descriptive variable names.
names(tt)[4:69]=features[[2]][msdindx] #Naming columns with measurements

## From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
rm(list=ls()[ls()!="tt"]) #Remove data we are not going to use anymore
TT=tt 
TT=TT[,lapply(.SD,mean),by=.(ID,ACT,ACTnames)] #Applying mean to columns grouped by ID and activities


#saving
write.fwf(TT,file="tidydataset.txt",sep="\t") #in fixed widths for more order