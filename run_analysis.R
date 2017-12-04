# Loading neccesary packages
library(reshape2)

# Loading neccesary data
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[ ,2]
features <- read.table("./UCI HAR Dataset/features.txt")[ ,2]
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

# Naming colunm name of x_text and x_train according to features
names(x_test) = features
names(x_train) = features

# Extract only the measurements on the mean and standard deviation for each measurement.
special_features <- grepl("mean|std", features)

# Extract the special features of x_text and x_train
x_test = x_test[ ,special_features]
x_train = x_train[ ,special_features]

# Load activity labels for y_test
y_test[ ,2] = activity_labels[y_test[ ,1]]

# Namig the columns of y_test 
names(y_test) = c("Activity_ID", "Activity_Label")

# Namig the columns of subject_test
names(subject_test) = "Subject"

# Load activity labels for y_train
y_train[ ,2] = activity_labels[y_train[ ,1]]

# Namig the columns of y_train
names(y_train) = c("Activity_ID", "Activity_Label")

# Namig the columns of subject_train
names(subject_train) = "Subject"

# Bind data
test_data <- cbind(as.data.table(subject_test), y_test, x_test)
train_data <- cbind(as.data.table(subject_train), y_train, x_train)

# Combining test data and train data
data = rbind(test_data, train_data)

# Melting data
id_labels = c("Subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melt_data = melt(data, id = id_labels, measure.vars = data_labels)

# Apply mean function to dataset
tidy_data = dcast(melt_data, Subject + Activity_Label ~ variable, mean)

# Creating the tidy_data.txt
write.table(tidy_data, file = "./tidy_data.txt")