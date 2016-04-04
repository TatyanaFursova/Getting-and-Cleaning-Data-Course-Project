run_analysis<-function(){
	library(data.table)
	library(dplyr)
	library(reshape)

#1. Merges the training and the test sets to create one data set.

	train<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt") #read train Matrix
	teat<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt") #read test Matrix
	dt<-rbind(train, teat) # Combine train and test matrices

#4. Appropriately labels the data set with descriptive variable names. 	

	dn<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt") #read variable names (feachers names)
	names<-as.vector(dn$V2) #Convert names-dataframe to vector
	colnames(dt)=names #Give the appropriate names to the dataframe

#2. Extracts only the measurements on the mean and standard deviation for each measurement.	

	m_data<-dt[,grepl('mean()', names(dt))] #read to a new dataframe variables with names that contain "mean()"
	s_data<-dt[,grepl('std()', names(dt))] #read to a new dataframe variables with names that contain "std()"
	ms_data<-cbind(m_data, s_data) #combine "mean()" and "std()" dataframes
	write.table(ms_data, file="./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/ms_tidy.txt", row.names = FALSE) #Write mean-std data set to the workspace

#3. Uses descriptive activity names to name the activities in the data set

	subj_train<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")# read subject data set for train matrix
	subj_test<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt") # read subject data set for test matrix
	subj<-rbind(subj_train, subj_test) #combine train and test subject data sets 
	f_data<-mutate(ms_data, subject = subj[,1])# add a new column "subject" to mead-std - dataframe
	ActY_tr<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")# read activity labels for train matrix
	ActY_tt<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt") # read activity labels for test matrix
	Active<-rbind(ActY_tr, ActY_tt) # combine train and test activity labels dataframes
	f_data<-mutate(f_data, Activity = Active[,1]) # add a new column "Activity" to mean-std-dataframe 
	act<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt") #read activity names tada set
	a_data<-merge(f_data, act, by.x = "Activity", by.y = "V1")# Merge mean-std-dataframe with activity name dataframe by "activity code", send data to new dataframe 
	colnames(a_data)[82]<-"Activity" # Rename variable 
	write.table(a_data, file="./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/a_data.txt", row.names = FALSE)#Write mean-std data set with "subject" and "Activity" columns to the workspace

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.	

	m_data<-melt(a_data, id=c("Activity", "subject")) #Melt dataframe my two IDs- "Activity" and "subject, send the result to a new dataframe
	g_data<-group_by(m_data, Activity, subject, variable)#Group  dataframe by three groups -  "Activity", "Subject", "variable", send the result to a new dataframe 
	s_data<-summarize(g_data, Average=mean(value)) #Summirize dataframe using mean-function on "Value"-variable, wend the result to a new dataframe
	s_data<-merge(s_data, act, by.x = "Activity", by.y = "V1") #Add a column with activity names
	s_data<-select(s_data, V2, subject, variable, Average)#Order columns in appropriate range
	colnames(s_data)[1]<-"Activity" #Rename column
	write.table(s_data, file="./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/tidy.txt", row.names = FALSE)# Write data to the .txt - file on my workplace	
}