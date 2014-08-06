library(sqldf)

## Read in the data file using sql to filter the dates we are interested in
df<-read.csv.sql("../Data/household_power_consumption.txt",
                 sql='select * from file where Date="1/2/2007" OR Date="2/2/2007"'
                 ,sep=";",header=T)
closeAllConnections() ## Close sql connection

## Create DateTime column
var<-paste(df$Date,df$Time)

df$DateTime<-strptime(var, "%d/%m/%Y %H:%M:%S")

## Prepare plot 3
png("plot3.png", width=480, height=480)

colours=c("black","red","blue")

plot(df$DateTime,df$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
lines(df$DateTime,df$Sub_metering_1,col=colours[1],lwd=1)
lines(df$DateTime,df$Sub_metering_2,col=colours[2],lwd=1)
lines(df$DateTime,df$Sub_metering_3,col=colours[3],lwd=1)
legend("topright",lty=c(1,1,1),lwd=c(1),col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()