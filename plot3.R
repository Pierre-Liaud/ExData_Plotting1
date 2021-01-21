#Memory required in MB nrow*ncolumns*8/2^{20} (google, R forums)
2075259*9*8/2^{20}

#Download file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = paste(getwd(),"/Electric power consumption.zip",sep=""))
unzip(paste(getwd(),"/Electric power consumption.zip", sep=""))

#Load data (file.choose is use to avoid pathway conflicts)
data <- read.csv(file.choose(), header=TRUE, sep=";", na.strings="?") 
str(data)

#Data and time conversion to timestamp included in dataset
data$timestamp <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

#Subset
subset <- data[data$timestamp >= "2007-02-01" & data$timestamp < "2007-02-03", ]

#my setup is in French, i changed it to "English" in order to have right labels
Sys.setlocale("LC_ALL", "English")

#Plot 3
png(filename = "plot3.png")
plot(subset$timestamp, subset$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering")
lines(subset$timestamp, subset$Sub_metering_2, col = "red")
lines(subset$timestamp, subset$Sub_metering_3, col = "blue")

legend("topright",lty = 1, col = c("black","red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()