# Project file for JHU Getting And Cleaning Data cohort = June, 2015
# Author: gclabbe
# Created: June 17, 2015

# Purpose:  read and clean data from two different data sets.  After combining to a single data set
# summarize on specific attributes and output as a TIDY data set appropriate for analysis
library(dplyr)
library(plyr)

# Let's start by reading in the files from the training and test data sets.  We're going to assume
# that the data is in a subdirectory of the current working directory.  If not, you will need to
# replace the data directory with the proper location
dataDirectory = paste0(getwd(), "/UCI HAR Dataset")

# pull in the files that describe the data
activityLabels = read.table(paste0(dataDirectory, "/activity_labels.txt"), header = FALSE)
features = read.table(paste0(dataDirectory, "/features.txt"), header = FALSE)

# there are a series of files that need to be read in to build the complete database
# subject_xxx.txt -- contains the user id relative to each entry
# X_xxx.txt -- Feature vectors
# y_xxx.txt -- Activity Labels
# total_acc_[xyz]_xxx.txt -- acceleration in X, Y, Z planes (3 files)
# body_acc_[xyz]_xxx.txt -- estimated body acceleration in X, Y, Z planes (3 files)
# body_gyro_[xyz]_xxx.txt -- velocity in X, Y, Z planes (3 files)

subject_train = read.table(paste0(dataDirectory, "/train/subject_train.txt"), header = FALSE)
X_train = read.table(paste0(dataDirectory, "/train/X_train.txt"), header = FALSE)
y_train = read.table(paste0(dataDirectory, "/train/y_train.txt"), header = FALSE)

subject_test = read.table(paste0(dataDirectory, "/test/subject_test.txt"), header = FALSE)
X_test = read.table(paste0(dataDirectory, "/test/X_test.txt"), header = FALSE)
y_test = read.table(paste0(dataDirectory, "/test/y_test.txt"), header = FALSE)

# 1.  Merges the training and the test sets to create one data set.
# for now, merge into three distinct data sets.  They will be bound together in a bit
subject_combined = rbind(subject_train, subject_test)
X_combined = rbind(X_train, X_test)
y_combined = rbind(y_train, y_test)

# Need to clean up behind us or we'll soon be consuming triple the memory needed to hold 
# the final table
rm(subject_train, X_train, y_train, subject_test, X_test, y_test)

# 2.  Extracts only the measurements on the mean and standard deviation for each measurement.
# To do this we'll need to search the features list and pick out those items related to mean & std
# then use this vector of names to subset the colums of X_combined data
featuresMeanStd <- grep("-(mean|std)\\(\\)", features[, 2])
X_combined = select(X_combined, featuresMeanStd)

# 3.  Uses descriptive activity names to name the activities in the data set
# need to match the activity number in y_combined with the corresponding name out of
# the activityLabels file
y_combined[, 1] <- activityLabels[y_combined[, 1], 2]

# 4.  Appropriately labels the data set with descriptive variable names.
# can use the subset from above to select only the rows of the feature table get get the
# actual names from the 2nd column.  Then push this only the X data as column labels
names(X_combined) = features[featuresMeanStd, 2]

# now we can put all three data sets together
all_combined = tbl_df(cbind(subject_combined, y_combined, X_combined))
names(all_combined)[1:2] = c("Subject", "Activity")

# 5.  From the data set in step 4, creates a second, independent tidy data set with the average of each 
#     variable for each activity and each subject.
tidy_combined = ddply(all_combined, .(Subject, Activity), function(mean) colMeans(mean[ , 3:68]))

# finally, output the new tidy data set
write.table(tidy_combined, "tidy_data.txt", row.name=FALSE)