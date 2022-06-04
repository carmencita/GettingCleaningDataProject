

##### You should create one R script called run_analysis.R that does the following. ######
library(codebook)
library(stringi)
library(dplyr)
##########################################################################################
##### 1) Merges the training and the test sets to create one data set.				######
##########################################################################################


#train and test file consists of two *txt files: train/X_train.txt and /train/y_train.txt

train=read.table("UCI_HAR_Dataset/train/X_train.txt")
##feature names aka table headers are taken from "features.txt"
headerNames=read.table("UCI_HAR_Dataset/features.txt")$V2
colnames(train)=headerNames
dummy=read.table("UCI_HAR_Dataset/train/y_train.txt")
train$activity=dummy$V1

#reading test data, adding header names
test=read.table("UCI_HAR_Dataset/test/X_test.txt")
colnames(test)=headerNames
dummy=read.table("UCI_HAR_Dataset/test/y_test.txt")
test$activity=dummy$V1


##joining train and test together
data=rbind(train,test)


##########################################################################################
##### 2) Extracts only the measurements on the mean and standard deviation for each measurement
##########################################################################################

###grepping "mean()" and "std" in the variable names
##Additional mean values are present: gravityMean,tBodyAccMean,tBodyAccJerkMeantBodyGyroMean,tBodyGyroJerkMean

selectedCol= c(colnames(data)[grep("[Mm]ean\\(",colnames(data))],
	colnames(data)[grep("Mean",colnames(data))],
	colnames(data)[grep("std",colnames(data))],"activity")
data2=data[selectedCol]


##########################################################################################
#4) Appropriately labels the data set with descriptive variable names. 
##########################################################################################
#renaming the columns without special characters
newCol=stri_replace_all_fixed(stri_replace_all_fixed(stri_replace_all_fixed(stri_replace_all_fixed(selectedCol,"-","_"),"(",""),")",""),",","_")
colnames(data2)=newCol


##########################################################################################
##### 3) Uses descriptive activity names to name the activities in the data set ##########
##########################################################################################


data3=transform(data2, activityName = factor(activity, 
       levels = c(1,2,3,4,5,6),
       labels = c("WALKING", "WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")))

data3$activity=NULL


##########################################################################################
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##########################################################################################

##adding subject information (30 volunteers)
subjectTrain=read.table("UCI_HAR_Dataset/train/subject_train.txt")
subjectTest=read.table("UCI_HAR_Dataset/test/subject_test.txt")
data3$subject=c(subjectTrain$V1,subjectTest$V1)

# range(data3$subject)
#1 30


final=data3 %>% group_by(subject,activityName) %>% summarise_all(mean)

write.csv(final,"UCI_HAR_Dataset_data_tidy.csv",row.names = FALSE)