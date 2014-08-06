library(sqldf)

## Read in the data file using sql to filter the dates we are interested in
df<-read.csv.sql("../Data/household_power_consumption.txt",
                 sql='select * from file where Date="1/2/2007" OR Date="2/2/2007"'
                 ,sep=";",header=T)
closeAllConnections() ## Close sql connection

## Create DateTime column
var<-paste(df$Date,df$Time)

df$DateTime<-strptime(var, "%d/%m/%Y %H:%M:%S")

## Prepare plot 4
png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))
with(df,{plot(DateTime,Global_active_power,type="l",xlab="",ylab="Global Active Power")
         plot(DateTime,Voltage,type="l",xlab="datetime",ylab="Voltage")
         plot(df$DateTime,df$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
         lines(df$DateTime,df$Sub_metering_1,col="black",lwd=1)
         lines(df$DateTime,df$Sub_metering_2,col="red",lwd=1)
         lines(df$DateTime,df$Sub_metering_3,col="blue",lwd=1.5)
         legend("topright",lty=c(1,1,1),lwd=c(1),col=c("black","red","blue"),
                bty="n",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
         plot(DateTime,Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")})

dev.off()