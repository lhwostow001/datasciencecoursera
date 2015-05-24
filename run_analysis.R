# Getting and Cleaning Data - Project

library("dplyr")
library("data.table")

# Set working directory
setwd("C:/Users/Agilex01/Documents/wearables")

# Section 1
# Read training data
# Read feature descriptions, ie columns headings, 561 observations of 2 variables
features <- read.table("./UCI HAR Dataset/features.txt")
# Read training labels, ie rows, 7352 observations of 1 variable
labels_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
# Read subject data
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
# Read training data, 7352 observations of 561 variables
x_train <- read.table("./UCI HAR Dataset/train/x_train.txt")
# Create training data frame
train_DF <- cbind(subject_train,labels_train,x_train)
# Result is 7352 observations of 563 variables

# Read test data
labels_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./UCI HAR Dataset/test/x_test.txt")
test_DF <- cbind(subject_test,labels_test,x_test)
# Result is 2947 observations of 563 variables

# Section 2
# Merges the training and the test sets to create one data set
train_and_test <- rbind(train_DF, test_DF)
# Rename first column to Subject
colnames(train_and_test)[1]="Subject"
# Rename second column to Activity
colnames(train_and_test)[2]="Activity"
# Rename columns with feature names
col <- ncol(train_and_test)
for (i in 3:col){
  colnames(train_and_test)[i]=as.character(features[i-2,2])
}
# Result is 10299 observations of 563 variables

# Section 3
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Mean and standard deviation is defined as the columns that have mean and std in the column name
narrow <- train_and_test[,c(1:8, 43:48, 83:88, 123:128, 163:168, 203:204, 229:230, 242:243, 255:256, 268:273, 347:352, 426:431, 505:506, 531:532, 544:545)]
# Result is 10299 observations of 64 variables

# Section 4
# Use descriptive activity names to name the activities in the data set
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
tt_narrow <- data.frame()
for (i in 1:nrow(activity_labels)){
  tmp_narrow <- subset(narrow, narrow$Activity==i)
  tmp_narrow[,2] <- activity_labels[i,2]
  tt_narrow <- rbind(tt_narrow, tmp_narrow)
}

# Section 5
# Create a tidy data set with the average of each variable for each activity and each subject
# Result is 180 rows, 30 subjects times 6 activities, of 64 variables
final_df <- tt_narrow %>% group_by(Subject,Activity) %>% summarise_each(funs(mean))
write.table(final_df, file="tidydata.txt", row.name=FALSE)
