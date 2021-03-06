# Getting and Cleaning Data, Project Readme file
## This document describes how the script works

The script run_analysis.R will create a tidy data set that contains the average for a series of measurements collected from 30 volunteers performing certain activiites (e.g., walking, standing, laying).

There are five sections of the script:  
1. Get the data files  
2. Merge the data files  
3. Create a subset of the data  
4. Appropriately label the data  
5. Create a tidy data set  

In section 1, the script reads in the files that will be used to create the training data set. The first file is the description of 
the features, or in other words the column headings.  The second and third files contain the activity codes and subject codes.  And the fourth file contains the actual observation data. The files ares used to create the training data frame.  The same process is used to create the test data frame.

In section 2, the training and test data frames are combined to create one data set.  The column headings are replaced with descriptive text for each measurement.

In section 3, a narrow version of the data set is created that only includes columns for the mean and standard deviation measurements.

In section 4, the activity codes are replaced with the text descriptions for each activity.

In section 5, a tidy data set is created that contains the average of each variable for each subject and each activity.
