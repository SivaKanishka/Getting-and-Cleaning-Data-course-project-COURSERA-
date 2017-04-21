#Loading packages
library(plyr)
library(dplyr)
library(tidyr)
library(stringr)

feature <- read.table("features.txt")                   # Reading feature names vector
pattern <- "mean\\(\\)|std\\(\\)"                       # condition for extracting mean and standard deviation variables
feature_extract <- grep(pattern, feature$V2)            # Extracting Indices of feature vector
feature_names <- grep(pattern, feature$V2, value = T)   # Extracting names

# Reading training data set 
subject_train <- read.table("subject_train.txt")        # Reading subject ID data frame of train data
X_train <- read.table("X_train.txt")                    # Reading X data of train set
X_train <- X_train %>% select(feature_extract)          # Subsetting mean and standard deviation values of train set
y_train <- read.table("y_train.txt")                    # Reading train label set
train <- cbind(subject_train, X_train, y_train)         # Combining subject, X and label data frames

# Reading test data set
subject_test <- read.table("subject_test.txt")          # Reading subject ID data frame of test data
X_test <- read.table("X_test.txt")                      # Reading X data of test set
X_test <- X_test %>% select(feature_extract)            # Subsetting mean and standard deviation values of test set
y_test <- read.table("y_test.txt")                      # Reading test label set
test <- cbind(subject_test, X_test, y_test)             # Combining subject, X and label data frames

# Combining train and test data sets
df<- rbind(train, test)

# Reading activity labels of combined data frame
activity_labels <- read.table("activity_labels.txt")

# Changing Variable names
colnames(df) <- c("subject_id", feature_names, "activity")

# Changing class of subject_id variable to factor
df$subject_id <- as.factor(df$subject_id)

# Assigning activity labels to activity variable vector
df$activity <- as.factor(df$activity)
levels(df$activity) <- activity_labels$V2

# Formating and Editing variable names
colnames(df) <- gsub("\\(\\)", "", colnames(df))
colnames(df) <- gsub("^t", "Time", colnames(df))
colnames(df) <- gsub("^f", "Freq", colnames(df))
colnames(df) <- gsub("BodyBody", "Body", colnames(df))
colnames(df) <- gsub("Acc", "Accel", colnames(df))
colnames(df) <- gsub("mean", "Mean", colnames(df))
colnames(df) <- gsub("std", "Std", colnames(df))
colnames(df) <- gsub("-", "", colnames(df))

# Extracting new data set after averaging over each variable and grouping it by subject_id and activity
df_new <- df %>% group_by(subject_id, activity) %>% summarise_each(funs(mean))

# Rearranging to place label as the last column
df_final <- df_new %>% select(subject_id, TimeBodyAccelMeanX:FreqBodyGyroJerkMagStd, activity)

# Writing the condensed file
write.table(df_final, file = "Final_Table.txt", row.names = FALSE)
