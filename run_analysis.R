####TO DO#####
# Task 1 Merges the training and test sets to create one data set.

# Task 2 Extracts only the measurements on the mean and standard deviation for each measurement.

# Task 3 Use descriptive activity names to name the activities in the data set.

# Task 4 Appropriately labels the data set with descriptive variable names.

# Task 5 reates a second independent tidy data set with the average of each variable for each activity and each subject.

######

# Task 1 Merges the training and test sets to create one data set.
## 1.0. Environment and load libraries
library(tidyverse)
#environment is set outside of this to encourage reproducibility

## 1.1. Download the files and unzip it.

temp <- tempfile()
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,temp)
unzip(temp)
list.files("UCI HAR Dataset")

## 1.2. read the files.
readme <- read.delim("UCI HAR Dataset/README.txt")
labels <- read.delim("UCI HAR Dataset/activity_labels.txt")
featuresinfo <- read.delim ("UCI HAR Dataset/features_info.txt")
features <- read.delim ("UCI HAR Dataset/features.txt")

## 1.3. After reviewing the info, reading data from train files

####Training data is train folder, with inertial signals folder and then training set in X_train.txt
####with training lables in y_train.txt. will read X_train.txt.

####after playing around with tidyvrerse, actually most straightforward to use read.table from baseR.

xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt",colClasses = "factor")

###since ytrain is effectively factors, will be read as such

#str(ytrain)
#str(xtrain)

####both confirmed that there are 7352 observations in 7352 rows with 561 variables in each row.

## 1.4. Read Test data

xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("UCI HAR Dataset/test/y_test.txt",colClasses = "factor")

## 1.5. Read features 
f <- read.table("UCI HAR Dataset/features.txt")

## 1.6. Merge the training and test data sets into one. both have 561 vars 
#### so should be row bind. 
x <- rbind(xtest,xtrain)
y <- rbind(ytest,ytrain)

# Task 2 Extracts only the measurements on the mean and standard deviation for each measurement.

# 2. for each measrurement, extract only mean and sd.  total of 12 vars only
# triaxial acceleration features mean - 1,2,3
# triaxial acc features std = 4,5,6
# triaxial ang vel mean = 121,122,123,
# triaxial ang vel std = 124,125,126

xselected <- x %>% select (V1,V2,V3,V4,V5,V6,V121,V122,V123,V124,V125,V126)

# Task 3 Use descriptive activity names to name the activities in the data set.

levels(y$V1) <- c("walk","walkup","walkdown","sit","stand","lay")

# Task 4 : appropriately labels the data set.
#each row in x is a 561 variables for each observation,.
# will append y to x so that each observation is labelled. 
labelled <- cbind(y,x)

# Task 5 creates a second independent tidy data set with the average of each variable for each activity and each subject.

sbjtest <- read.table("UCI HAR Dataset/test/subject_test.txt")
sbjtrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
sbj <- rbind(sbjtest,sbjtrain)
#since sbj is effectively a factor.
sbj$V1 <- as.factor(sbj$V1)
labelled <- cbind(sbj,labelled)
#thus this labelled dataset has test and train, labelled with subjects and activities
names(labelled)[1] <- "sbj"
names(labelled)[2] <- "activity"
names(labelled)[3]<- "V1"
gi
#this code geneartes for each measured variables
labelled %>% 
        group_by(sbj,activity) %>% 
        select (V1,V2,V3,V4,V5,V6,V121,V122,V123,V124,V125,V126) %>% 
        summarise(across(everything(),list(mean)))

#this code geneartes for each variale
labelled %>% 
        group_by(sbj,activity) %>% 
        summarise(across(everything(),list(mean)))
#labelling this as tidy.
tidy <- labelled %>% 
        group_by(sbj,activity) %>% 
        summarise(across(everything(),list(mean)))

#output 
write.table(tidy,row.name = FALSE)
