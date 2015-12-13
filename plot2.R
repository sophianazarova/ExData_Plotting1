fileUrl1 = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("./household_power_consumption.zip")) {
  download.file(fileUrl1, destfile = "./household_power_consumption.zip")
}

#read data
e_pow <- read.table(unz("household_power_consumption.zip", "household_power_consumption.txt"),header=T,sep=";")


#Date into Date format
e_pow$Date2 <- as.Date(e_pow$Date,"%d/%m/%Y")

#subseting
e_pow_sub <- subset(e_pow, Date2 == "2007-02-01" | Date2 == "2007-02-02")  

#remove e_pow to save memory
rm(e_pow)

#Time to time format
e_pow_sub$Time2<- strptime(paste(e_pow_sub$Date, e_pow_sub$Time, sep=" "), format = "%d/%m/%Y %H:%M:%S")

e_pow_sub$Global_active_power[e_pow_sub$Global_active_power == "?"] <- NA
e_pow_sub$Global_active_power <- as.numeric(e_pow_sub$Global_active_power)

png("plot2.png")
plot(e_pow_sub$Time2, e_pow_sub$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()


