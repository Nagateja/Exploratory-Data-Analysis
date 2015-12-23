##This program creates plot6.png showing trends of PM2.5 over 1999-2008

##Reading in the data
nei<-readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
scc<-readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

##Since the requirement of the assignment is to plot changes of "motor vehicles",
##any kind of vehicles (heavy duty, light duty, motor cycles etc) are considered
##to be a "motor vehicle". Due to this, the dataset I have considered for this
##part of the assignment is by subsetting type "Onroad" from NEI dataset.

##Subsetting data for motor vehicles and then for Baltimore and LA cities.
mov<-subset(nei, type == "ON-ROAD")
bla<-subset(mov, fips %in% c("24510", "06037"))

##Summarising data based on fips and year
library(dplyr)
movcity<-summarise(group_by(bla, fips, year), sum(Emissions))
names(movcity)<-c("fips", "year", "Emissions")

##Creating "citydata" dataframe. Once created, I can use this dataframe and
##merge movcity and citydata to add Baltimore City and Los Angeles City across
##respective fips. Making it easier for final plots - so I don't have to use legend.
citydata<-data.frame(c("06037", "24510"), c("Los Angeles City", "Baltimore City"))
names(citydata)<-c("fips", "city")
movcity<-merge(movcity, citydata, by="fips", all.x=TRUE)

##Opening png device, plotting and closing the device
library(ggplot2)
png("plot6.png", width = 480, height = 480, units = "px")
g<-ggplot(movcity, aes(year, Emissions)) +
  geom_bar(stat = "identity", aes(fill = city)) +
  facet_grid(scales = "free", space = "free", .~city) + guides(fill = FALSE)+
  labs(x = "Year", y = "Emissions of PM[2.5]")+
  labs(title = "Baltimore Vs. Los Angeles PM[2.5] Emissions; \nSource: Motor Vehicles; 1999-2008")

print(g)
dev.off()