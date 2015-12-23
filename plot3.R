##This program creates plot3.png showing trends of PM2.5 over 1999-2008 time period

##Reading in the data
nei<-readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
scc<-readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

##Subsetting for Baltimore data
baltimore<-subset(nei, fips == "24510")

##Acquiring total Emissions across all sources over the 1999-2008 time period
library(dplyr)
baltimorePM<-summarise(group_by(baltimore, year, type), sum(Emissions))

##Renaming column names of baltimorePM
names(baltimorePM)<-c("year", "type", "Emissions")

##Opening graphics device, plotting and closing the device
png("plot3.png", width = 480, height = 480, units = "px")
library(ggplot2)
plot<-qplot(year, Emissions, data = baltimorePM) + geom_line(aes(color = type), size = 1) + labs(title = "Baltimore Type Trend from 1999-2008") + labs(x = "Year")
print(plot)
dev.off()