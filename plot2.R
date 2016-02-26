#plot2.R

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
set$Date <- strptime(with(set,paste(Date,Time)),format = "%Y-%m-%d %H:%M:%S")
png("plot2.png",width = 480,height = 480)
with(set,plot(Date,Global_active_power,type = "n",xlab= "",ylab = "Global Active Power (kilowatts)"))
with(set,lines(Date,Global_active_power))
dev.off()


     


