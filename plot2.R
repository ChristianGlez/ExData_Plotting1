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

## Plot for Global Active Power distributed by Days
par(mfrow = c(1, 1))
plot(hpcDataRange$Time, hpcDataRange$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

dev.copy(png, file = "./plot2.png")
dev.off()


