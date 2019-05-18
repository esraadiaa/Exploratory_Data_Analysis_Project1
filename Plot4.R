setwd("C:/Users/ESRAAD/Desktop/Principles of Analytic Graphics/Week1")
path <- "data/exdata_data_household_power_consumption/household_power_consumption.txt"
data <- read.table(path, header = T, sep = ";", na.strings = "?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data <- subset(data, Date >= as.Date("01/02/2007", "%d/%m/%Y") & Date <= as.Date("02/02/2007", "%d/%m/%Y"))
data <- data[complete.cases(data),]
dateTime <- paste(data$Date, data$Time)
dateTime <- setNames(dateTime, "DateTime")
data <- cbind (dateTime, data)
data$dateTime <- as.POSIXct(dateTime)

#plot 4
par(mfrow = c(2,2), mar = c(4, 4, 2, 1), oma=c(0,0,2,0))

plot(data$Global_active_power ~ data$dateTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab="")

plot(data$Voltage ~ data$dateTime, type = "l", ylab = "Voltage (Volt)", xlab="")

with(data, {
  plot(Sub_metering_1 ~ dateTime, type = "l", ylab = "Energy sub metering", xlab="") 
  lines(Sub_metering_2 ~ dateTime, col = "Red") 
  lines(Sub_metering_3 ~ dateTime, col = "Blue")
})
legend("topright", col = c("black", "red", "blue"), lwd = c(1,1,1), c("sub_metering_1", "sub_metering_2", "sub_metering_3"))

plot(data$Global_reactive_power ~ data$dateTime, type = "l", ylab = "Global Reactive Power (kilowatts)", xlab="")

## Save file and close device
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()