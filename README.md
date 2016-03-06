# Overview of the scripts 

1. R version 3.2.2 used to run the assignment.

2. Download data from: 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

3. Extract the files and store the folder in your working directory

4. The dataset includes the following files:

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

5. Source the R script: **"run_analysis.R"**. This contains step-by-step commands of the procedure mentioned in points 6,7,8.

6. The training and test set files are combined to form one master database and the respective activity labels are assigned to the data. Note: The files in the Inertial Signals are not touched and can be used if one wants to check data at granular level.

7. Filter this database to obtain only the variables estimating the mean and standard deviations of the signals captured.
   _Refer:_ 'UCI_HAR_MergedData.txt' (10299 obs. of 69 varaiables)

8. From the above data set, a tidy data with average of each measurement variables for each activity and each subject is calculated.
   _Refer:_ 'UCI_HAR_MergedData.txt' (180 obs. of 68 varaibles)

9. _CodeBook.md_ describes the variables, the data, and any transformations or work that was performed to clean up the data.
