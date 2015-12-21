#Run_analysis.R (Getting and cleaning data course project)

#You should create one R script called run_analysis.R that does the following. 

#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Workflow:

setwd("C:/Users/Usuario/Desktop/gabri/Master in Oncology/Coursera/Getting and cleaning data/Course project/DATA")

#Merges the training and the test sets to create one data set.

# We first have to read the data from the following files

features     = read.table('./features.txt',header=FALSE)
activityType = read.table('./activity_labels.txt',header=FALSE)
subject_train = read.table('./train/subject_train.txt',header=FALSE)
x_train       = read.table('./train/x_train.txt',header=FALSE)
y_train       = read.table('./train/y_train.txt',header=FALSE)

# We then introduce column names to the data previously imported

colnames(activityType)  = c('activityId','activityType')
colnames(subject_train)  = "subjectId"
colnames(x_train)        = features[,2]
colnames(y_train)        = "activityId"

# We then merge y_train, subject_train and x_train

trainingData = cbind(y_train,subject_train,x_train)

# Read in the test data
subject_test = read.table('./test/subject_test.txt',header=FALSE)
x_test       = read.table('./test/x_test.txt',header=FALSE)
y_test       = read.table('./test/y_test.txt',header=FALSE)

# We then introduce column names to the test data imported

colnames(subject_test) = "subjectId"
colnames(x_test)       = features[,2]
colnames(y_test)       = "activityId"

# As previously done, we create now the final test set by merging the x_test, y_test and subject_test data

testData = cbind(y_test,subject_test,x_test)


# We can now combine the two data sets created:

finalData = rbind(trainingData,testData)

# The next step is to create a vector for the column names from the finalData, which will be used to select the desired mean() & stddev() columns

colNames  = colnames(finalData)


#Extracts only the measurements on the mean and standard deviation for each measurement. 


# Create a logicalVector that contains TRUE values for the ID, mean() and stddev() columns and that is FALSE for the rest

logicalVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames))

# Subset finalData table based on the logicalVector to keep only desired columns

finalData = finalData[logicalVector==TRUE];


#Uses descriptive activity names to name the activities in the data set


# Merge the finalData set with the acitivityType table to include descriptive activity names

finalData = merge(finalData,activityType,by='activityId',all.x=TRUE)

# Updating the colNames vector to include the new column names after merge

colNames  = colnames(finalData)

#Appropriately labels the data set with descriptive variable names


# Cleaning up the variable names
for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
}

# We can now reassign the new descriptive column names to the finalData set

colnames(finalData) = colNames


#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# Create a new table, finalDataNoActivityType without the activityType column

finalDataNoActivityType  = finalData[,names(finalData) != 'activityType']


# Summarizing the finalDataNoActivityType table to include just the mean of each variable for each activity and each subject

tidyData    = aggregate(finalDataNoActivityType[,names(finalDataNoActivityType) != c('activityId','subjectId')],by=list(activityId=finalDataNoActivityType$activityId,subjectId = finalDataNoActivityType$subjectId),mean)

# Merging the tidyData with activityType to include descriptive acitvity names

tidyData    = merge(tidyData,activityType,by='activityId',all.x=TRUE)

# We can finally export the tidyData set and save it as tidy.txt

write.table(tidyData, './tidy.txt',row.names=FALSE,sep='\t')