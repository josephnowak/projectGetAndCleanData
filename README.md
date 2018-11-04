
I used basic letters (h for the train,g for the test) to save the dataframe that is returned from the function "getTableFromText"
which recived two parameters one is the path to the folder and other is a boolean value for distinguish betweeen "X_train.txt" 
and "X_test.txt" (I have to do this due to the way I programmed this).

Inside of the function I read every file inside the path and create a data frame from them excluding the X_test.txt or X_test.txt files
after that I read the columns from features.txt and then create a dataframe from them using two sapply cycle and seq (taken the fact of that X_*.txt is organized by jumps of m space where m is given by the number of columns in features it generate a sequence)
After that I putted the name to the columns that of course where cleaned eleminating space and other special chracter
Then I put the subject and the activities inside the dataframe and return it

By last I merge h and g and create a new data frame which is groupped by subject and activities and then calculate the mean for every column
