# getting-and-cleaning-data
# Chris Labbe
# June 20, 2015

# Purpose
Work with data from a Samsung smartphone, cleaning it up and creating a tidy dataset of the averages for all features representing mean or standard deviation data

# Files

* run_analysis.R -- all code for the project is contained here
* README.md -- overview of the project
* CodeBook.md -- this file

# Dependencies

* data is not provided in the repository and must be downloaded.  See README.md for the URL
* plyr package
* dplyr package

# Description of data
There are a series of files that need to be read in to build the complete database.  In this list, xxx is replaced by "test" and "train" for the different sets of data that must be retrieved and combined.

* activity_labels.txt -- text descriptions of each acivity type
* features.txt -- names for all 561 features in the X dataset
* subject_xxx.txt -- contains the user id relative to each entry
* X_xxx.txt -- Feature vectors
* y_xxx.txt -- Activity Labels
* total_acc_[xyz]_xxx.txt -- acceleration in X, Y, Z planes (3 files)
* body_acc_[xyz]_xxx.txt -- estimated body acceleration in X, Y, Z planes (3 files)
* body_gyro_[xyz]_xxx.txt -- velocity in X, Y, Z planes (3 files)

# Resulting variables and output
## activityLabels
Created by importing the file activity_labels.txt.  6 x 2 data frame with activity number and text.

## all_combined
Final data frame holding all of the cleaned up raw data.  10299 observations with columns for subject, activity and the 66 features related to mean or standard deviation data.

## features
Created by importing the file features.txt.  561 x 2 data frame with all feature descriptions in text form

## subject_combined
Combination of the subject files for training and test data sets.  10299 x 1 representing which subject each observation is related to

## tidy_combined
Summary table of the all_combined data set that turns observations into event based averages for the features.  Resulting data is stored according the rules of "tidy data"

## X_combined
Combination of the X files for training and test data sets, restricted to only the columns with mean or standard deviation data.  10299 x 66 data frame of the raw values from the sensors.

## y_combined
Combination of the y files for training and test data sets.  10299 x 1 data frame with a text description of the activity for each observation

## tidy_data.txt
tidy_combined written out as a text file via write.table()