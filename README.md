# Getting-and-cleaning-data - week4

# Introduction
This work represents my submission for the final assignemnt of the course Getting and Cleaning Data

# Data Sources
Data for this project was collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# File Description
run_analysis.r - The script is respponsible to merge and clean the train and test datasets. Then it extracts measurements on mean and standard deviation for each attribute and the columns are renamed.
Then an independent tidied dtaset is created witht the averages of each variable for each activity and subject respectively. 
