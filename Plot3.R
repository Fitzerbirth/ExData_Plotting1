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

## reshape the dataset for submetering by datetime
data.plot <- data.in[c("datetime", grep("Sub_mete", names(data.in), value = T))]
data.plot <- melt(data.plot, "datetime")
names(data.plot)[2:3] <- c("Label", "Energy_sub_metering")
head(data.plot)

## save the result as png
png("Plot3.png", width = 480, height = 480) ## open png graphics device

## plot all submetering on overlaying fashion
with(data.plot, plot(datetime, Energy_sub_metering, 
                     type = "n", ylab = "Energy sub metering", xlab = ""))
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

dev.off() ## colse png device





