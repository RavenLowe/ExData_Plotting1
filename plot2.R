#
# Make Plot 2
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
# 4. combine date and time into a single variable, DateTime
inSub$DateTime <- as.POSIXct(paste(inSub$Date, inSub$Time), format="%d/%m/%Y %H:%M:%S")
#
# 5. sort by DateTime in ascending order
sorted_df <- inSub[order(inSub$DateTime), ]
#
# 6. plot a line chart (i.e. type = "l") with x = DateTime & y = Global_active_power
plot(sorted_df$DateTime, sorted_df$Global_active_power, type="l", xlab="",
     ylab="Global Active Power (kilowatts)")
#
# 7. copy the plot to a PNG file
dev.copy(png, filename = "plot2.png", width = 480, height = 480, units = "px")
dev.off()

