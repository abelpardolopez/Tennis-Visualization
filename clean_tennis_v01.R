#Source [http://www.tennis-data.co.uk](http://www.tennis-data.co.uk)

#Libraries
library(dplyr,quietly=TRUE, warn.conflicts = FALSE)
library(data.table,quietly=TRUE, warn.conflicts = FALSE)
library(reshape2,quietly=TRUE, warn.conflicts = FALSE)
library(tidyr,quietly=TRUE, warn.conflicts = FALSE)
library(lubridate,quietly=TRUE, warn.conflicts = FALSE)
library(ggplot2,quietly=TRUE, warn.conflicts = FALSE)
library(xtable,quietly=TRUE, warn.conflicts = FALSE)
library(readr,quietly=TRUE, warn.conflicts = FALSE)
library(tibble,quietly=TRUE, warn.conflicts = FALSE)
library(magrittr,quietly=TRUE, warn.conflicts = FALSE)
library(stringr,quietly=TRUE, warn.conflicts = FALSE)

setwd("C:/Users/ABEL/Desktop/BigData/ExCourse/03-Data_Visualization/proyecto/data")

cleanData<-function(file){
        data<-read_csv(file,col_types = list(
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
                Best_of=col_integer(),
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
                BandWW=col_double(),
                BandWL=col_double(),
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
        # Rows Clean
        cleanData <- data%>% filter(Best_of==3) %>% filter(Comment=='Completed', !is.na(WRank), !is.na(LRank))
        # Column Clean
        cleanData %<>% select(-Best_of,-Comment,-Location) %>% select(-WPts, -LPts, -W1, -L1, -W2, -L2, -W3, -L3, -Wsets, -Lsets)
        cleanData %<>% select(-B365W, -B365L, -CBW, -CBL, -EXW, -EXL, -PSW, -PSL, -UBW, -UBL, -LBW, -LBL, -BandWW, -BandWL,-MaxW, -MaxL, -AvgW, -AvgL)
        cleanData %<>% select( -Tournament, -Court, -Round, -Winner, -Loser)
        cleanData %<>% mutate (Year = year(Date))  %>% filter (Year != "NA")
        cleanData %<>% select (-Date)
}

# Clean Mens data for analysis of frequency of 3 sets match with the
# there are exclude the matcheses where the number of sets is higher than 3.
men<-cleanData('./data/results/allMen.csv')  %>% select(-W4,-W5,-L4,-L5) %>% select(-ATP, -Series, -GBW,-GBL, -IWW,-IWL, -SBW, -SBL, -SJW, -SJL)
men$Sex = 'M'
women<-cleanData('./data/results/allWomen.csv') %>% select(-WTA, -Tier)
women$Sex = 'W'
all = rbind(men, women)
write.table(all,"./data/results/allTennisMatch_20180515.csv",row.name=FALSE,sep = ",")
rm(list = setdiff(ls(), lsf.str()))

