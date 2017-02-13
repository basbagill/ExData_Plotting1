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

## Convert Global active power column from factor to numeric
power_data.sub$Global_active_power <- as.numeric(levels(power_data.sub$Global_active_power))[as.integer(power_data.sub$Global_active_power)]

## Convert Voltage column from factor to numeric
power_data.sub$Voltage <- as.numeric(levels(power_data.sub$Voltage))[as.integer(power_data.sub$Voltage)]

## Convert Sub metering 1, Sub metering 2, and Sub metering 3 from factors to numerics
power_data.sub$Sub_metering_1 <- as.numeric(levels(power_data.sub$Sub_metering_1))[as.integer(power_data.sub$Sub_metering_1)]
power_data.sub$Sub_metering_2 <- as.numeric(levels(power_data.sub$Sub_metering_2))[as.integer(power_data.sub$Sub_metering_2)]
power_data.sub$Sub_metering_3 <- as.numeric(levels(power_data.sub$Sub_metering_3))[as.integer(power_data.sub$Sub_metering_3)]

## Convert Global reactive power column from factor to numeric
power_data.sub$Global_reactive_power <- as.numeric(levels(power_data.sub$Global_reactive_power))[as.integer(power_data.sub$Global_reactive_power)]

png(filename="plot4.png", width=480, height=480)

## Set up space for four graphs
par(mfrow = c(2,2))
par(mar=c(5.1,6.1,1.1,2.1))
 
## Plot upperleft graph
plot(power_data.sub$Global_active_power, type = "l", xaxt = "n", xlab = " ", 
        ylab = "Global Active Power") 
axis(1, at = c(1, nrow(power_data.sub)/2, nrow(power_data.sub)), labels=c("Thu", "Fri", "Sat"))

## Plot upperright graph
plot(power_data.sub$Voltage, type = "l", xaxt = "n", yaxt = "n", xlab = "datetime", ylab = "Voltage")
axis(1, at = c(1, nrow(power_data.sub)/2, nrow(power_data.sub)), labels=c("Thu", "Fri", "Sat"))
axis(2, cex.axis = 0.5)
 
## Plot lowerleft graph
plot(power_data.sub$Sub_metering_1, type = "l", xaxt = "n", xlab = " ", ylab = "Energy sub metering", col="black")
lines(power_data.sub$Sub_metering_2, col="red")
lines(power_data.sub$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col=c("black", "red", 
  		"blue"), cex = 0.65)
axis(1, at = c(1, nrow(power_data.sub)/2, nrow(power_data.sub)), labels=c("Thu", "Fri", "Sat"))
 
## Plot lowerright graph
plot(power_data.sub$Global_reactive_power, type = "l", xaxt = "n", yaxt = "n", xlab = "datetime", ylab 
  		= "Global_reactive_power")
axis(1, at = c(1, nrow(power_data.sub)/2, nrow(power_data.sub)), labels=c("Thu", "Fri", "Sat"))
axis(2, cex.axis = 0.5)

dev.off()

