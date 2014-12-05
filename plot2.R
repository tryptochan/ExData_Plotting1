# common part for loading data
library(data.table)
powerdata<-fread("household_power_consumption.txt", sep=";", header=T,
                 na.strings="?", colClasses="character")
powerdata[,Date:=as.Date(powerdata[,Date], format="%d/%m/%Y")]
subdata<-powerdata[Date %between% c(as.Date("2007-02-01"), as.Date("2007-02-02"))]

subdata[,Global_active_power:=as.numeric(Global_active_power)]
# Just use row number as x values
ntimes <- nrow(subdata)
png("plot2.png")
plot(x=1:ntimes,y=subdata$Global_active_power, type="l", axes=F,
     xlab="", ylab="Global Active Power (kilowatts)")
axis(1, at=c(1, ntimes/2, ntimes),labels=c('Thu', 'Fri', 'Sat'))
axis(2, at=seq(0, 6, 2))
box()
dev.off()