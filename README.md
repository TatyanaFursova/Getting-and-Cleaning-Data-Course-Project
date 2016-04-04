# Getting-and-Cleaning-Data-Course-Project
run_analysis - is the function without any parameters. It reads data from the directory "getdata_projectfiles_UCI HAR Dataset" and step by step makes datasets according to instructions:



    1. Merges the training and the test sets to create one data set. (dt - dataframe)
    2. Extracts only the measurements on the mean and standard deviation for each measurement. (ms_data - dataframe)
    3. Uses descriptive activity names to name the activities in the data set (a_data - dataframe)
    4. Appropriately labels the data set with descriptive variable names. (dt - dataframe)
    5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. (s_data dataframe)
    
    run_analysis function also containes everuy step comments
    tidy.txt - s_data dataframe for part 5 of the instruction. 
    ms_tidy.txt - ms_data dataframe for part 2 of the instruction.
    a_data.txt - a_data dataframe for part 3 of the instruction.
