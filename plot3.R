

########### LIBRARIES ################################

library(sqldf)
library(lubridate)

########### READ & TRANSFORM DATA ######################

# read only specific dates of interest
power <- read.csv.sql("household_power_consumption.txt", 
                      sql = "select * from file where [Date] like '1/2/2007' or [Date] like '2/2/2007';", 
                      sep=";", header=T, eol="\n")
closeAllConnections()

power$datetime  <- ymd_hms(as.POSIXct(paste(power$Date, power$Time), format = "%d/%m/%Y %H:%M:%S"))


########### SAVE PLOT  ####################################

# PNG file with a width of 480 pixels and a height of 480 pixels.
png(filename = "plot3.png",width = 480, height = 480, units = "px" )

########### CONSTRUCT PLOT  ##############################


## create x y plot canvas with annotation 
with(power, plot(datetime, Sub_metering_1, xaxt='n',type="n",
                 ylab="Energy sub metering", xlab=""))

## create line graphs
with(power, lines(datetime, Sub_metering_1, type="l") )

with(power, lines(datetime, Sub_metering_2, type="l", col="red") )

with(power, lines(datetime, Sub_metering_3, type="l", col="blue") )


## specify x axis ticks and labels
with(power,axis.POSIXct(1, at=c(min(datetime),mean(datetime),max(datetime))
                        , labels=format(c(min(datetime),mean(datetime),max(datetime)), "%a") ))

# add the descriptive legend
legend("topright", lwd=1, lty = c(1,1,1), col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2" ,"Sub_metering_3"),cex=0.8 )


dev.off()
