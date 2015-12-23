##This program creates plot5.png showing trends of PM2.5 over 1999-2008

##Reading in the data
nei<-readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
scc<-readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

##Since the requirement of the assignment is to plot changes of "motor vehicles",
##any kind of vehicles (heavy duty, light duty, motor cycles etc) are considered
##to be a "motor vehicle". Due to this, the dataset I have considered for this
##part of the assignment is by subsetting type "Onroad" from NEI dataset.

##Subsetting data for motor vehicles and then for Baltimore city.
mov<-subset(nei, type == "ON-ROAD")
baltimore<-subset(mov, fips == "24510")

##Summarising PM data per year
library(dplyr)
baltimoremovPM<-summarise(group_by(baltimore, year), sum(Emissions))
names(baltimoremovPM)<-c("year", "Emissions")

##Opening the png device, plotting, printing and closing the device.
library(ggplot2)
png("plot5.png", width = 480, height = 480, units = "px")
g<-ggplot(baltimoremovPM, aes(year, Emissions))+
  geom_bar(stat = "identity", fill = "brown")+
  labs(x = "Year", y = "Emissions of PM[2.5]")+
  labs(title = "PM[2.5] Emissions trends for Baltimore city Motor Vehicles \n Year: 1999-2008")

print(g)
dev.off()
