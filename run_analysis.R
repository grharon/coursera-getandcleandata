# Purpose: Collect, work, with and clean a data set
# Create one R script called run_analysis.R that does the following.
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# It's getting tougher, I get help from: 
# https://github.com/sefakilic/coursera-getdata
# http://ajay2589.github.io/GettingAndCleaningData/analysis.html
# https://rstudio-pubs-static.s3.amazonaws.com/37290_8e5a126a3a044b95881ae8df530da583.html

setwd("/Users/grharon/OneDrive/CourseOnline/CourseraDataScience/assignment/3GettingandCleaningData")

# 1. Merges the training and the test sets to create one data set.

# read data into data frames
featureNames <- read.table("UCI HAR Dataset/features.txt")
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
featuresTrain <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
activityTrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
featuresTest <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
activityTest <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)

subject <- rbind(subjectTrain, subjectTest)
features <- rbind(featuresTrain, featuresTest)
activity <- rbind(activityTrain, activityTest)

# Rename the column
colnames(subject) <- "Subject"
colnames(features) <- featureNames$V2
colnames(activity) <- "Activity"
completeData <- cbind(features,activity,subject)
# verification
write.table(completeData, file = "completeData.txt")


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
colWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(completeData), ignore.case=TRUE)
requiredColumns <- c(colWithMeanSTD, 562, 563)
extractedData <- completeData[,requiredColumns]
dim(extractedData)
# verification
write.table(extractedData, file = "extractedData1.txt")


# 3. Uses descriptive activity names to name the activities in the data set
extractedData$Activity <- as.character(extractedData$Activity)
for (i in 1:6){
  extractedData$Activity[extractedData$Activity == i] <- as.character(activityLabels[i,2])
}
extractedData$Activity <- as.factor(extractedData$Activity)


# 4. Appropriately labels the data set with descriptive variable names.
names(extractedData)
names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
names(extractedData)<-gsub("^t", "Time", names(extractedData))
names(extractedData)<-gsub("^f", "Frequency", names(extractedData))
names(extractedData)<-gsub("tBody", "TimeBody", names(extractedData))
names(extractedData)<-gsub("-mean\\(\\)", "Mean", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-meanFreq\\(\\)", "MeanFrequency", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-std\\(\\)", "STD", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-freq\\(\\)", "Frequency", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("angle", "Angle", names(extractedData))
names(extractedData)<-gsub("gravity", "Gravity", names(extractedData))
names(extractedData)
write.table(extractedData, file = "extractedData2.txt", row.names = FALSE)

# 5. Creates a second, independent tidy data set with the average of each 
# variable for each activity and each subject.
library(data.table)
library(dplyr);
extractedData$Subject <- as.factor(extractedData$Subject)
extractedData <- data.table(extractedData)
# create the tidy data set
tidyData <- aggregate(. ~Subject + Activity, extractedData, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
# write the tidy data set to a file
write.table(tidyData, file = "tidy.txt", row.names = FALSE)
