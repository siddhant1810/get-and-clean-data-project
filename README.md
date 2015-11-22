# get-and-clean-data-project
The goal of this project is to build a tidy data set from the [ UCI Human Activity Recognition database](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The [raw data] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) includes the following files:

- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

It contains the data captured from the smartphones of 30 different volunteers performing 6 different activities. This data was divided into a training and a test set.

The script merges the training and test data along with the subject identifiers and the labels. Only those features with means and standard deviations were kept. The script then creates a [ tidy data set ] (vita.had.co.nz/papers/tidy-data.pdf) containing the means of all every feature grouped by the subject and activity. The 'tidied' data is available in tidy_data.txt.

Note : This file can be directly read into R using read.table("tidy_data.txt", header = TRUE)

More details in the CodeBook.md