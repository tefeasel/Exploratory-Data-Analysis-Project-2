library(dplyr)
library(ggplot2)

setwd("C:\\Users\\tefeasel\\Google Drive\\Coursera\\Data Science\\EDA\\Project2")

data <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                      destfile = "project2.zip")
unzip("project2.zip")

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

#Question 3
nei_by_src <- filter(nei, year %in% c(1999, 2002, 2005, 2008) & fips == "24510")

png("plot3.png")
ggplot(nei_by_src, aes(x = as.factor(year), y = log(Emissions))) +
        facet_grid(. ~  type) +
        geom_boxplot(aes(fill = type)) +
        stat_boxplot(geom = "errorbar") +
        geom_jitter(alpha = .05) +
        labs(x = "Year", y = "PM2.5 Emissions",
             title = "Emissions by Source in Baltimore City, MD")
dev.off()