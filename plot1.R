plot1 <- function() {

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
    
    png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "grey")
    hist(DT$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
    dev.off()
    
}
        