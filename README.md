
I used basic letters (h for the train,g for the test) to save the dataframe that is returned from the function "getTableFromText"
which recived one parameters that is the path direction

Inside of the function I read every file inside the path and create a data frame from them using read.table and sapply and then I put the names to the columns that are taked from features.txt and then filter by the names of this columns only searching by those who are mean and std.

By last I merge h and g (the two dataframes one from test and one from train) and create a new data frame which is groupped by subject and activities and then calculate the mean for every column
