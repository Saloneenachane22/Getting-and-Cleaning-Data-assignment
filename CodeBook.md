#Data Overview
===============

##Source
--------

Human Activity Recognition Using Smartphones Dataset
Version 1.0

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

##Study Design
--------------

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'

See: 'http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones'


#Step-by-Step guide describing the Process & Transformation
===========================================================

* R version 3.2.2 used to run the assignment.

* Download data from: 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

* Extract the files and store the folder in your working directory

* Source the R script. _run_analysis.R_ performs the following steps to arrive at the final output:

1. Set your working directory. 
2. Load and combine the required data frames -
i.   Load the "features.txt" file using read.table(). Assign column names as "id" and "features". 
ii.  Load the "activity_labels.txt" file using read.table(). Assign column names as "activity_id" and "activity_label".
iii. Load the Train("X_train.txt") / Test("X_test.txt") datasets using read.table(). Assign the 2nd column of "features.txt" as the column names to these datasets. Merge the 2 data frames using rbind().
iv.  Load the Train("y_train.txt") / Test("y_test.txt") labels data using read.table(). Label the column name "activity_id" for both. Merge the 2 data frames using rbind().
v.   Load the Train("subject_train.txt") / Test("subject_test.txt") subject id's data using read.table(). Label the column name "subject_id" for both. Merge the 2 data frames using rbind().
vii. Now combine the 3 data frames in steps 4,5,6 using cbind() to obtain one master data frame._[calldb: UCI_HAR_db1]_  
3. We need to extract only those variables which estimate the mean and standard deviation of each of the signals. Using the grep() we realize the indices of these variables(Count: 66) and produce a subset data frame with the columns for subject_id, activity_id, mean & std.dev. measuremments[use the indices here]._[call db: UCI_HAR_db2]_  
4. Assign the activity names to the data frame. Do this using merge() by merging the "activity_labels.txt" and the data frame in 3. Use by = "activity_id".This creates an additional column in the new data frame. _[call db: UCI_HAR_db3]_  
5. Rename the variable names by changing "mean()" -> "Mean" and "std()" -> "StdDev" using gsub().  
6. Write the data frame in a text file to your working directory using write.table().Store file name as "UCI_HAR_MergedData.txt".  
7. Load the 'dplyr' package in R.Using the chaining method [%>%], first using select() rearrange the columns by getting the "activity_label" column as the 3rd column then using arrange() order the "subject_id" column. After this, group the data by "activity_label"/"activity_id" and "subject_id" using group_by() and finally obtain mean of each of the measurement variables for using summarise_each()._[call db: UCI_HAR_tidydata]_  
8. Using write.table() save the data frame to your working directory, call file "UCI_HAR_TidyData_withMeans.txt".Remember to give argument row.names = FALSE.  


#Variables in tidy data set
===========================

