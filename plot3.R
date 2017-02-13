## Create data directory if it doesn't exist
if(!file.exists("./data")) {
  dir.create("./data")
}

## Download file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata_data_household_power_consumption.zip"
download.file(fileUrl, destfile = "~/Coursera/Course4/Week1/data/exdata_data_household_power_consumption.zip", method = "curl")

## Read data
power_data <- read.table("~/Desktop/Coursera/Course4/Week1/data/household_power_consumption.txt", header = TRUE, sep = ";", dec = ".")

## Subset by dates February 1, 2007 and February 2, 2007
power_data.sub <- subset(power_data, Date == "1/2/2007" | Date == "2/2/2007")

## Convert Sub metering 1, Sub metering 2, and Sub metering 3 from factors to numerics
power_data.sub$Sub_metering_1 <- as.numeric(levels(power_data.sub$Sub_metering_1))[as.integer(power_data.sub$Sub_metering_1)]
power_data.sub$Sub_metering_2 <- as.numeric(levels(power_data.sub$Sub_metering_2))[as.integer(power_data.sub$Sub_metering_2)]
power_data.sub$Sub_metering_3 <- as.numeric(levels(power_data.sub$Sub_metering_3))[as.integer(power_data.sub$Sub_metering_3)]

## Get abbreviated weekdays for x-axis labels
install.packages("lubridate")
power_data.sub$Date <- as.Date(power_data.sub$Date)
weekday <- wday(power_data.sub$Date, label=TRUE)

## Plot three lines
png(filename="plot3.png", width=480, height=480)	
par(mar=c(5.1,6.1,4.1,2.1))
plot(power_data.sub$Sub_metering_1, type = "l", xaxt = "n", xlab = " ", ylab = "Energy sub metering", col="black")
lines(power_data.sub$Sub_metering_2, col="red")
lines(power_data.sub$Sub_metering_3, col="blue")

## Plot legend    
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col=c("black", "red", "blue"))

## Plot x axis labels
axis(1, at = c(1, nrow(power_data.sub)/2, nrow(power_data.sub)), 
labels=c(weekday[1], weekday[nrow(power_data.sub)/2+1, weekday[nrow(power_data.sub)+1]))

dev.off()
