#
# Make Plot 3
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
# 6. plot a line chart (i.e. type = "l") with x = DateTime & y = Sub_metering_1,
#    and define the y-axis range catering for 3 sub metering variables
plot(sorted_df$DateTime, sorted_df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering",
     ylim=range(0, sorted_df$Sub_metering_1, sorted_df$Sub_metering_2, sorted_df$Sub_metering_3))
#
# 7. add a red line for the sub metering 2
lines(sorted_df$DateTime, sorted_df$Sub_metering_2, type="l", col="red")
#
# 8. add a blue line for the sub metering 3
lines(sorted_df$DateTime, sorted_df$Sub_metering_3, type="l", col="blue")
#
# 9. create the legend (defining the colors of lines, line tyeps in the legend and character vecotrs)
legend("topright", col=c("black", "red", "blue"), lty=1,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#
# 10. copy the plot to a PNG file
dev.copy(png, filename = "plot3.png", width=660)
dev.off()
