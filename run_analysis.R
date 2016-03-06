#set your working directory
setwd("~/R/Getting & Cleaning Data")

#Store the data files in your working directory
#Step1: Load and combine the required files into R

#1.Features List
features <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt",col.names = c("id","features"))

#2.Activity names
activity_labels <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt",col.names = c("activity_id","activity_label"))

#3.Merge Training and Test set data
trainset <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
colnames(trainset) <- features[,2]
testset <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
colnames(testset) <- features[,2]
dataset <- rbind(trainset,testset)

#4.Merge Training and Test labels
trainlables <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt",col.names = "activity_id")
testlabels <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt",col.names = "activity_id")
activity <- rbind(trainlables,testlabels)

#5.Merge Training and Testing subjects who performed each activity.Its range is from 1 to 30
train_subjects <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt",col.names = "subject_id")
test_subjects <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt",col.names = "subject_id")
subjects <- rbind(train_subjects,test_subjects)

#6.Combine the dataset,activity, subjects dataframes
UCI_HAR_db <- cbind(subjects,activity,dataset)

#Step2: Extracting only the mean and std.dev of each measurement
mean_indices <- grep("mean\\(\\)",names(UCI_HAR_db))
std_indices <- grep("std\\(\\)",names(UCI_HAR_db))
UCI_HAR_db2 <- UCI_HAR_db[,c(1,2,mean_indices,std_indices)]

#Step3: Assigning the descriptive activity names
UCI_HAR_db3 <- merge(UCI_HAR_db2,activity_labels,by = "activity_id",all = TRUE)

#Step4: Label the variables appropriately where necessary
names(UCI_HAR_db3) <- gsub("mean\\(\\)","Mean",names(UCI_HAR_db3)) 
names(UCI_HAR_db3) <- gsub("std\\(\\)","StdDev",names(UCI_HAR_db3))
write.table(UCI_HAR_db3,"UCI_HAR_MergedData.txt")

#Step5: Tidy data set with avg of each variable for each activity and each subject
library(dplyr)
UCI_HAR_tidydata <- UCI_HAR_db3 %>%
                     select(subject_id,activity_id,activity_label,3:68) %>%
                      arrange(subject_id) %>%
                       group_by(activity_label,subject_id) %>%
                        summarise_each(funs(mean),4:69)

#Saving the tidy data in a text file
write.table(UCI_HAR_tidydata,"UCI_HAR_TidyData_withMeans.txt",row.names = FALSE)