library(sqldf)

df<-read.csv.sql("Data/household_power_consumption.txt",
                 sql='select * from file where Date="1/2/2007" OR Date="2/2/2007"'
                 ,sep=";",header=T)
closeAllConnections() ## Close sql connection

var<-paste(df$Date,df$Time)

df$DateTime<-strptime(var, "%d/%m/%Y %H:%M:%S")

png("plot1.png", width=480, height=480)

hist(df$Global_active_power,main="Global Active Power",col="red",xlab="Global Active Power (kilowatts)")

dev.off()

