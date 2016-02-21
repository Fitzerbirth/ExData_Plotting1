## session start
rm(list = ls())
options(stringsAsFactors = F, digits.secs = 3)

## load packages
library(reshape2)

## load data
data.in <- read.delim("data/household_power_consumption.txt", 
                      sep = ";",  # semi-colen seperated file
                      na = "?",  # missing are coded as "?"
                      check.names = F) # preserves dataset names as it is

## displays dimension and names of the data
head(data.in)
names(data.in)
dim(data.in)

## convert string to date

data.in$datetime <- paste(data.in$Date, data.in$Time)
data.in$datetime <- as.POSIXct(strptime(data.in$datetime,
                                         format = "%d/%m/%Y %H:%M:%OS"))
summary(data.in$datetime)

## subset
data.in <- data.in[data.in$datetime >= "2007-02-01 00:00:00" & 
                     data.in$datetime <= "2007-02-02 23:59:59", ]


table((data.in$Date))


## save the result as png
png("Plot4.png", width = 480, height = 480) ## open png graphics device

par(mfrow = c(2,2))
## plot 1
with(data.in, plot(datetime, Global_active_power, type = "l", xlab = ""))
## plot 2
with(data.in, plot(datetime, Voltage, type = "l"))

## plot 3
with(data.plot, plot(datetime, Energy_sub_metering, type = "n", xlab = ""))
## populate points for submetering 1
with(subset(data.plot, Label == "Sub_metering_1"), 
     points(datetime, Energy_sub_metering, type = "l", col = "black"))
## populate points for submetering 2
with(subset(data.plot, Label == "Sub_metering_2"), 
     points(datetime, Energy_sub_metering, type = "l", col = "red"))
## populate points for submetering 3
with(subset(data.plot, Label == "Sub_metering_3"), 
     points(datetime, Energy_sub_metering, type = "l", col = "blue"))
## legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1, 1, 1), col = c("black", "red", "blue"))


## plot 4
with(data.in, plot(datetime, Global_reactive_power, type = "l"))

dev.off() ## colse png device
