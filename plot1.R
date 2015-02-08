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
hpcData$Date <- as.Date(hpcData$Date, "%d/%m/%Y")
hpcData$Time <- strptime(hpcData$Time, "%H:%M:%S")

## Remove unneeded records
hpcDataRange <- hpcData[hpcData$Date >= "2007-02-01" & hpcData$Date <= "2007-02-02",]
rm(hpcData)

par(mfrow = c(1, 1))

## Plot histogram for Global Active Power
hist(hpcDataRange$Global_active_power,
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     mar = c(5.1, 5, 2, 3),
     main = "Global Active Power")

dev.copy(png, file = "./plot1.png")
dev.off()


