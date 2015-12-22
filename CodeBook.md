#Code Book for Getting and cleaning data course project

##variables

features, activityType, subject_train, x_train, y_train, subject_test x_test and y_test contains the data
from the course project files.
trainingData is the result of merging subject_train, x_train and y_train.
testData is the result of merging subject_test x_test and y_test.
finalData is the result of combining trainingData and testData.
colNames is a vector for the column names from the finalData. We also create a logicalVector which contains the values of the features 
we want to keep.
We apply the logicalVector created to the previous finalData to update finalData only with the required measurements.   
We merge now finalData with the activityType table and give propers lables to the variables:
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Create a new table, finalDataNoActivityType without the activityType column, which includes just the mean of each variable for each activity and each subject

In summary the variables are:

"subjectId"	
"timeBodyAccMagnitudeMean"	
"timeBodyAccMagnitudeStdDev"	
"timeGravityAccMagnitudeMean"	
"timeGravityAccMagnitudeStdDev"	
"timeBodyAccJerkMagnitudeMean"	
"timeBodyAccJerkMagnitudeStdDev"	
"timeBodyGyroMagnitudeMean"	
"timeBodyGyroMagnitudeStdDev"	
"timeBodyGyroJerkMagnitudeMean"	
"timeBodyGyroJerkMagnitudeStdDev"	
"freqBodyAccMagnitudeMean"	
"freqBodyAccMagnitudeStdDev"	
"freqBodyAccJerkMagnitudeMean"	
"freqBodyAccJerkMagnitudeStdDev"	
"freqBodyGyroMagnitudeMean"	
"freqBodyGyroMagnitudeStdDev"	
"freqBodyGyroJerkMagnitudeMean"	
"freqBodyGyroJerkMagnitudeStdDev"	
"activityType"