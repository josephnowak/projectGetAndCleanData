library(dplyr)
getTableFromText <- function(pathData , type)
{
  filesTxt <- list.files(pathData , pattern = ".*.txt")
  print(filesTxt)
  
  g <- as.data.frame(sapply(filesTxt , function(x){
        if(x != "X_train.txt" || x != "X_test.txt") {
          t <- unlist(strsplit(readLines(paste(pathData , '\\' , x , sep = "")) , " |\n"))
          t <- as.numeric(t[t != ""])
          return(t)
        }
        return(NA)
      }
    )
  )
  colnames(g) <- c("subject" , "xT" , "yT")
  p <- "C:\\Users\\josep\\Desktop\\cursos\\GetAndCleanData\\UCI HAR Dataset\\features.txt"
  features <- sapply(read.delim(p , head =F) , function(x)x)
  features <- gsub("^ *[0-9]* |,|-|\\()","",features)
  
  if(type) p <- paste(pathData,"\\" , "X_train.txt" , sep = "")
  else p <- paste(pathData, "\\" ,"X_test.txt" , sep = "")
  dat <- unlist(strsplit(readLines(p) , " |\n"))
  dat <- as.numeric(dat[dat != ""])
  m <- length(features)
  n <- length(dat)
  print("here")
  h <- sapply(1:m , function(x) sapply(seq(x , n , m) , function(y) dat[y]))
  h <- data.frame(h)
  colnames(h) <- features
  h$subject <- g$subject
  h$yT <- g$yT
  return(h)
}
h <- getTableFromText("C:\\Users\\josep\\Desktop\\cursos\\GetAndCleanData\\UCI HAR Dataset\\train" , TRUE)
head(h,5)
class(h)



g <- getTableFromText("C:\\Users\\josep\\Desktop\\cursos\\GetAndCleanData\\UCI HAR Dataset\\test" , FALSE)

e <- rbind(h , ge)

