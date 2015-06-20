# getting-and-cleaning-data
# Chris Labbe
# June 20, 2015

# Synopsis
This work is for the 2nd project in the Johns Hopkins University "Getting And Cleaning Data" course on Coursera.

The overall intent of the assignment is to practice working with data that is spread into multiple files and needs to be combined, cleaned and summarized into a tidy data set.

The data is an example of accelerometer information coming from a Samsung Galaxy smartphone.  More information about the data can be found at this website:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The actual data used for the work is quite large so is not included in this repository.  The data can be retrieved from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Download that file and unzip in the same directory that run_analysis.R will execute from.

The assignment to work on this data is:

You should create one R script called run_analysis.R that does the following. 

1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement. 
3) Uses descriptive activity names to name the activities in the data set
4) Appropriately labels the data set with descriptive variable names. 
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The results of 5 need to be output into a txt file representing the new tidy dataset.

This work is pretty straight-forward if managed on a per-file basis.  Each file is read in using data.table command, then processed to "clean" it by replacing column headers with actual variable names, limiting the number of columns to only those representing mean and standard deviation data and using descriptive terms for activities instead of codes.

For the final step, converting the data set into a tidy data set using the ddply function out of the plyr package.  This could also be done with tapply to avoid a messy iterative table build.  I could not figure out how to make it happen using dplyr functionality.