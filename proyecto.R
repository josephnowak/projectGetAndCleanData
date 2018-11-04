# projectGetAndCleanData
#Clean and use data from a samsung galaxy 2
#sorry for the grammatical  errors, I'm not a native speaker
library(dplyr)
getTableFromText <- function(pathData , type)
{
  #obtain all the files inside the pathData
  filesTxt <- list.files(pathData , pattern = ".*.txt")
  g <- as.data.frame(sapply(filesTxt , function(x){
    #create a dataframe from all of them except for the larger data X_train or X_test
    if(x != "X_train.txt" && x != "X_test.txt") {
      t <- unlist(strsplit(readLines(paste(pathData , '\\' , x , sep = "")) , " |\n"))
      t <- as.numeric(t[t != ""])
      return(t)
    }
    return(NA)
  }))
  colnames(g) <- c("subject" , "xT" , "yT")
  #analize every string inside features because this are the columns of the data frame
  p <- "C:\\Users\\josep\\Desktop\\cursos\\GetAndCleanData\\UCI HAR Dataset\\features.txt"
  #clear the names
  features <- gsub("^ *[0-9]* |,|-|\\()","" ,sapply(read.delim(p , head =F) , function(x) x ))
  #depending on the variables type it select one of the two files
  if(type) p <- paste(pathData,"\\" , "X_train.txt" , sep = "")
  else p <- paste(pathData, "\\" ,"X_test.txt" , sep = "")
  #read the file
  dat <- unlist(strsplit(readLines(p) , " |\n"))
  dat <- as.numeric(dat[dat != ""])
  m <- length(features)
  n <- length(dat)
  #create a data frame from all the data in one of the file X and use the fact that they are separate it by the number of column
  #in this case every 561 is a new data for a specific column,It is base in the length of features 
  h <- data.frame(sapply(1:m , function(x) sapply(seq(x , n , m) , function(y) return(dat[y]))))
  #put the names
  colnames(h) <- features
  #obtain only the columns that are mean or std
  nombres <- tolower(colnames(h))
  h <- h[, grepl("mean" , nombres,fixed = TRUE) | grepl( "std",nombres ,fixed = TRUE)]
  #append the subject and the type of activity
  h$subject <- g$subject
  h$yT <- g$yT
  return(h)
}

h <- getTableFromText("C:\\Users\\josep\\Desktop\\cursos\\GetAndCleanData\\UCI HAR Dataset\\train" , TRUE)

g <- getTableFromText("C:\\Users\\josep\\Desktop\\cursos\\GetAndCleanData\\UCI HAR Dataset\\test" , FALSE)
#combine the two table 
e <- rbind(h , g)
#group by subject and by activity and then obtain the mean of every column
e <- e %>% group_by(subject , yT) %>% summarise_at(vars(-(subject:yT)) , mean)
print(dim(e))
