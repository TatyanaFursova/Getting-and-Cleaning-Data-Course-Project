Source Data:

'train/X_train.txt': Training set.
'test/X_test.txt': Test set.

'train/y_train.txt': Training labels.
'test/y_test.txt': Test labels.

'features.txt': List of all features.

'activity_labels.txt': Links the class labels with their activity name.

'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
'test/subject_test.txt':Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

Merges the training and the test sets to create one data set.

Read train/X_train.txt and test/X_test.txt to a dataframes, create a new dataframe by combining previous two dataframes
Result dataframe: "dt" (without column names)

Appropriately labels the data set with descriptive variable names

read 'features.txt' to a new dataframe ("dn"), then give names to "dt"
Result dataframe: "dt" (with column names)

Extracts only the measurements on the mean and standard deviation for each measurement.	

Extract data of variables with names that contains "mean()" and "std()" using grepl - function
Result dataframe: ms_data

Uses descriptive activity names to name the activities in the data set
read 'train/subject_train.txt' and 'test/subject_test.txt' combining. Add the result as a column to main dataframe (ms_data) using mutate - function
Transitional result dataframe: "f_data"

read 'train/y_train.txt' and 'test/y_test.txt' combining. Add the result as a column to Transitional dataframe (f_data) using mutate-function 
read activity names set 'activity_labels.txt'. Merge Transitional dataframe (f_data) with Activity dataframe by Activity code:
1  1            WALKING
2  2   WALKING_UPSTAIRS
3  3 WALKING_DOWNSTAIRS
4  4            SITTING
5  5           STANDING
6  6             LAYING

Result dataframe: "a_data"

From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Melt "a_data" setting two IDs - "Activity" and "subject" using Melt-function (reshape - package). 
Transitional result dataframe: "m_data"
Group "m_data" by "Activity", "subject", "variable" - columns using group_by - function (dplyr-package). 
Transitional result dataframe: "g_data"
Summarize "g_data" using mean-function on "Value"-column. Rename and arrange columns. Write result to .txt -file
Result dataframe: s_data

