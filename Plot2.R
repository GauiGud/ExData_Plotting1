####################################################################
# Set the working directory and read the data
####################################################################
setwd("H:/My Documents/Coursera/04 Exploratory Data Analysis")

data <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";")

# Get a subset with only the two days we want
data2007 <- subset(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")


####################################################################
# Add datetime and weekday to the subset
####################################################################
datetime <- paste(data2007$Date, data2007$Time)
datetime <- strptime(datetime, format = "%d/%m/%Y %H:%M:%S")
names(datetime) <- c("DateTime")

dayofweek <- weekdays(datetime, abbreviate = TRUE)
names(dayofweek) <- c("DayOfWeek")

# Add the dayofweek to the subset
data2007 <- cbind( datetime, dayofweek, data2007 )


####################################################################
# Change factors to numbers
####################################################################
data2007$Global_active_power <- as.numeric(as.character(data2007$Global_active_power))


####################################################################
# Graph 2
####################################################################
png(file="Plot2.png",width=480,height=480) 

plot(data2007$datetime, data2007$Global_active_power, 
         type="n", xlab = "", ylab = "Global Active Power (kilowatts)") 

    lines(data2007$datetime, data2007$Global_active_power, 
          type="l") 

dev.off()
