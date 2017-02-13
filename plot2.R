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

## Get abbreviated weekdays for x-axis labels
install.packages("lubridate")
power_data.sub$Date <- as.Date(power_data.sub$Date)
weekday <- wday(power_data.sub$Date, label=TRUE)

## Plot as png file
png(filename="plot2.png", width=480, height=480)
plot(power_data.sub$Global_active_power, type = "l", xaxt = "n", xlab = " ", 
      ylab = "Global Active Power (kilowatts)")

## Plot x axis labels
axis(1, at = c(1, nrow(power_data.sub)/2, nrow(power_data.sub)), 
     labels=c(weekday[1], weekday[nrow(power_data.sub)/2+1, weekday[nrow(power_data.sub)+1]))

dev.off()
