plot3 <- function() {
    
    if (!file.exists("DataFile")) {
        srcFile="household_power_consumption.txt"
        conn=file(srcFile,open="r")
        linn=readLines(conn)
        write(linn[1], file = "DataFile", append = FALSE)
        
        for (i in 2:length(linn)){
            if (substr(linn[i],1,8) %in% c("1/2/2007","2/2/2007")) {
                write(linn[i], file = "DataFile", append = TRUE)
            }        
        }
        close(conn)
    }
    PowerData <- read.table("DataFile", sep = ";", header = TRUE)
    DT <- data.table(PowerData)
    
    ## png(filename = "plot2.png", width = 480, height = 480, units = "px")
    ## plot(DT$Time, DT$Global_active_power)
    ##  dev.off()
    
    datetime <- strptime(paste(DT$Date, DT$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
    globalActivePower <- as.numeric(DT$Global_active_power)
    subMetering1 <- as.numeric(DT$Sub_metering_1)
    subMetering2 <- as.numeric(DT$Sub_metering_2)
    subMetering3 <- as.numeric(DT$Sub_metering_3)

    
    png("plot3.png", width=480, height=480, bg = "grey")
    plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
    lines(datetime, subMetering2, type="l", col="red")
    lines(datetime, subMetering3, type="l", col="blue")
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
    dev.off()
    
}