File name: _UCI_HAR_TidyData_withMeans.txt_
---------
Variables                  : Class      Values
------------------------------------------------------------------------------------------------------------------------------
activity_label             : Factor     Levels: "LAYING","SITTING","STANDING","WALKING
","WALKING_UPSTAIRS
","WALKING_DOWNSTAIRS"
subject_id                 : Integer    Range of 1 to 30
tBodyAcc-Mean-X            : numeric    Normalized and bounded within [-1,1]
tBodyAcc-Mean-Y            : numeric    Normalized and bounded within [-1,1]
tBodyAcc-Mean-Z            : numeric    Normalized and bounded within [-1,1]
tGravityAcc-Mean-X         : numeric    Normalized and bounded within [-1,1]
tGravityAcc-Mean-Y         : numeric    Normalized and bounded within [-1,1]
tGravityAcc-Mean-Z         : numeric    Normalized and bounded within [-1,1]
tBodyAccJerk-Mean-X        : numeric    Normalized and bounded within [-1,1]
tBodyAccJerk-Mean-Y        : numeric    Normalized and bounded within [-1,1]
tBodyAccJerk-Mean-Z        : numeric    Normalized and bounded within [-1,1]
tBodyGyro-Mean-X           : numeric    Normalized and bounded within [-1,1]
tBodyGyro-Mean-Y           : numeric    Normalized and bounded within [-1,1]
tBodyGyro-Mean-Z           : numeric    Normalized and bounded within [-1,1]
tBodyGyroJerk-Mean-X       : numeric    Normalized and bounded within [-1,1]
tBodyGyroJerk-Mean-Y       : numeric    Normalized and bounded within [-1,1]
tBodyGyroJerk-Mean-Z       : numeric    Normalized and bounded within [-1,1]
tBodyAccMag-Mean           : numeric    Normalized and bounded within [-1,1]
tGravityAccMag-Mean        : numeric    Normalized and bounded within [-1,1]
tBodyAccJerkMag-Mean       : numeric    Normalized and bounded within [-1,1]
tBodyGyroMag-Mean          : numeric    Normalized and bounded within [-1,1]
tBodyGyroJerkMag-Mean      : numeric    Normalized and bounded within [-1,1]
fBodyAcc-Mean-X            : numeric    Normalized and bounded within [-1,1]
fBodyAcc-Mean-Y            : numeric    Normalized and bounded within [-1,1]
fBodyAcc-Mean-Z            : numeric    Normalized and bounded within [-1,1]
fBodyAccJerk-Mean-X        : numeric    Normalized and bounded within [-1,1]
fBodyAccJerk-Mean-Y        : numeric    Normalized and bounded within [-1,1]
fBodyAccJerk-Mean-Z        : numeric    Normalized and bounded within [-1,1]
fBodyGyro-Mean-X           : numeric    Normalized and bounded within [-1,1]
fBodyGyro-Mean-Y           : numeric    Normalized and bounded within [-1,1]
fBodyGyro-Mean-Z           : numeric    Normalized and bounded within [-1,1]
fBodyAccMag-Mean           : numeric    Normalized and bounded within [-1,1]
fBodyBodyAccJerkMag-Mean   : numeric    Normalized and bounded within [-1,1]
fBodyBodyGyroMag-Mean      : numeric    Normalized and bounded within [-1,1]
fBodyBodyGyroJerkMag-Mean  : numeric    Normalized and bounded within [-1,1]
tBodyAcc-StdDev-X          : numeric    Normalized and bounded within [-1,1]
tBodyAcc-StdDev-Y          : numeric    Normalized and bounded within [-1,1]
tBodyAcc-StdDev-Z          : numeric    Normalized and bounded within [-1,1]
tGravityAcc-StdDev-X       : numeric    Normalized and bounded within [-1,1]
tGravityAcc-StdDev-Y       : numeric    Normalized and bounded within [-1,1]
tGravityAcc-StdDev-Z       : numeric    Normalized and bounded within [-1,1]
tBodyAccJerk-StdDev-X      : numeric    Normalized and bounded within [-1,1]
tBodyAccJerk-StdDev-Y      : numeric    Normalized and bounded within [-1,1]
tBodyAccJerk-StdDev-Z      : numeric    Normalized and bounded within [-1,1]
tBodyGyro-StdDev-X         : numeric    Normalized and bounded within [-1,1]
tBodyGyro-StdDev-Y         : numeric    Normalized and bounded within [-1,1]
tBodyGyro-StdDev-Z         : numeric    Normalized and bounded within [-1,1]
tBodyGyroJerk-StdDev-X     : numeric    Normalized and bounded within [-1,1]
tBodyGyroJerk-StdDev-Y     : numeric    Normalized and bounded within [-1,1]
tBodyGyroJerk-StdDev-Z     : numeric    Normalized and bounded within [-1,1]
tBodyAccMag-StdDev         : numeric    Normalized and bounded within [-1,1]
tGravityAccMag-StdDev      : numeric    Normalized and bounded within [-1,1]
tBodyAccJerkMag-StdDev     : numeric    Normalized and bounded within [-1,1]
tBodyGyroMag-StdDev        : numeric    Normalized and bounded within [-1,1]
tBodyGyroJerkMag-StdDev    : numeric    Normalized and bounded within [-1,1]
fBodyAcc-StdDev-X          : numeric    Normalized and bounded within [-1,1]
fBodyAcc-StdDev-Y          : numeric    Normalized and bounded within [-1,1]
fBodyAcc-StdDev-Z          : numeric    Normalized and bounded within [-1,1]
fBodyAccJerk-StdDev-X      : numeric    Normalized and bounded within [-1,1]
fBodyAccJerk-StdDev-Y      : numeric    Normalized and bounded within [-1,1]
fBodyAccJerk-StdDev-Z      : numeric    Normalized and bounded within [-1,1]
fBodyGyro-StdDev-X         : numeric    Normalized and bounded within [-1,1]
fBodyGyro-StdDev-Y         : numeric    Normalized and bounded within [-1,1]
fBodyGyro-StdDev-Z         : numeric    Normalized and bounded within [-1,1]
fBodyAccMag-StdDev         : numeric    Normalized and bounded within [-1,1]
fBodyBodyAccJerkMag-StdDev : numeric    Normalized and bounded within [-1,1]
fBodyBodyGyroMag-StdDev    : numeric    Normalized and bounded within [-1,1]
fBodyBodyGyroJerkMag-StdDev: numeric    Normalized and bounded within [-1,1]