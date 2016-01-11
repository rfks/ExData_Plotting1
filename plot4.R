if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

#Unzip DataSet to /data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")

filesPath <- getwd()

#read in the file
df2 <- read.table(file.path(filesPath,"data","household_power_consumption.txt"),header=T,sep = ";",colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),na.strings = c("NA","?"))

#filter for days we are interested in
df3 <- df2[df2$Date=='1/2/2007'|df2$Date=='2/2/2007',]

#combine date and time into new column
df3$DateTime=strptime(paste(df3$Date,df3$Time),"%d/%m/%Y %H:%M:%S")

#4th plot to png
png("plot4.png",width=480,height = 480)
par(mfcol=c(2,2))
#1st subplot
plot(df3$DateTime,df3$Global_active_power,type = "l",xlab = "",ylab = "Global Active Power (kilowatts)")
#2nd subplot
plot(df3$DateTime,df3$Sub_metering_1,type = "n",xlab = "",ylab = "Energy sub metering")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"),pch="-",bty="n")
points(df3$DateTime,df3$Sub_metering_1,type = "l",col="black")
points(df3$DateTime,df3$Sub_metering_2,type = "l",col="red")
points(df3$DateTime,df3$Sub_metering_3,type = "l",col="blue")
#3rd subplot
plot(df3$DateTime,df3$Voltage,type = "l",xlab = "datetime",ylab = "Voltage")
#4th subplot
plot(df3$DateTime,df3$Global_reactive_power,type = "l",xlab = "datetime",ylab = "Global_reactive_power")
dev.off()

