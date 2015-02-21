Getting and Cleaning Data Course Project Code Book
==================================================

The wearable computing data linked to from the course website represent data collected from the accelerometers from the 
Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The location of the for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The above zip file needs to be extracted in a working directory.
Set this working directory using either setwd() command or using the menu options.
Verify that the working directory is properly set by using the getwd() command.

The attached R script (run_analysis.R) performs the following to clean up the data.
It can be converted as a function by un-commenting the following line:
##run_analysis<-function(logPrint=FALSE){
and un-commenting the last line in the script as well as commenting out the first 
line that sets the variable logPrint.

logPrint is a boolean that can be set to TRUE or FALSE. 
* FALSE=turn off printing of log messages, 
* TRUE=turn on printing of log messages

* The first section of the script does the following:
 It merges the training and test sets to create one data set, namely train/X_train.txt with test/X_test.txt, 
the result of which is a 10299x561 data frame, as in the original description.  There are a total of 10299 instances 
and 561 attributes per instance. 
train/subject_train.txt with test/subject_test.txt, the result of which is a 10299x1 data frame with subject IDs, 
and train/y_train.txt with test/y_test.txt, the result of which is also a 10299x1 data frame with activity IDs.

* The 2nd section of the script reads features.txt file and extracts only the measurements on the mean and standard deviation 
for each measurement using regular expression. The result is a 10299x66 data frame, because only 66 out of 561 attributes are 
measurements on either the mean or the standard deviation attributes. 
All wearable computing measurements are decimal numbers in the range of -1 to 1.

* The 3rd section reads activity_labels.txt file and applies descriptive activity names to name the activities in the data set:
        walking
        walking_upstairs
        walking_downstairs
        sitting
        standing
        laying

* The 4th section of the script appropriately labels the data set with descriptive variable names. It combines the 10299x66 data frame containing features 
with 10299x1 data frames containing activity labels and subject identifications. The result is saved as merged_clean_data.txt, a 10299x68 data frame 
such that the first column contains subject identifications in the range of 1 and 30, the second column contains activity names as described in section 
3 above, and the last 66 columns are the measurements.  

 The names of the attributes are similar to the following:
	tBodyAcc-mean-X
	tBodyAcc-mean-Y
	tBodyAcc-mean-Z"
	tBodyAcc-std-X
	tBodyAcc-std-Y
	tBodyAcc-std-Z
	tGravityAcc-mean-X
	
In this step, the full data set is written to a text file called MergedTidayData.txt


* Finally, the 5th section has the script that creates a separate tidy data set with the average of each measurement for each activity and each subject. 
The result is saved as TidyDataWithMeans.txt, a 180x68 data frame.  Write.table function is used and row.name is set to FALSE when writing the data to 
the file.  The first column contains subject id,  the second column contains activity name, and the averages for each of the 66 attributes are in columns 3 to 68. There are 30 subjects and 6 activities in all, for  a total of  
 180 rows in this data set with averages.