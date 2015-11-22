require(dplyr)
require(reshape2)

# Read raw data

features <- read.table("UCI HAR Dataset/features.txt")
activities <- read.table("UCI HAR Dataset/activity_labels.txt")

y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = ("activity"))
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = ("activity"))

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = ("subject"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = ("subject"))

X_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features[[2]])
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features[[2]])

# Extract the columns with mean and std deviation

patterns <- c("\\.mean\\.", "\\.std\\.")
X_test <- X_test[,grep(paste(patterns, collapse = "|"), names(X_test))]
X_train <- X_train[,grep(paste(patterns, collapse = "|"), names(X_train))]

X_y_subject_train <- cbind(X_train, y_train, subject_train)
X_y_subject_test <- cbind(X_test, y_test, subject_test)

# Merge the training and test data
all_test_train <- rbind(X_y_subject_test, X_y_subject_train)

# Replace the Activity codes by their labels
all_test_train$activity <- as.factor(all_test_train$activity)
levels(all_test_train$activity) <- activities$V2

names(all_test_train) <- gsub("\\.", "", names(all_test_train),)
names(all_test_train) <- sub("mean", "Mean", names(all_test_train),)
names(all_test_train) <- sub("std", "Std", names(all_test_train),)

# Prepare the tidy data

measures <- setdiff(colnames(all_test_train), c("activity", "subject"))
molten_all_test_train <- melt(all_test_train, id=c("activity", "subject"), measure.vars = measures)
tidy_set <- dcast(molten_all_test_train, subject + activity ~ variable, mean)

# Write the tidy data to tidy_data.txt
write.table(tidy_set,"tidy_data.txt" ,row.name = FALSE)