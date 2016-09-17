
########### LIBRARIES ################################

library(sqldf)
library(lubridate)

########### READ & TRANSFORM DATA ######################

# read only specific dates of interest
power <- read.csv.sql("household_power_consumption.txt", 
                      sql = "select * from file where [Date] like '1/2/2007' or [Date] like '2/2/2007';", 
                      sep=";", header=T, eol="\n")
closeAllConnections()

power$date  <- ymd(as.POSIXct(power$Date, format = "%d/%m/%Y"))

########### SAVE PLOT  ####################################

# PNG file with a width of 480 pixels and a height of 480 pixels.
png(filename = "plot1.png",width = 480, height = 480, units = "px" )

########### CONSTRUCT PLOT  ##############################

with(power, hist(Global_active_power,col="red", ylim=c(0, 1200),  yaxt='n',
                 main="Global Active Power",xlab="Global Active Power (kilowatts)", ylab="Frequency"))
## specify y axis ticks and labels 
axis(2, at=seq.int(from=0,to=1200,by=200), las=2)

# close graphic device
dev.off()

