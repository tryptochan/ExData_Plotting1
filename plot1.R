# common part for loading data
library(data.table)
# With Colclasses, still bumped back to chracter with NA
# http://stackoverflow.com/questions/15784138/bad-interpretation-of-n-a-using-fread
powerdata<-fread("household_power_consumption.txt", sep=";", header=T,
          na.strings="?", colClasses="character")
powerdata[,Date:=as.Date(powerdata[,Date], format="%d/%m/%Y")]
subdata<-powerdata[Date %between% c(as.Date("2007-02-01"), as.Date("2007-02-02"))]

subdata[,Global_active_power:=as.numeric(Global_active_power)]
png("plot1.png")
hist(subdata$Global_active_power, col="red",xlab="Global Active Power (kilowatts)",
     main="Global Active Power")
axis(2, at=seq(0,1200,200))
dev.off()