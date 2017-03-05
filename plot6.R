library(dplyr)
library(ggplot2)

setwd("C:\\Users\\tefeasel\\Google Drive\\Coursera\\Data Science\\EDA\\Project2")

data <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                      destfile = "project2.zip")
unzip("project2.zip")

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

#Question 6
nei_la_baltimore <- filter(nei, year %in% c(1999, 2002, 2005, 2008) & 
                                   fips %in% c("24510", "06037") &
                                   type == "ON-ROAD") %>%
        mutate(location = ifelse(fips == "24510", "Baltimore City", "Los Angeles County"))

png("plot6.png")
ggplot(nei_la_baltimore, aes(x = as.factor(year), y = log(Emissions))) +
        facet_grid(. ~  location) +
        geom_boxplot(aes(fill = location)) +
        stat_boxplot(geom = "errorbar") +
        geom_jitter(alpha = .05) +
        labs(x = "Year", y = "PM2.5 Emissions",
             title = "Motor Vehicle Emissions in Los Angeles County, CA vs.
             Baltimore City, MD")
dev.off()