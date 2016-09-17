
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
png(filename = "plot2.png",width = 480, height = 480, units = "px" )

########### CONSTRUCT PLOT  ##############################

## create x y plot canvas with annotation 
with(power, plot(datetime, Global_active_power, xaxt='n',type="n",
                 ylab="Global Active Power (kilowatts)", xlab=""))

## create line graph
with(power, lines(datetime, Global_active_power, type="l") )

## specify x axis ticks and labels
with(power,axis.POSIXct(1, at=c(min(datetime),mean(datetime),max(datetime))
                        , labels=format(c(min(datetime),mean(datetime),max(datetime)), "%a") ))

# close graphic device
dev.off()