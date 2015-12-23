##This program creates plot1.png showing trends of PM2.5 over 1999-2008 time period

##Reading in the data
nei<-readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
scc<-readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

##Acquiring total Emissions across all sources over the 1999-2008 time period
library(dplyr)
totalPM<-summarise(group_by(nei, year), sum(Emissions))

##Summarize gives a data frame, converting it to matrix for barplot
totalPM<-as.matrix(totalPM)

##Opening the png device, making the plot and closing the device
png("plot1.png", width = 480, height = 480, units = "px")
barplot(totalPM[,2], names.arg = totalPM[,1], main = "Trend of totalPM2.5 from 1999-2008", col = "red", xlab = "Year", ylab = "totalPM2.5")
dev.off()