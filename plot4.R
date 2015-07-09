#
# Make Plot 4
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
# 6. define global graphics parameters
par(mfcol = c(2, 2), mar=c(4, 4, 2, 2))
#
# 7. plot the 1st graph (which is same as plot 2)
plot(sorted_df$DateTime, sorted_df$Global_active_power, type="l", xlab="", ylab="Global Active Power")
#
# 8a. plot the 2nd graph (which is same as plot 3)
plot(sorted_df$DateTime, sorted_df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering",
     ylim=range(0, sorted_df$Sub_metering_1, sorted_df$Sub_metering_2, sorted_df$Sub_metering_3))
#
# 8b. add a red line for the sub metering 2
lines(sorted_df$DateTime, sorted_df$Sub_metering_2, type="l", col="red")
#
# 8c. add the blue line for the sub metering 3
lines(sorted_df$DateTime, sorted_df$Sub_metering_3, type="l", col="blue")
#
# 8d. create the legend
legend("topright", col=c("black", "red", "blue"), bty="n", lty=1, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#
# 9. plot the 3rd graph - a line chart (i.e. type = "l") with x = DateTime & y = Voltage
plot(sorted_df$DateTime, sorted_df$Voltage, type="l", xlab="datetime", ylab="Voltage")
#
# 10. plot the 4th graph - a line chart (i.e. type = "l") with x = DateTime & y = Global_reactive_power
plot(sorted_df$DateTime, sorted_df$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
#
# 11. copy the plot to a PNG file
dev.copy(png, filename = "plot4.png", width=660)
dev.off()
