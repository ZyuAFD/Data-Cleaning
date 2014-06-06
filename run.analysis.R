
# You should create one R script called run_analysis.R that does the following. 

#Merges the training and the test sets to create one data set.

#Extracts only the measurements on the mean and standard deviation for each measurement. 

#Uses descriptive activity names to name the activities in the data set

#Appropriately labels the data set with descriptive activity names. 

#Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

#-------------------------------------------------------------------------------------------------------

get.data = function() {
   features = read.table("features.txt", as.is = T)
   colnames(features) = c("index", "name")
   feature.names = features[,2]
   feature.names[duplicated(feature.names)]
   #--561 values, but only 477 unique!
   #---84 duplicates
   
   list (feature.names = feature.names)
   dim(labels)
   
   #---------------
   activity.numbers = read.table("train//y_train.txt", as.is = T)
   activity         = read.table("train//x_train.txt", as.is = T)
   subjects         = read.table("train//subject_train.txt")
   dim(activity.numbers)
   dim (activity)
   activity$activity.number = activity.numbers[,1]
   activity$subject = subjects[,1]
   head(activity)
   table (activity$subject, activity$activity)
   activity.train = activity
   
   #---------------------------
   rm (activity)
   activity.numbers = read.table("test//y_test.txt", as.is = T)
   activity         = read.table("test//x_test.txt", as.is = T)
   subjects         = read.table("test//subject_test.txt")
   dim(activity.numbers)
   dim (activity)
   activity$activity.number = activity.numbers[,1]
   activity$subject = subjects[,1]
   head(activity)
   table (activity$subject, activity$activity)
   activity.test = activity
   
   #--------------------------------
   #--combine train and test
   
   activity = rbind(activity.train, activity.test)
   print (table (activity$subject, activity$activity))
   colnames(activity)[1:561] = feature.names
   
   
   #-------------------------------
   #--toss extra columns
  
   mean.cols = grep("mean", feature.names)
   sd.cols   = grep("std",  feature.names)
   cols      = c(mean.cols, sd.cols)
   cols      = sort(cols)
   cols = c(563, 562, cols)
   
   activity = activity[,cols]
   head(activity)
   dim(activity)
   
   #--add activity name strings
   activity.names = c("walking", "walking.up", "walking.down", "sitting", "standing", "laying")
   activity$activity.name = activity.names[activity$activity]
   
   activity

   }


transmogrify = function (data) {
   statistics = NULL
   stats = colnames(data)[3:81]
   for (subject in sort(unique(data$subject))) {
      for (activity.name in sort(unique(data$activity.name))) {
         for (stat in stats) {
            m = mean(data[,stat][data$subject == subject & data$activity.name == activity.name])
            row = data.frame(subject=subject, activitry.name = activity.name, stat = stat, mean.value = m)
            statistics = rbind(statistics, row)
         }
      }
   }
   statistics
}
#-------------------------------------------------------------------------------------------------------

setwd("c://coursera//cleaning//data")

data = get.data()
table(data$subject, data$activity.name)
statistics = transmogrify(data)
head(statistics)
tail(statistics.tidy)
