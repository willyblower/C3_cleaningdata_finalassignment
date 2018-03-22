Code Book "run_analysis.R"
==================================================================
Final assignment program
Version 1.0
==================================================================
## Guillaume SOUFFLET

==================================================================

The Coursera MOOC Datascience Specialization from the John Hopkins University requests a series of programming project assignement to succeed the completion.
This project is the final assessment program from the Course 3 Getting and cleaning the data.

The purpose of this project is to prepare tidy data that can be used for later analysis.

Here is a reminder of the instructions:
You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

You should create one R script called run_analysis.R that does the following.
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Good luck!

The program uses a source dataset  from [1].

Overall rationale about the program
======================================
Recall of the initial instructions:
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The initial instructions have been followed in several steps as following
## 1/ prepare "test" and "train" datasets
create a primary key "recordid", clean variable names to avoid confusion (not the features variables, done later) and then merge activities, subjects & features mesurement data for each dataset.

Data created at this stage

Data directly loaded from [1], where ...  alternatively stands for test and train according to the dataset
X_... : for each record (= each row), gives 561 features, , i.e post processing calculations, (1 per column), where features are accurately defined in [1]
y_... : for each record (=each row), gives the activity performed
subject_... : for each record (=each row), gives the id (a number) of the subject
Source files are stored in a data/UCI HAR Dataset file retrieved from instructions.
Nota: Inertial signals are not loaded as per assignment instructions and anyway already sowehow present in X_... data.

