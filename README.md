# Repo: Getting and Cleaning Data Course Project

## Purpose 
The purpose of this project is to prepare a tidy dataset that can be used for later analysis. 
This README explains how the script works and the steps performed.

## Dataset
The original dataset can be downloaded here

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

The data contains sensor signals (accelerometer and gyroscope) of Samsung Galaxy S smartphones and is divided into training and testing data.

> test/X_test.txt
> test/y_test.txt

> train/X_train.txt
> train/y_train.txt

A full description is available at the site where the data was obtained from.

## Steps

The script 
> run_analysis.R

executes the following steps

1) Merging the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement 
3) Uses descriptive activity names to name the activities in the data set
4) Appropriately labels the data set with descriptive variable names. 
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Output
UCI_HAR_Dataset_data_tidy.csv