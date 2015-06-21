library("data.table")
library("reshape2")

testX <- c()
testY <- c()

activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

features <- read.table("./UCI HAR Dataset/features.txt")[,2]

desiredFeatures <- grepl("mean|std", features)

testX <- read.table("./UCI HAR Dataset/test/X_test.txt")
testY <- read.table("./UCI HAR Dataset/test/y_test.txt")
testSubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")

desiredTestX <- testX[,desiredFeatures]

testY[,2] = activityLabels[testY[,1]]

names(testX) <- features
names(testY) <- c("activityId", "activityLabel")
names(testSubjects) <- c("subject")

testData <- cbind(as.data.table(testSubjects), testY, testX)

trainX <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainY <- read.table("./UCI HAR Dataset/train/y_train.txt")
trainSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")

desiredtrainX <- trainX[,desiredFeatures]

trainY[,2] = activityLabels[trainY[,1]]

names(trainX) <- features
names(trainY) <- c("activityId", "activityLabel")
names(trainSubjects) <- c("subject")

trainData <- cbind(as.data.table(trainSubjects), trainY, trainX)

data <- rbind(testData, trainData)

idLabels <- c("subject", "activityId", "activityLabel")
dataLabels <- setdiff(colnames(data), idLabels)
meltData <- melt(data, id = idLabels, measure.vars = dataLabels)

tidyData <- dcast(meltData, subject + activityLabel ~ variable, mean)

write.table(tidyData, file = "./tidyData.txt", row.name=FALSE)
