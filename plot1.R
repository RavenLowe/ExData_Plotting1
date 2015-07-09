#
# Make Plot 1
#
# 1. simply extract the text from its input source and returns each line as a
#    character string for further manipulation later
Lines <- readLines("household_power_consumption.txt")
#
# 2. create a numeric vector indicating the text lines beginning with the dates
#    "1/2/2007" & "2/2/2007"
subL <- grep("^[12]/2/2007", Lines)
#
# 3. load the data with just those dates and add back the variable names
inSub <- read.table(text=Lines[subL], header=FALSE, sep=";",
                    col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#
# 4. create a histogram with Global_active_power variable
hist(inSub$Global_active_power, col="red", xlab="Global Active Power (kilowatts)",
     main="Global Active Power")
#
# 5. copy the plot to a PNG file
dev.copy(png, filename = "plot1.png", width = 480, height = 480, units = "px")
dev.off()
