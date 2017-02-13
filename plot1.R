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

## Plot as png file
png(filename="plot1.png", width=480, height=480)
hist(power_data.sub$Global_active_power, col = "red", 
     xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
