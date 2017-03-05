library(dplyr)
library(ggplot2)

setwd("C:\\Users\\tefeasel\\Google Drive\\Coursera\\Data Science\\EDA\\Project2")

data <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                      destfile = "project2.zip")
unzip("project2.zip")

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

#Question 2
nei_baltimore <- filter(nei, year %in% c(1999, 2002, 2005, 2008) & fips == "24510") %>%
        group_by(year) %>%
        summarise(total = sum(Emissions))

png("plot2.png")
with(nei_baltimore, plot(year, total, type = "b", 
                         main = "Total PM2.5 Emissions in Baltimore City, MD",
                         xlab = "Year", ylab = "PM2.5 Emissions"))
dev.off()