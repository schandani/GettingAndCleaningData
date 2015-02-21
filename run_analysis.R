#######################################
## Project Assignment - Tidy Data     #
#######################################
##run_analysis<-function(logPrint=FALSE){
	logPrint=FALSE
    ## 1. The following script merges the training and the test sets to create one data set
    ## create 3 
    ##library(tidyr)
    ##library(data.table)
    if(!file.exists("./data/UCI HAR Dataset/test/X_test.txt")){
        return("Raw Data set doesn't exist for test data")
    }
    testXDF<-read.table("./data/UCI HAR Dataset/test/X_test.txt")
    if (logPrint){
        print(head(testXDF))
        print(paste("Raw Test X Data read with rows=", nrow(testXDF)))
    }
    
    if(!file.exists("./data/UCI HAR Dataset/train/X_train.txt")){
        return("Raw Data set doesn't exist for train data")
    }
    trainXDF<-read.table("./data/UCI HAR Dataset/train/X_train.txt")
    if (logPrint){
        print(head(trainXDF))
        print(paste("Raw Train X Data read with rows=", nrow(trainXDF)))
    }
    X<-rbind(testXDF,trainXDF)
    if (logPrint){
        print(paste("Combined X Data read with rows=", nrow(X), " and cols=", ncol(X)))
    }
    
    ##Here on forward we'll assume that the rest of the data exists since raw data exists
    testYDF<-read.table("./data/UCI HAR Dataset/test/Y_test.txt")
    trainYDF<-read.table("./data/UCI HAR Dataset/train/Y_train.txt")
    Y<-rbind(testYDF, trainYDF)
    if (logPrint){
        print(paste("Combined Y Data read with rows=", nrow(Y)))
    }
    testSubDF<-read.table("./data/UCI HAR Dataset/test/subject_test.txt")
    trainSubDF<-read.table("./data/UCI HAR Dataset/train/subject_train.txt")
    sub<-rbind(testSubDF,trainSubDF)
    if (logPrint){
        print(paste("Combined Subject Data read with rows=", nrow(sub)))
    }
    ## 2: Extract only the measurements on the mean and standard deviation for each measurement:
    featuresDF <- read.table("./data/UCI HAR Dataset/features.txt")
    neededFeaturesDF <- grep("-mean\\(\\)|-std\\(\\)", featuresDF[, 2])  ## grep '-mean' or '-std'
    if (logPrint){
        print(neededFeaturesDF)
    }
    X <- X[, neededFeaturesDF]
    if (logPrint){
        print(paste("X after filtering features has rows=", nrow(X), " and cols=", ncol(X))) ##10299,66
    }
    names(X) <- featuresDF[neededFeaturesDF, 2]
    names(X) <- gsub("\\(|\\)", "", names(X)) ##substitute string to be matched with substitute string
    if (logPrint){
        print(names(X))
    }
    ##3: Uses descriptive activity names to name the activities in the data set
    activityLblDF <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
    activityLblDF[, 2]<-tolower(as.character(activityLblDF[, 2]))
    Y[,1]<-activityLblDF[Y[,1], 2]
    if (logPrint){
        names(Y) <- "Activity"
    }
    ##4. Appropriately label the data set with descriptive activity names
    names(sub) <- "Subject"
    tidyData <- cbind(sub, Y, X)  ## do column binding of subject, activity and observations
    write.table(tidyData, "MergedTidyData.txt")


    ## 5. Second tidy data set with the average of each variable for each activity and each subject
    uniqueSubjs<-unique(sub)[,1]
    numSubs<-length(unique(sub)[,1])
    numActs<-length(activityLblDF[,1])
    numCols<-dim(tidyData)[2]
    avgTidyData<-tidyData[1:(numSubs*numActs),]
    
    rowCnt<-1
    for (x in 1:numSubs) {
        for (y in 1:numActs) {
            avgTidyData[rowCnt, 1]<-uniqueSubjs[x]
            avgTidyData[rowCnt, 2]<-activityLblDF[y, 2]
            tmp <- tidyData[tidyData$Subject==x & tidyData$Activity==activityLblDF[y, 2], ]
            avgTidyData[rowCnt, 3:numCols] <- colMeans(tmp[, 3:numCols])
            rowCnt<-rowCnt+1
        }
    }
    write.table(avgTidyData, "TidyDataWithMeans.txt")
##}