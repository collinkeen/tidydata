library(dplyr)
library(reshape2)


##read in the test and train data from the working directory
train <- read.table("UCI Har dataset/train/x_train.txt")
test <- read.table("UCI Har dataset/test/x_test.txt")
##read the description and subject crossover tables
descriptor_train <- read.table("UCI Har dataset/train/y_train.txt")
subject_train <- read.table("UCI Har dataset/train/subject_train.txt")
descriptor_test <- read.table("UCI Har dataset/test/y_test.txt")
subject_test <- read.table("UCI Har dataset/test/subject_test.txt")
##read files for the labels and the activity
labels <- read.table("UCI Har dataset/features.txt")
activity <- read.table("UCI Har dataset/activity_labels.txt")

##derive the type and subject data to apply to main tables
names(descriptor_train) <- c("type")
names(descriptor_test) <- c("type")
names(subject_test) <- c("subject")
names(subject_train) <- c("subject")

##put the train and test columns for description and subject back into tables
train <- bind_cols(train,descriptor_train)
test <- bind_cols(test,descriptor_test)
train <- bind_cols(train,subject_train)
test <- bind_cols(test,subject_test)

##put proper data back together
combined <- bind_rows(train,test)

##change the labels of the table
newlabels <- as.character(labels[, "V2"])
newlabels1 <- append(newlabels,c("type","subject"))
colnames(combined) <- newlabels1

##pull all columns that have 'mean' in the column name as well as the type and subject columns
grep('mean|type',colnames(combined))
smalldata <- combined[,grep('mean|type|subject',colnames(combined))]
smalldata$type <- with(activity, V2[match(smalldata$type, V1)])

##work with each activity type to derive mean of each factor for each subject
standing <- filter(smalldata,type=="STANDING")
factors <- colnames(standing)
factors <- factors[c(-47,-48)]
factors <- match(factors, colnames(standing))
standing <- standing %>% group_by(subject) %>% summarise_each(funs(mean(.,na.rm=TRUE)), factors)
standing$activity <- "STANDING"

sitting <- filter(smalldata,type=="SITTING")
factors <- colnames(sitting)
factors <- factors[c(-47,-48)]
factors <- match(factors, colnames(sitting))
sitting <- sitting %>% group_by(subject) %>% summarise_each(funs(mean(.,na.rm=TRUE)), factors)
sitting$activity <- "SITTING"

laying <- filter(smalldata,type=="LAYING")
factors <- colnames(laying)
factors <- factors[c(-47,-48)]
factors <- match(factors, colnames(laying))
laying <- laying %>% group_by(subject) %>% summarise_each(funs(mean(.,na.rm=TRUE)), factors)
laying$activity <- "LAYING"

walking <- filter(smalldata,type=="WALKING")
factors <- colnames(walking)
factors <- factors[c(-47,-48)]
factors <- match(factors, colnames(walking))
walking <- walking %>% group_by(subject) %>% summarise_each(funs(mean(.,na.rm=TRUE)), factors)
walking$activity <- "WALKING"

walking_up <- filter(smalldata,type=="WALKING_UPSTAIRS")
factors <- colnames(walking_up)
factors <- factors[c(-47,-48)]
factors <- match(factors, colnames(walking_up))
walking_up <- walking_up %>% group_by(subject) %>% summarise_each(funs(mean(.,na.rm=TRUE)), factors)
walking_up$activity <- "WALKING_UPSTAIRS"

walking_down <- filter(smalldata,type=="WALKING_DOWNSTAIRS")
factors <- colnames(walking_down)
factors <- factors[c(-47,-48)]
factors <- match(factors, colnames(walking_down))
walking_down <- walking_down %>% group_by(subject) %>% summarise_each(funs(mean(.,na.rm=TRUE)), factors)
walking_down$activity <- "WALKING_DOWNSTAIRS"

##take each filtered set of data by activity and combine all data for final data set
final_data <- bind_rows(laying,sitting,standing,walking,walking_down,walking_up)
