#plot3.R

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
png("plot3.png",width = 480,height = 480)
with(set,plot(Date,Sub_metering_1,type= "n",xlab = "",ylab = "Energy sub metering"))
with(set,lines(Date,Sub_metering_1,col ="black"))
with(set,lines(Date,Sub_metering_2,col ="red"))
with(set,lines(Date,Sub_metering_3,col ="blue"))
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"),lty = 1)
dev.off()