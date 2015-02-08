## Household Power Consumption data from the UC Irvine Machine Learning Repository
## Downloaded from: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

## Download Zip

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "./household_power_consumption.zip", method = "curl")

## Unzip
unzip(zipfile = "./household_power_consumption.zip", exdir = ".")

## Read data
hpcData = read.table("./household_power_consumption.txt", 
                     header = TRUE,
                     sep = ";",
                     na.strings = "?")

## Convert Dates
DateTime <- paste(hpcData$Date, hpcData$Time)
hpcData$Time <- strptime(DateTime, "%d/%m/%Y %H:%M:%S")
hpcData$Date <- as.Date(hpcData$Date, "%d/%m/%Y")
rm(DateTime)

## Remove unneeded records
hpcDataRange <- hpcData[hpcData$Date >= "2007-02-01" & hpcData$Date <= "2007-02-02",]
rm(hpcData)

par(mfrow = c(1, 1))

## Plot for Global Active Power distributed by Days
with(hpcDataRange, plot(hpcDataRange$Time, hpcDataRange$Sub_metering_1, 
     type = "n",
     xlab = "",
     ylab = "Energy sub metering"))
points(hpcDataRange$Time, hpcDataRange$Sub_metering_1, 
       type = "l", 
       col = "black")
points(hpcDataRange$Time, hpcDataRange$Sub_metering_2, 
       type = "l", 
       col = "red")
points(hpcDataRange$Time, hpcDataRange$Sub_metering_3, 
       type = "l", 
       col = "blue")
legend("topright", cex=1, lwd = 2, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Save the PNG to the filesystem
dev.copy(png, file = "./plot3.png")
dev.off()


