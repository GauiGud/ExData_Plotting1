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

# Change the LocalTime temporarely to English to get "Thu", "Fri" and "Sat"
Sys.setlocale("LC_TIME", "English")
dayofweek <- weekdays(datetime, abbreviate = TRUE)
names(dayofweek) <- c("DayOfWeek")
#Sys.setlocale("LC_TIME","Icelandic_Iceland.1252")

# Add the dayofweek to the subset
data2007 <- cbind( datetime, dayofweek, data2007 )


####################################################################
# Change factors to numbers
####################################################################
data2007$Sub_metering_1 <- as.numeric(as.character(data2007$Sub_metering_1))
data2007$Sub_metering_2 <- as.numeric(as.character(data2007$Sub_metering_2))
data2007$Sub_metering_3 <- as.numeric(as.character(data2007$Sub_metering_3))


####################################################################
# Graph 3
####################################################################
png(file="Plot3.png",width=480,height=480) 

    plot(data2007$datetime, data2007$Sub_metering_1, 
         type="n", xlab = "", ylab = "Energy sub metering") 

    par(col="Black")
    legend(x="topright", 
          legend=c(colnames(data2007[9:11])),
          col=c("black","red","blue"), lwd=1, lty=c(1,1,1))

    par(col="Black")
    lines(data2007$datetime, data2007$Sub_metering_1, type="l") 

    par(col="Red")
    lines(data2007$datetime, data2007$Sub_metering_2, type="l") 

    par(col="Blue")
    lines(data2007$datetime, data2007$Sub_metering_3, type="l") 

dev.off()
