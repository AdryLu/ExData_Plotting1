# Estimate the size of the dataset in MB
size<-2075259*9*8/2^20
filename<-"household_power_consumption.txt"
## Reads only the date column in the file 
powerdates<-read.table(filename,header=TRUE,sep=";",na.strings="?", colClasses = c("character", rep("NULL", 8)))
## Find the dates in the range of interest
index<-powerdates=="1/2/2007" | powerdates=="2/2/2007"
firstrow=min(which(index == TRUE))
numrows=sum(index)
##firstrow=66637
##nrows=2880
##Remove temporary data
rm(powerdates,index)
#import power data]
powerheader<-read.table(filename,nrows=1,sep=";",colClasses = rep("character",8))
powerdata<-read.table(filename,header=FALSE,sep=";",na.strings="?",colClasses=c("character","character",rep("numeric",7)),skip=firstrow,nrows=numrows,col.names = powerheader)
rm(powerheader)

##Load package lubridate to format the date and time
##Date: Date in format dd/mm/yyyy
##Time: time in format hh:mm:ss

library(lubridate)
powerdata$Date<-dmy(powerdata$Date)
powerdata$Time<-hms(powerdata$Time)

## PLOT 1
## open plotting device
png("plot1.png",width = 480,height = 480)
hist(powerdata$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
## disconect plotting device
dev.off()
