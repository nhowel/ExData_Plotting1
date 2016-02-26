#plot4.R

if(!file.exists("household_power_consumption.txt")) {
  fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  filedest <- "householddata.zip"
  download.file(fileurl,filedest)
  unzip("householddata.zip") #this puts "household_power_consumption.txt" in the working directory
}

data <- read.table("household_power_consumption.txt",header = TRUE,sep = ";",stringsAsFactors = FALSE)
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")
set <- subset(data,Date == "2007-02-01" | Date == "2007-02-02")
set$Date <- strptime(with(set,paste(Date,Time)),format = "%Y-%m-%d %H:%M:%S")
set$Sub_metering_1 <- as.numeric(set$Sub_metering_1)
set$Sub_metering_2 <- as.numeric(set$Sub_metering_2)
set$Voltage <- as.numeric(set$Voltage)
set$Global_reactive_power <- as.numeric(set$Global_reactive_power)
png("plot4.png",width = 480,height = 480)
par(mfcol = c(2,2))
#upper left
with(set,plot(Date,Global_active_power,type = "n",xlab= "",ylab = "Global Active Power"))
with(set,lines(Date,Global_active_power))
#lower left
with(set,plot(Date,Sub_metering_1,type= "n",xlab = "",ylab = "Energy sub metering"))
with(set,lines(Date,Sub_metering_1,col ="black"))
with(set,lines(Date,Sub_metering_2,col ="red"))
with(set,lines(Date,Sub_metering_3,col ="blue"))
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"),lty = 1)
#upper right
with(set,plot(Date,Voltage,type = "n",xlab = "datetime",ylab = "Voltage"))
with(set,lines(Date,Voltage))
#lower right
with(set,plot(Date,Global_reactive_power,type = "n",xlab = "datetime",ylab = "Global_reactive_power"))
with(set,lines(Date,Global_reactive_power))
dev.off()