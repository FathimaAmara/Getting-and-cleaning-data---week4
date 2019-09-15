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
activities <- read.table("UCI HAR Dataset/activity_labels.txt",col.names = c("label", "activity"))

#load dataset
#train
train_x <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$features)
train_y <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "label")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names="subject")

#test
test_x <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$features)
test_y <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "label")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names="subject")

#merge datasets
activity <- rbind(train_y, test_y)
d_features <- rbind(train_x, test_x)
subject <- rbind(subject_train, subject_test)
final_merged_data1 <- cbind(subject,activity)
final_merged_data <- cbind(d_features,final_merged_data1)


#extracting measurements only based on mean and sd
tidy_mean_std <- final_merged_data %>% select(subject, label, contains("mean"), contains("std"))

#naming activities
tidy_mean_std$label <- activities[tidy_mean_std$label,2]

#labeling the dataset
names(tidy_mean_std)[2] = "activity"
names(tidy_mean_std)<-gsub("Acc", "Accelerometer", names(tidy_mean_std))
names(tidy_mean_std)<-gsub("Gyro", "Gyroscope", names(tidy_mean_std))
names(tidy_mean_std)<-gsub("BodyBody", "Body", names(tidy_mean_std))
names(tidy_mean_std)<-gsub("Mag", "Magnitude", names(tidy_mean_std))
names(tidy_mean_std)<-gsub("^t", "Time", names(tidy_mean_std))
names(tidy_mean_std)<-gsub("^f", "Frequency", names(tidy_mean_std))
names(tidy_mean_std)<-gsub("tBody", "TimeBody", names(tidy_mean_std))
names(tidy_mean_std)<-gsub("-mean()", "Mean", names(tidy_mean_std), ignore.case = TRUE)
names(tidy_mean_std)<-gsub("-std()", "STD", names(tidy_mean_std), ignore.case = TRUE)
names(tidy_mean_std)<-gsub("-freq()", "Frequency", names(tidy_mean_std), ignore.case = TRUE)
names(tidy_mean_std)<-gsub("angle", "Angle", names(tidy_mean_std))
names(tidy_mean_std)<-gsub("gravity", "Gravity", names(tidy_mean_std))

#creating an independant tidy dataset based on average of activity and subject
tidy_avg <- tidy_mean_std %>%
  group_by(subject, activity) %>%
  summarise_each(funs(mean))

# output to file "tidy_fin_data.txt"
write.table(tidy_avg, "tidy_fin_data.txt", row.names = FALSE,quote = FALSE)
