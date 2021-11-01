

setwd("~/Coursera 2021/Getting-and-Cleaning-Data-Course-Project")
if(!file.exists("./data")){
  dir.create("./data")
}
furl<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists("./data/data.zip")) {
  download.file(furl, destfile = "./data/data.zip")
  unzip(zipfile = "./data/data.zip", exdir = "./data")
}

pathrf <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(pathrf, recursive=TRUE)
files
xt <- read.table(paste(sep = "", "./data", "/UCI HAR Dataset/train/X_train.txt"))
yt <- read.table(paste(sep = "", "./data", "/UCI HAR Dataset/train/Y_train.txt"))
subt <- read.table(paste(sep = "", "./data", "/UCI HAR Dataset/train/subject_train.txt"))

xts <- read.table(paste(sep = "", "./data", "/UCI HAR Dataset/test/X_test.txt"))
yts <- read.table(paste(sep = "", "./data", "/UCI HAR Dataset/test/Y_test.txt"))
subts <- read.table(paste(sep = "", "./data", "/UCI HAR Dataset/test/subject_test.txt"))

xdat <- rbind(xt, xts)
ydat <- rbind(yt, yts)
subdat <- rbind(subt, subts)

ftr <- read.table(paste(sep = "", "./data", "/UCI HAR Dataset/features.txt"))
alab <- read.table(paste(sep = "", "./data", "/UCI HAR Dataset/activity_labels.txt"))
alab[,2] <- as.character(alab[,2])

scols <- grep("-(mean|std).*", as.character(ftr[,2]))
sColN <- ftr[scols, 2]
sColN <- gsub("-mean", "Mean", sColN)
sColN <- gsub("-std", "Std", sColN)
sColN <- gsub("[-()]", "", sColN)

xdat <- xdat[scols]
alldat <- cbind(subdat, ydat, xdat)
colnames(alldat) <- c("Subject", "Activity", sColN)
alldat$Activity <- factor(alldat$Activity, levels = alab[,1], labels = alab[,2])
alldat$Subject <- as.factor(alldat$Subject)

library(reshape2)
mdat <- melt(alldat, id = c("Subject", "Activity"))
tdat <- dcast(mdat, Subject + Activity ~ variable, mean)
write.table(tdat, "./tidydata.txt", row.names = FALSE, quote = FALSE)

