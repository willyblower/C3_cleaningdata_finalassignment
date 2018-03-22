## Getting & cleaning the data: peer graded assignment program
## General overview: 
## 1/ prepare "test" and "train" datasets
## create a primary key "recordid", 
## clean variable names to avoid confusion (not the features variables, done later)
## and then merge activities, subjects & features mesurement sets
## 2/ merge test & train
## 3/ label activities 
## 4/ rename features variables, extract mean and std variables, clean features variables names, and 
## create a file for storing the clean dataset
      ## The variable names from feature file.
      ##  Nota: cleaning of these variables is done at this stage only 
      ## as the program uses regular expression from original features variables names 
## 5/ create of the 2nd tidy data set from previous step  
## & getting average using groups

## 1/ prepare "test" and "train" datasets
library(dplyr)

# Load the data, rename id variables and create a primary key "recordid" to merge the data sets
## Nota: Inertial signals are not loaded as per assignment instructions 
## and anyway already sowehow present in X_... files

# "test" datasets
X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
X_test <- X_test %>% 
  mutate(recordid = paste0("test",rownames(.)))

y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
y_test <- y_test %>%
  dplyr::rename(activityid=V1) %>% 
  mutate(recordid = paste0("test",rownames(.)))

subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
subject_test <- subject_test %>% 
  dplyr::rename(subjectid=V1) %>%
  mutate(recordid = paste0("test",rownames(.)))

# "train" datasets
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
X_train <- X_train %>% 
  mutate(recordid = paste0("train",rownames(.)))

y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
y_train <- y_train %>%
  dplyr::rename(activityid=V1) %>%
  mutate(recordid = paste0("train",rownames(.)))

subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
subject_train <- subject_train %>% 
  dplyr::rename(subjectid=V1) %>%
  mutate(recordid = paste0("train",rownames(.)))

# Create 1 dataset for "test"
dfListTest = list(y_test,subject_test,X_test)
testDataraw <- join_all(dfListTest)

# Create 1 dataset for "train"
dfListTrain = list(y_train,subject_train,X_train)
trainDataraw <- join_all(dfListTrain)

## 2/ Merge "test" and "train" datasets
Dataraw <- rbind(trainDataraw,testDataraw)

## 3/ Label activities
# Load activities data
activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

# reshape activities: rename variables, activities names with lower cases & no special character
activities <- activities %>% 
  dplyr::rename(activityid = V1, activityname = V2) %>% 
  mutate(activityname=gsub("_"," ", tolower(as.character(activityname))))

# Replace activityid by activityname
Dataraw$activityid <- plyr::mapvalues(Dataraw$activityid,
                                      from = activities$activityid,
                                      to = activities$activityname)
Dataraw <- dplyr::rename(Dataraw,activityname=activityid) 

## 4/ define readable variables for features part
# Load features variable names
featuresNames <- read.table("./data/UCI HAR Dataset/features.txt")
featuresNames <- featuresNames %>% 
  dplyr::rename(featureid=V1, featurename=V2) %>%
  mutate(featurename=as.character(featurename))

# replace features variable names in Dataset. 
# Features variables starts at column 4
names(Dataraw)[4:length(Dataraw)]=featuresNames$featurename

# subset mean and std variables only
# Create a logical vector to allow subset.
# Nota: 3 TRUE are added as the first 3 columns must be kept in subset 
# and are not matched by regular expression in grepl
# grepl will catch "mean()", "std()"
extract <- as.logical(c("TRUE", "TRUE", "TRUE",
                        grepl("mean\\(\\)|std\\(\\)",
                              featuresNames$featurename)))
# Do the subset
Dataclean <- Dataraw[,extract]

# Clean features Names : lower case, removing typo "-","()"
names(Dataclean)=tolower(names(Dataclean))
names(Dataclean)=gsub("-","",names(Dataclean))
names(Dataclean)=gsub("\\(\\)","",names(Dataclean))

# Write data table in a dedicated file
write.table(Dataclean,file="./allDataClean.txt")

## 5/ create of the 2nd tidy data set from previous step 
## & getting average using groups
Datagroup <- tbl_df(Dataclean)
# Nota: Alternative if dataset loaded from written file (kept as comment)
# Datagroup <- read.table("./allDataClean.txt")

# Create groups activity and subject
Datagroup <- group_by(Datagroup,activityname,subjectid)

# Calculate means per groups (1 group = 1 activity & 1 subject)
Datamean <- dplyr::summarise_at(Datagroup,
                    .vars=names(Datagroup)[4:length(colnames(Datagroup))],
                    .funs=c(mean="mean"))
