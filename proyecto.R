# projectGetAndCleanData
#Clean and use data from a samsung galaxy 2
#sorry for the grammatical  errors, I'm not a native speaker
library(dplyr)
getTableFromText <- function(pathData)
{
  #obtain all the files inside the pathData
  filesTxt <- list.files(pathData , pattern = ".*.txt")
  #read every document and create a data frame from them
  h <- as.data.frame(sapply(filesTxt , function(x) read.table(paste(pathData,"\\",x,sep=""))))
  p <- "C:\\Users\\josep\\Desktop\\cursos\\GetAndCleanData\\UCI HAR Dataset\\features.txt"
  #read and clear the names of the columns 
  features <- gsub(",|-|\\()","" ,read.table(p , header = F)[,2] )
  #put the names to the dataframe
  colnames(h) <- c("subject",features , "yT")
  names <- tolower(colnames(h))
  #obtain the specific columns mean and std
  h[ , grepl(".*(mean|std).*|subject|yt" , names)& !grepl("\\(.*(mean|std).*\\)" , names) ]
}
h <- getTableFromText("C:\\Users\\josep\\Desktop\\cursos\\GetAndCleanData\\UCI HAR Dataset\\train")
g <- getTableFromText("C:\\Users\\josep\\Desktop\\cursos\\GetAndCleanData\\UCI HAR Dataset\\test")

#combine the two table 
e <- rbind(h , g)
#group by subject and by activity and then obtain the mean of every column
e <- e %>% group_by(subject , yT)  %>% summarise_at(vars(-c(subject,yT)) , mean)
print(dim(e))
write.table(e , "tidyDataProject.txt",row.name=FALSE )
