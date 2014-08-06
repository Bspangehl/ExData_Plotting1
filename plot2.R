library(sqldf)

## Read in the data file using sql to filter the dates we are interested in
df<-read.csv.sql("../Data/household_power_consumption.txt",
                 sql='select * from file where Date="1/2/2007" OR Date="2/2/2007"'
                 ,sep=";",header=T)
closeAllConnections() ## Close sql connection

## Create DateTime column
var<-paste(df$Date,df$Time)

df$DateTime<-strptime(var, "%d/%m/%Y %H:%M:%S")

## Prepare plot 2
png("plot2.png", width=480, height=480)

plot(df$DateTime,df$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")

dev.off()
