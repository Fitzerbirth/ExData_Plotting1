

## session start
rm(list = ls())
options(stringsAsFactors = F, digits.secs = 3)

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
png("Plot1.png", width = 480, height = 480) ## open png graphics device
## plot histogram
with(data.in, hist(Global_active_power, col = "red",
                   main = "Global Active Power", 
                   xlab = "Global Active Power (in kilowatts)"))
dev.off() ## colse png device
          