filename <- "getdata_dataset.zip"

#Download & unzip dataset if it does not exist:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}

if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

#loading features and activity labels
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("no","features"))
#features[,2] <- as.character(features[,2])
activities <- read.table("UCI HAR Dataset/activity_labels.txt",col.names = c("label", "activity"))
#activities[,2] <- as.character(activities[,2])

#load dataset
#train
train_x <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$features)
train_y <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "label")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names="subject")

#test
test_x <- read.table("UCI HAR Dataset/test/X_train.txt", col.names = features$features)
test_y <- read.table("UCI HAR Dataset/test/y_train.txt", col.names = "label")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names="subject")

#merge datasets train and test separately
x <- rbind(train_x, test_x)
y <- rbind(train_y, test_y)
subject <- rbind(subject_train, subject_test)
final_merged_data <- cbind(subject,y,x)

#extracting measurements only based on mean and sd
tidy_mean_sd <- select(final_merged_data, contains("mean"), contains("std"))

# Averanging all variable by each subject each activity
tidy_mean_std$subject <- as.factor(tidy_set$subject)
tidy_mean_std$activity <- as.factor(tidy_set$activity)

tidy_avg <- tidy_mean_std %>%
  group_by(subject, activity) %>%
  summarise_each(funs(mean))