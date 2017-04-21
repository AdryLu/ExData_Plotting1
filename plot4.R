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

##PLOT 4
png("plot4.png",width = 480, height = 480)
par(mfrow=c(2,2))
plot(powerdata$Date+powerdata$Time,powerdata$Global_active_power,type="l",ylab = "Global Active Power (kilowatts)",xlab="")
plot(powerdata$Date+powerdata$Time,powerdata$Voltage,type="l",ylab = "Voltage",xlab="datetime")
plot(powerdata$Date+powerdata$Time,powerdata$Sub_metering_1,type="n",ylab="Energy sub metering ",xlab = "")
lines(powerdata$Date+powerdata$Time,powerdata$Sub_metering_1,col="black")
lines(powerdata$Date+powerdata$Time,powerdata$Sub_metering_2,col="red")
lines(powerdata$Date+powerdata$Time,powerdata$Sub_metering_3,col="blue")
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n")
plot(powerdata$Date+powerdata$Time,powerdata$Global_reactive_power,type="l",ylab = "Global_reactive_power",xlab="datetime")
dev.off()
