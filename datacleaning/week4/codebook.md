#### Codebook

Following dataframes are used and genearted.

This is to be used alongside UCI HAR Dataset


Dataframe name : description
readme  : readme file from database "README.txt"
readme.md : my own readme file for this project
labels  : lables from "activity_labels.txt"
features : from "features.txt"

xtrain : training dataset "X_train.txt" read using read.table
ytrain : training dataset labels ("y_train.txt") read using read.table as factors.

liekwise for test. 
f : features read as "f"
x : merged dataset of training and test for features
y : merged dataset of training and test for labels.

labelled : combining dataset of features and labels. 
sbjtest and sbjtrain : train and test subject information added.

tidy : final clean db of train and test sets, features, labelled, and grouped by subject and activity and means calculated.