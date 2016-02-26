#plot1.R

if(!file.exists("household_power_consumption.txt")) {
  fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  filedest <- "householddata.zip"
  download.file(fileurl,filedest)
  unzip("householddata.zip") #this puts "household_power_consumption.txt" in the working directory
}

data <- read.table("household_power_consumption.txt",header = TRUE,sep = ";",stringsAsFactors = FALSE)
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")
set <- subset(data,Date == "2007-02-01" | Date == "2007-02-02")
set$Global_active_power <- as.numeric(set$Global_active_power)
png(filename = "plot1.png",width = 480,height = 480)
hist(set$Global_active_power,xlab = "Global Active Power (kilowatts)",col = "red",main = "Global Active Power")
dev.off()