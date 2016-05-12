# Introduction

The script `run_analysis.R` has the following objective
 
1. Merges the training and test sets to create one data set
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject save it as "data.txt" for upload purposes
  
# The original data set

The original data set are:
- activity label (activity_labels.txt)
- features label (features.txt)
- identifier of the subject (subject_test.txt, subject_traint.txt)
- measurements from the accelerometer and gyroscope (x_train.txt, x_test.txt, y_train.txt, y_test.txt)

# Getting and cleaning data

**1. Merges the training and test sets to create one data set**

completeData is the final data set after merging of training and test sets.
It has 10299 rows and 563 columns 

**2. Extracts only the measurements on the mean and standard deviation for each measurement**

extractedData us the extracted data with either mean or standard deviation measurement
It has 10299 rows and 88 columns 

**3. Uses descriptive activity names to name the activities in the data set**

extractedData has a proper name header name for Activity column, based on table 
activityLabels from activity_labels.txt
- e.g 1 is replaced as "WALKING"

**4. Appropriately labels the data set with descriptive variable names**

extractedData has appropriately being labels with descriptive varible names
- e.g r tBodyAcc-mean()-X is replaced as "TimeBodyAccelerometerMean-X"  

**5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject**

tidyData is created with the average of each variable for each activity and each subject
It has 180 rows and 88 columns 

The tidy data set is exported to [tidy.txt](tidy.txt)
