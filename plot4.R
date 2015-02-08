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

par(mfrow = c(2, 2), mar = c(4, 4, 1, 1))

with(hpcDataRange, {
  plot(hpcDataRange$Time, hpcDataRange$Global_active_power, 
       type = "l",
       xlab = "",
       ylab = "Global Active Power (kilowatts)")
  plot(hpcDataRange$Time, hpcDataRange$Voltage, 
       type = "l",
       xlab = "datetime",
       ylab = "Voltage")
  plot(hpcDataRange$Time, hpcDataRange$Sub_metering_1, 
       type = "n",
       xlab = "",
       ylab = "Energy sub metering")
  points(hpcDataRange$Time, hpcDataRange$Sub_metering_1, 
         type = "l", 
         col = "black")
  points(hpcDataRange$Time, hpcDataRange$Sub_metering_2, 
         type = "l", 
         col = "red")
  points(hpcDataRange$Time, hpcDataRange$Sub_metering_3, 
         type = "l", 
         col = "blue")
  legend("topright", bty = "n", lwd = 2, cex = 0.75, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(hpcDataRange$Time, hpcDataRange$Global_reactive_power, 
       type = "l",
       xlab = "datetime",
       ylab = "Global_reactive_power")
  
})

## Save the PNG to the filesystem
dev.copy(png, file = "./plot4.png")
dev.off()


