# common part for loading data
library(data.table)
powerdata<-fread("household_power_consumption.txt", sep=";", header=T,
                 na.strings="?", colClasses="character")
powerdata[,Date:=as.Date(powerdata[,Date], format="%d/%m/%Y")]
subdata<-powerdata[Date %between% c(as.Date("2007-02-01"), as.Date("2007-02-02"))]

# convert columns 3-9 to numeric
subdata<-subdata[,lapply(.SD, as.numeric), by=.(Date, Time)]
ntimes <- nrow(subdata)


png("plot4.png")
par(mfrow=c(2,2))
# topleft
plot(x=1:ntimes,y=subdata$Global_active_power, type="l", axes=F,
     xlab="", ylab="Global Active Power")
axis(1, at=c(1, ntimes/2, ntimes),labels=c('Thu', 'Fri', 'Sat'))
axis(2, at=seq(0, 6, 2))
box()

# topright
plot(1:ntimes, subdata$Voltage, type='l', axes=F,
     xlab="datetime", ylab="Voltage")
axis(1, at=c(1, ntimes/2, ntimes),labels=c('Thu', 'Fri', 'Sat'))
axis(2, at=seq(234, 246, 4))
box()

# bottomleft
plot(x=1:ntimes,y=subdata$Sub_metering_1, type="l", axes=F,
     xlab="", ylab="Energy sub metering")
lines(x=1:ntimes,y=subdata$Sub_metering_2, col="red")
lines(x=1:ntimes,y=subdata$Sub_metering_3, col="blue")
axis(1, at=c(1, ntimes/2, ntimes),labels=c('Thu', 'Fri', 'Sat'))
axis(2, at=seq(0, 30, 10))
legend("topright",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd=1, col=c("black", "red", "blue"), bty="n")
box()

# bottomright
plot(1:ntimes, subdata$Global_reactive_power, type='l', axes=F,
     xlab="datetime", ylab="Global_reactive_power")
axis(1, at=c(1, ntimes/2, ntimes),labels=c('Thu', 'Fri', 'Sat'))
axis(2, at=seq(0, 0.5, 0.1))
box()

dev.off()
