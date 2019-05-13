#Peer-graded Assignment: Getting and Cleaning Data Course Project

#This script is written by Ali Pourkhesalian 
#it downloads, unzips and reads test and training datasets together
#with their column names and merges them all, summarises and saves
#the resulting data onto the working folder. 
#This script first checks if Samsung GS files exists in 
#the worinng folder, if not, it downloads the files and uzips them
#and then merges all test and train data together
# The data frame is then tidied up.
#some strings are removed, replaced and/or added to variable names
#in the end the tidy dataset is grouped by subject ud and activity
#and the mean of each grope for each variable is calculated.
#the resulting data is saved as a tect file named tidy_data.txt

#loading required packages
    library(data.table)
    library(dplyr)
#Download data and unzip the file if not have already downloaded and/ore unzipped 
    zip.file.url<- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
    zip.file.name<- 'dataset.zip'
    folder.name <- 'UCI HAR Dataset'
    if (!file.exists(zip.file.name)){download.file(zip.file.url,destfile = zip.file.name )}
    if (!file.exists(folder.name)){unzip(zip.file.name)}
#reading data
    #read train datasets
    train.subject <- fread(file.path(folder.name,'train', 'subject_train.txt'))
    train.x <- fread(file.path(folder.name,'train', 'X_train.txt'))
    train.y <- fread(file.path(folder.name,'train', 'y_train.txt'))
    #reading test datasets
    test.subject <- fread(file.path(folder.name,'test', 'subject_test.txt'))
    test.x <- fread(file.path(folder.name,'test', 'X_test.txt'))
    test.y <- fread(file.path(folder.name,'test', 'y_test.txt'))
    #reading the features
    features<- fread(file.path(folder.name, 'features.txt'))
    #reading activities
    activities<- fread(file.path(folder.name,'activity_labels.txt'))
    #namiing the datasets
    colnames(train.x)<- features$V2
    colnames(test.x)<- features$V2
    colnames(test.subject)<- 'id'
    colnames(train.subject)<- 'id'
    colnames(train.y)<- 'activity'
    colnames(test.y)<-'activity'
    #binding all datasets
    dataset.all<- bind_rows(
      bind_cols(test.subject,test.y,test.x),
      bind_cols(train.subject,train.y,train.x))
#getting rid of the no-longer-useful data
    rm(test.subject, test.x, test.y, train.subject,train.x,train.y)
#extract the mean and std columns together with id and activity
    columns.to.keep<- c('id', 'activity', grep('mean|std', colnames(dataset.all), value = T))
    dataset.all<- dataset.all[,..columns.to.keep]
#renaming factors in the activity column
    dataset.all$activity<- factor(dataset.all$activity, levels = 1:6, labels = activities$V2)
#fix features names!
      dataset.all.column.names<- colnames(dataset.all)
      dataset.all.column.names<- gsub('[[:punct:]]','',dataset.all.column.names)
      dataset.all.column.names<- gsub('^t', 'time.', dataset.all.column.names)
      dataset.all.column.names<- gsub('Acc', 'acceleration.', dataset.all.column.names)  
      dataset.all.column.names<- gsub('Gyro', 'gyroscope.', dataset.all.column.names)  
      dataset.all.column.names<- gsub('Body', 'body.', dataset.all.column.names)  
      dataset.all.column.names<- gsub('body.body.', 'body.', dataset.all.column.names)  
      dataset.all.column.names<- gsub('^f', 'frequency.', dataset.all.column.names)
      dataset.all.column.names<- gsub('mean', 'mean.', dataset.all.column.names)
      dataset.all.column.names<- gsub('std', 'standard.deviation.', dataset.all.column.names)
      dataset.all.column.names<- gsub('Jerk', 'jerk.', dataset.all.column.names)
      dataset.all.column.names<- gsub('Mag', 'magnitude.', dataset.all.column.names)
      dataset.all.column.names<- gsub('[Gg]ravity', 'gravity.', dataset.all.column.names)
      dataset.all.column.names<- gsub('Freq', 'freq.', dataset.all.column.names)
      dataset.all.column.names<- gsub('\\.$', '', dataset.all.column.names)
      dataset.all.column.names<- tolower(dataset.all.column.names)
      colnames(dataset.all)<- dataset.all.column.names
 #A new tidy data tidy dataset with the average of each variable for each activity and each subject
      tidy.data<-dataset.all %>%
        group_by(activity, id)%>%
        summarise_all(mean)
#save tidy.data as a txt file
      write.table(tidy.data, file = 'tidy_data.txt', row.names = F, quote = F)
      


