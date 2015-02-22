Getting and Cleaning Data
=========================

This Github repository is code written for the Getting and Cleaning Data project

## Course Project
No data files have been uploaded to Github as I wasn't sure of replication online and sharing but the data files can be pulled from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


* Unzip files into a folder on your local drive and make that folder be the working directory, say `C:\Users\<yourname>\Documents\data\UCI HAR Dataset`

* Put run_analysis.R into `C:\Users\<yourname>\Documents\data\UCI HAR Dataset`

* In RStudio: setwd("C:\\\\Users\\\\<yourname>\\\\Documents\\\\data\\\\UCI HAR Dataset"), 

* Ensure that the working directory is properly set by using the getwd() command.

* Run the source by using this command: source("run_analysis.R")

* Use `data <- read.table("TidyDataWithMeans.txt")` to read the data. It is 180x68 dataset with 30 subject ids and 6 activities for a total of 180 rows. 

* Use `head(data)` to see the first 6 rows of data or `data` to see a larger set of rows of data