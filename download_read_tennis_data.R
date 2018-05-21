#Source [http://www.tennis-data.co.uk](http://www.tennis-data.co.uk)

#Libraries
#library(xlsx,quietly=TRUE, warn.conflicts = FALSE)
library(readxl,quietly=TRUE, warn.conflicts = FALSE)
library(dplyr,quietly=TRUE, warn.conflicts = FALSE)
library(data.table,quietly=TRUE, warn.conflicts = FALSE)
library(reshape2,quietly=TRUE, warn.conflicts = FALSE)
library(tidyr,quietly=TRUE, warn.conflicts = FALSE)
library(lubridate,quietly=TRUE, warn.conflicts = FALSE)
library(ggplot2,quietly=TRUE, warn.conflicts = FALSE)
library(xtable,quietly=TRUE, warn.conflicts = FALSE)
library(readr,quietly=TRUE, warn.conflicts = FALSE)
library(tibble,quietly=TRUE, warn.conflicts = FALSE)
library(stringr,quietly=TRUE, warn.conflicts = FALSE)

multi_join <- function(list_of_loaded_data, join_func, ...){

        require("dplyr")

        output <- Reduce(function(x, y) {join_func(x, y, ...)}, list_of_loaded_data)

        return(output)
}
read_list <- function(path,list_of_datasets, read_func,...){

        read_and_assign <- function(dataset, read_func,...){
                dataset_name <- as.name(dataset)
                dataset_name <- read_func(dataset,...)
        }

        # invisible is used to suppress the unneeded output
        final<-paste0(path,list_of_datasets)
        output <- invisible(
                sapply(final,
                       read_and_assign, read_func = read_func,..., simplify = FALSE, USE.NAMES = TRUE))

        # Remove the extension at the end of the data set names
        names_of_datasets <- c(unlist(strsplit(list_of_datasets, "[.]"))[c(T, F)])
        names(output) <- names_of_datasets
        return(output)
}
setwd("C:/Users/ABEL/Desktop/BigData/ExCourse/03-Data_Visualization/proyecto/data")

codebook<-"http://www.tennis-data.co.uk/notes.txt"
urlArray<-c('http://www.tennis-data.co.uk/2018/2018.zip',
            'http://www.tennis-data.co.uk/2017/2017.zip',
            'http://www.tennis-data.co.uk/2016/2016.zip',
            'http://www.tennis-data.co.uk/2015/2015.zip',
            'http://www.tennis-data.co.uk/2014/2014.zip',
            'http://www.tennis-data.co.uk/2013/2013.zip',
            'http://www.tennis-data.co.uk/2012/2012.zip',
            'http://www.tennis-data.co.uk/2011/2011.zip',
            'http://www.tennis-data.co.uk/2010/2010.zip',
            'http://www.tennis-data.co.uk/2009/2009.zip',
            'http://www.tennis-data.co.uk/2008/2008.zip',
            'http://www.tennis-data.co.uk/2007/2007.zip',
            'http://www.tennis-data.co.uk/2006/2006.zip',
            'http://www.tennis-data.co.uk/2005/2005.zip',
            'http://www.tennis-data.co.uk/2004/2004.zip',
            'http://www.tennis-data.co.uk/2003/2003.zip',
            'http://www.tennis-data.co.uk/2002/2002.zip',
            'http://www.tennis-data.co.uk/2001/2001.zip',
            'http://www.tennis-data.co.uk/2000/2000.zip',
            'http://www.tennis-data.co.uk/2018w/2018.zip',
            'http://www.tennis-data.co.uk/2017w/2017.zip',
            'http://www.tennis-data.co.uk/2016w/2016.zip',
            'http://www.tennis-data.co.uk/2015w/2015.zip',
            'http://www.tennis-data.co.uk/2014w/2014.zip',
            'http://www.tennis-data.co.uk/2013w/2013.zip',
            'http://www.tennis-data.co.uk/2012w/2012.zip',
            'http://www.tennis-data.co.uk/2011w/2011.zip',
            'http://www.tennis-data.co.uk/2010w/2010.zip',
            'http://www.tennis-data.co.uk/2009w/2009.zip',
            'http://www.tennis-data.co.uk/2008w/2008.zip',
            'http://www.tennis-data.co.uk/2007w/2007.zip')

