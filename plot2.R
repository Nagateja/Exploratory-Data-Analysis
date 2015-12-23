##This program creates plot2.png showing trends of PM2.5 over 1999-2008 time period

##Reading in the data
nei<-readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
scc<-readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

##Subsetting for Baltimore data
baltimore<-subset(nei, fips == "24510")

##Acquiring total Emissions across all sources over the 1999-2008 time period
library(dplyr)
baltimorePM<-summarise(group_by(baltimore, year), sum(Emissions))

##Summarize gives a data frame, converting it to matrix for barplot
baltimorePM<-as.matrix(baltimorePM)

##Opening the png device, making the plot and closing the device
png("plot2.png", width = 480, height = 480, units = "px")
barplot(baltimorePM[,2], names.arg = baltimorePM[,1], main = "Trend of totalPM2.5 from 1999-2008 for Baltimore", col = "red", xlab = "Year", ylab = "totalPM2.5")
dev.off()