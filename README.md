# Tidy Data for Samsung

The script in the first level load the neccesary packages and then load the appropriate data files. Then names the colunm name of x_text and x_train according to features. After that extracts only the measurements on the mean and standard deviation for each measurement. Then extracts the special features of x_text and x_train and loads activity labels for y_test. Naming the columns of y_test and subject_test in the next level and loads activity labels for y_train and names the columns of y_train. Then names the columns of subject_train. In the final steps the script binds the data and combining them in a full dataset. After melting the data applys mean funcion to it and finally creats the output tidy_data.txt.

## CodeBook