if(!file.exists("./data")){
        dir.create("./data")# Create a folder to save the data.
        print("Data Folder Created")
}
if(!file.exists("./data/codebook.txt")){
        download.file(codebook,destfile = "./data/codebook.txt") #Download Code Book
}
if(!file.exists("./data/men")){
        dir.create("./data/men")# Create a folder to save the data.
        print("Data Men Folder Created")
}
if(!file.exists("./data/women")){
        dir.create("./data/women")# Create a folder to save the data.
        print("Data Women Folder Created")
}
# Loop all urls to see if it exist download it, unzip and clean
outfiles=rep("",length(urlArray))
for(i in 1:length(urlArray)){
        #zip name
        pathName<-strsplit(dirname(urlArray[i]),"/")[[1]]
        ligue<-as.character(pathName[length(pathName)])
        outZip<-paste0("./data/",ligue,".zip")
        if(!file.exists(outZip)){
                # Downloading zip file
                print(paste0("Downloading file ",basename(outZip)))
                download.file(urlArray[i],destfile = outZip)
        }
        folderLigue<-paste0("./data/",ligue)
        if(!file.exists(folderLigue)){
                print(paste0("Unzipping Ligue ",ligue))
                dir.create(folderLigue)
                unzip(zipfile = outZip,exdir=folderLigue)
        }
        files<-list.files(path=folderLigue)

        if (str_count(ligue,"w")>0){
                outFile<-paste0("./data/women/",ligue,".csv")
        }else{
                outFile<-paste0("./data/men/",ligue,".csv")
        }
        if(!file.exists(outFile)){
                inputFile=paste0(folderLigue,"/",files[1])
                print(paste0("Reading file: ",inputFile))
                dataset<-read_excel(inputFile)
                # Original reading Date
                #dataset$Date<-dmy(dataset$Date)

                print(paste0("Writing file ",outFile))
                #
                write.table(dataset,outFile,row.name=FALSE,sep = ",")
                #outfiles[i]=outFile
                rm(dataset)
        }
        rm(files)
}
# Women Folder
print ("Women Files")
list_of_data_sets <- read_list(path="./data/women/",list.files(path="./data/women/", pattern = ".csv"), read_csv,
                               col_types=list(
                                       ATP=col_integer(),
                                       WTA=col_integer(),
                                       Location=col_character(),
                                       Tournament=col_character(),
                                       Date=col_date(),
                                       Series=col_character(),
                                       Tier=col_integer(),
                                       Court=col_character(),
                                       Surface=col_character(),
                                       Round=col_character(),
                                       #Best_of=col_integer(),
                                       Winner=col_character(),
                                       Loser=col_character(),
                                       WRank=col_integer(),
                                       LRank=col_integer(),
                                       WPts=col_integer(),
                                       LPts=col_integer(),
                                       W1=col_integer(),
                                       L1=col_integer(),
                                       W2=col_integer(),
                                       L2=col_integer(),
                                       W3=col_integer(),
                                       L3=col_integer(),
                                       W4=col_integer(),
                                       L4=col_integer(),
                                       W5=col_integer(),
                                       L5=col_integer(),
                                       Wsets=col_integer(),
                                       Lsets=col_integer(),
                                       Comment=col_character(),
                                       B365W=col_double(),
                                       B365L=col_double(),
                                      # B.WW=col_double(),
                                      # B.WL=col_double(),
                                       CBW=col_double(),
                                       CBL=col_double(),
                                       EXW=col_double(),
                                       EXL=col_double(),
                                       LBW=col_double(),
                                       LBL=col_double(),
                                       GBW=col_double(),
                                       GBL=col_double(),
                                       IWW=col_double(),
                                       IWL=col_double(),
                                       PSW=col_double(),
                                       PSL=col_double(),
                                       SBW=col_double(),
                                       SBL=col_double(),
                                       SJW=col_double(),
                                       SJL=col_double(),
                                       UBW=col_double(),
                                       UBL=col_double(),
                                       MaxW=col_double(),
                                       MaxL=col_double(),
                                       AvgW=col_double(),
                                       AvgL=col_double()
                               ))

merged_data <- multi_join(list_of_data_sets, full_join)
colnames(merged_data)[9]="Best_of"
colnames(merged_data)[37]="BandWW"
colnames(merged_data)[38]="BandWL"

write.table(merged_data,"./data/results/allWomen.csv",row.name=FALSE,sep = ",")
rm(merged_data)
# Men Folder
print ("Men Files")
list_of_data_sets <- read_list(path="./data/men/",list.files(path="./data/men/", pattern = ".csv"), read_csv,
                               col_types=list(
                                       ATP=col_integer(),
                                       WTA=col_integer(),
                                       Location=col_character(),
                                       Tournament=col_character(),
                                       Date=col_date(),
                                       Series=col_character(),
                                       Tier=col_integer(),
                                       Court=col_character(),
                                       Surface=col_character(),
                                       Round=col_character(),
                                      # Best_of=col_integer(),
                                       Winner=col_character(),
                                       Loser=col_character(),
                                       WRank=col_integer(),
                                       LRank=col_integer(),
                                       WPts=col_integer(),
                                       LPts=col_integer(),
                                       W1=col_integer(),
                                       L1=col_integer(),
                                       W2=col_integer(),
                                       L2=col_integer(),
                                       W3=col_integer(),
                                       L3=col_integer(),
                                       W4=col_integer(),
                                       L4=col_integer(),
                                       W5=col_integer(),
                                       L5=col_integer(),
                                       Wsets=col_integer(),
                                       Lsets=col_integer(),
                                       Comment=col_character(),
                                       B365W=col_double(),
                                       B365L=col_double(),
                                       #B.WW=col_double(),
                                       #B.WL=col_double(),
                                       CBW=col_double(),
                                       CBL=col_double(),
                                       EXW=col_double(),
                                       EXL=col_double(),
                                       LBW=col_double(),
                                       LBL=col_double(),
                                       GBW=col_double(),
                                       GBL=col_double(),
                                       IWW=col_double(),
                                       IWL=col_double(),
                                       PSW=col_double(),
                                       PSL=col_double(),
                                       SBW=col_double(),
                                       SBL=col_double(),
                                       SJW=col_double(),
                                       SJL=col_double(),
                                       UBW=col_double(),
                                       UBL=col_double(),
                                       MaxW=col_double(),
                                       MaxL=col_double(),
                                       AvgW=col_double(),
                                       AvgL=col_double()
                               ))
merged_data <- multi_join(list_of_data_sets, full_join)
colnames(merged_data)[9]="Best_of"
colnames(merged_data)[37]="BandWW"
colnames(merged_data)[38]="BandWL"
write.table(merged_data,"./data/results/allMen.csv",row.name=FALSE,sep = ",")
rm(list = setdiff(ls(), lsf.str()))