In each data, a primary key column "recordid" has been created to keep a track on record (= a combination of an activity, a subject and a serie of features
subject and activities variables are also renamed with meaningful land unambiguous abels.
Nota: features variables are not renamed at this stage as not necessary.

Then test and train datasets are created merging the respective  X_..., y_..., subject_... data.
Outputs
testDataraw
trainDataraw
Intermediate outputs
dfListTest
dfListTrain

## 2/ merge test & train datasets in "Dataraw"
the transformation is performed by binding rows as the data have the same column format and variables
Output
Dataraw

## 3/ label activities in "Dataraw"
Activities description file is loaded
variables are renamed and values (=activity description) are reshaped to fit to tidy data standards: low cases, removal of special characters ("_")
Output
activities

Activities id are then replaced in Dataraw with the previously reshaped activity names.
Output
Dataraw

## 4/ rename features variables, extract mean and std variables, clean features variables names, and create a file for storing the clean dataset
Features names file is loaded and slightly reshaped to fit with previously defined standards.
Output
featuresNames

features variables are then replaced in Dataraw from the featuresNames file.
Output
Dataraw

The subset of the raw Data is performed based on a logical vector that indicated the variables to subset: activities, subset, record id (not strictly requested but seems mandatory to keep a track) and mean and std calculation in the features.
To extract the mean and std from 561 features variables names, regular expression has been used on "mean()" and "std ()". And only those ones as the other were not considered as a mean of the feature.
Output
Dataclean
Intermediate output
extract: logical vector for subset

Features variables names are then cleaned according to didy data standard: low cases, removal of special characters ("()", "-")
Output
Dataclean

The clean data is stored in a file to allow further reuse. The file is created in the current folder.
Output
allDataClean.txt

## 5/ Calculate the average of each variable for each activity and each subject
A second 2nd tidy data set is created from previous step
Nota: an alternative is proposed (but kept as comment) if the dataset should be loaded from previously written file (not clear in instructions)
Groups are created on activity and subject (in this order).
Output
Datagroup

Mean per group (1 group = 1 activity & 1 subject, so 180 groups) is performed for each variable (mean and std).
Output
Datamean

## Detailed list of variables in Dataclean
"1" "activityname" : walking, walking upstairs, walking downstairs, sitting, standing, laying
"2" "recordid": "testx", x integer in [1: 2947], "trainy", y integer in [1:7352]
"3" "subjectid": integer in [1:30]

The following variable are normalized and bounded within [-1,1]
"4" "tbodyaccmeanx"
"5" "tbodyaccmeany"
"6" "tbodyaccmeanz"
"7" "tbodyaccstdx"
"8" "tbodyaccstdy"
"9" "tbodyaccstdz"
"10" "tgravityaccmeanx"
"11" "tgravityaccmeany"
"12" "tgravityaccmeanz"
"13" "tgravityaccstdx"
"14" "tgravityaccstdy"
"15" "tgravityaccstdz"
"16" "tbodyaccjerkmeanx"
"17" "tbodyaccjerkmeany"
"18" "tbodyaccjerkmeanz"
"19" "tbodyaccjerkstdx"
"20" "tbodyaccjerkstdy"
"21" "tbodyaccjerkstdz"
"22" "tbodygyromeanx"
"23" "tbodygyromeany"
"24" "tbodygyromeanz"
"25" "tbodygyrostdx"
"26" "tbodygyrostdy"
"27" "tbodygyrostdz"
"28" "tbodygyrojerkmeanx"
"29" "tbodygyrojerkmeany"
"30" "tbodygyrojerkmeanz"
"31" "tbodygyrojerkstdx"
"32" "tbodygyrojerkstdy"
"33" "tbodygyrojerkstdz"
"34" "tbodyaccmagmean"
"35" "tbodyaccmagstd"
"36" "tgravityaccmagmean"
"37" "tgravityaccmagstd"
"38" "tbodyaccjerkmagmean"
"39" "tbodyaccjerkmagstd"
"40" "tbodygyromagmean"
"41" "tbodygyromagstd"
"42" "tbodygyrojerkmagmean"
"43" "tbodygyrojerkmagstd"
"44" "fbodyaccmeanx"
"45" "fbodyaccmeany"
"46" "fbodyaccmeanz"
"47" "fbodyaccstdx"
"48" "fbodyaccstdy"
"49" "fbodyaccstdz"
"50" "fbodyaccjerkmeanx"
"51" "fbodyaccjerkmeany"
"52" "fbodyaccjerkmeanz"
"53" "fbodyaccjerkstdx"
"54" "fbodyaccjerkstdy"
"55" "fbodyaccjerkstdz"
"56" "fbodygyromeanx"
"57" "fbodygyromeany"
"58" "fbodygyromeanz"
"59" "fbodygyrostdx"
"60" "fbodygyrostdy"
"61" "fbodygyrostdz"
"62" "fbodyaccmagmean"
"63" "fbodyaccmagstd"
"64" "fbodybodyaccjerkmagmean"
"65" "fbodybodyaccjerkmagstd"
"66" "fbodybodygyromagmean"
"67" "fbodybodygyromagstd"
"68" "fbodybodygyrojerkmagmean"
"69" "fbodybodygyrojerkmagstd"

## Detailed list of variables in Datamean
"1" "activityname": : walking, walking upstairs, walking downstairs, sitting, standing, laying
"2" "subjectid": integer in [1:30]

The following variable are bounded within [-1,1]
"3" "tbodyaccmeanx_mean"
"4" "tbodyaccmeany_mean"
"5" "tbodyaccmeanz_mean"
"6" "tbodyaccstdx_mean"
"7" "tbodyaccstdy_mean"
"8" "tbodyaccstdz_mean"
"9" "tgravityaccmeanx_mean"
"10" "tgravityaccmeany_mean"
"11" "tgravityaccmeanz_mean"
"12" "tgravityaccstdx_mean"
"13" "tgravityaccstdy_mean"
"14" "tgravityaccstdz_mean"
"15" "tbodyaccjerkmeanx_mean"
"16" "tbodyaccjerkmeany_mean"
"17" "tbodyaccjerkmeanz_mean"
"18" "tbodyaccjerkstdx_mean"
"19" "tbodyaccjerkstdy_mean"
"20" "tbodyaccjerkstdz_mean"
"21" "tbodygyromeanx_mean"
"22" "tbodygyromeany_mean"
"23" "tbodygyromeanz_mean"
"24" "tbodygyrostdx_mean"
"25" "tbodygyrostdy_mean"
"26" "tbodygyrostdz_mean"
"27" "tbodygyrojerkmeanx_mean"
"28" "tbodygyrojerkmeany_mean"
"29" "tbodygyrojerkmeanz_mean"
"30" "tbodygyrojerkstdx_mean"
"31" "tbodygyrojerkstdy_mean"
"32" "tbodygyrojerkstdz_mean"
"33" "tbodyaccmagmean_mean"
"34" "tbodyaccmagstd_mean"
"35" "tgravityaccmagmean_mean"
"36" "tgravityaccmagstd_mean"
"37" "tbodyaccjerkmagmean_mean"
"38" "tbodyaccjerkmagstd_mean"
"39" "tbodygyromagmean_mean"
"40" "tbodygyromagstd_mean"
"41" "tbodygyrojerkmagmean_mean"
"42" "tbodygyrojerkmagstd_mean"
"43" "fbodyaccmeanx_mean"
"44" "fbodyaccmeany_mean"
"45" "fbodyaccmeanz_mean"
"46" "fbodyaccstdx_mean"
"47" "fbodyaccstdy_mean"
"48" "fbodyaccstdz_mean"
"49" "fbodyaccjerkmeanx_mean"
"50" "fbodyaccjerkmeany_mean"
"51" "fbodyaccjerkmeanz_mean"
"52" "fbodyaccjerkstdx_mean"
"53" "fbodyaccjerkstdy_mean"
"54" "fbodyaccjerkstdz_mean"
"55" "fbodygyromeanx_mean"
"56" "fbodygyromeany_mean"
"57" "fbodygyromeanz_mean"
"58" "fbodygyrostdx_mean"
"59" "fbodygyrostdy_mean"
"60" "fbodygyrostdz_mean"
"61" "fbodyaccmagmean_mean"
"62" "fbodyaccmagstd_mean"
"63" "fbodybodyaccjerkmagmean_mean"
"64" "fbodybodyaccjerkmagstd_mean"
"65" "fbodybodygyromagmean_mean"
"66" "fbodybodygyromagstd_mean"
"67" "fbodybodygyrojerkmagmean_mean"
"68" "fbodybodygyrojerkmagstd_mean"


About data in UCI HAR Dataset file
=========================================

## For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment.

## The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

Notes:
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1]

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

