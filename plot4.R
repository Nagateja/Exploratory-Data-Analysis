##This program creates plot4.png showing trends of PM2.5 over 1999-2008

##Reading in the data
nei<-readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
scc<-readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

##To achieve the dataset for coal sources, the following steps were taken
##1. Convert factor data into character data in scc dataset
##2. Using grep, get indices of the rows containing "coal".
##3. Use the indices to select the data related to coal and the first three columns from the SCC database
##4. Using source, subset NEI database for final coal related data

##I used the "Short.Name" column for the above step. The reason behind this choice
##is - I made a quick comparison of the number of "coal" search results for
##Short.Name, EI.Sector, SCC.Level.Three. Short.Name had the highest number
##of search results (239) when compared to the remaining (180 and 80). So I
##picked the "Short.Name" column. Other columns listed Lignite as a source - 
##which is just another form of coal - because of this, other columns showed
##less number of rows for "coal". "Short.Name" showed most of the data.

scc$Short.Name<-as.character(scc$Short.Name)
coal<-grep("Coal", scc$Short.Name, ignore.case = TRUE)
source<-scc[coal, 1:3]
listcoalsources<-subset(nei, (nei$SCC %in% source$SCC))

##Using summarise on listcoalsources to find the sum of Emissions across all years
library(dplyr)
coalPM<-summarise(group_by(list, year), sum(Emissions))
names(coalPM)<-c("year", "Emissions")

##Opening png device, plotting and closing the device
library(ggplot2)
png("plot4.png", width = 480, height = 480, units = "px")
g<-ggplot(coalPM, aes(year, Emissions)) +
  geom_bar(stat = "identity", fill = "brown") + 
  labs(x = "Year") + labs(y = "Emissions (in tons)") +
  labs(title = "PM2.5 Emission trends from 1999-2008; Source = Coal")

print(g)
dev.off()