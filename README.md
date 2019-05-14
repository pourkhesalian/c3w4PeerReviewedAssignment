# Course3Week4PeerReviewedAssignment: Getting and Cleaning Data Course Project
## What's in it? 


The repo caontains the r file to tidy the dataset that can be downloaded from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
More information on the dataset can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
The R script named `run_analysis.R` will perform the following actions on the dataset:

1. Downloads and unzips the dataset if it has not yet downloaded.
2. Merges the training and the test sets to create one dataset.
3. Extracts only the measurements on the mean and standard deviation for each measurement.
4. Uses descriptive activity names to name the activities in the data set
5. Appropriately labels the data set with descriptive variable names.
6. From the data set in step 5, creates a second, independent tidy data set with the average of each variable for each activity and each subject. Generates a tidy dataset that contains a summary of the dwnloaded messy dataset and saves the new summary as a new file under the name of `tidy_dataset.txt`.

## About the data?
One of the most exciting areas in all of data science right now is wearable computing - see for example [this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/) . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained can be seen [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).



.
