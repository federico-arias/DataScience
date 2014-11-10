#Appropriately labels the data set with descriptive variable names.
colnames <- read.table('features.txt', col.names=c('id', 'names'))

x_train <-read.table('train/X_train.txt', col.names=colnames$names)
subject_train <- read.table('train/subject_train.txt', col.names=c('subjectID'))

x_test <-read.table('test/X_test.txt', col.names=colnames$names)
subject_test <- read.table('test/subject_test.txt', col.names=c('subjectID'))

#Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table('activity_labels.txt', col.names= c('id', 'activities'))
y_train <- read.table ('train/y_train.txt', col.names = c('id'))
y_test <- read.table ('test/y_test.txt', col.names = c('id'))

y_train <- merge(y_train, activity_labels, by='id', all.x=T, sort=F)
y_test <- merge(y_test, activity_labels, by='id', all.x=T, sort=F)

#Merges the training and the test sets to create one data set.
one_dataset <- cbind(rbind(subject_train, subject_test), rbind(x_train,x_test), rbind(y_train,y_test))

#Extracts only the measurements on the mean and standard deviation for each measurement. 
colId <- grep("([mM]ean)|(std)|(activities)|(subjectID)", colnames(one_dataset))
one_dataset <- one_dataset[,colId]

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_ds <- with(one_dataset, ave(x=one_dataset, activities, subjectID, FUN=mean))
