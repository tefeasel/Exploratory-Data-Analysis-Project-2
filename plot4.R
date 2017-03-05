library(dplyr)
library(ggplot2)

setwd("C:\\Users\\tefeasel\\Google Drive\\Coursera\\Data Science\\EDA\\Project2")

data <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                      destfile = "project2.zip")
unzip("project2.zip")

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

#Question 4
coal <- scc[grepl("coal", scc$Short.Name, ignore.case = TRUE),]
codes <- unique(coal$SCC)

nei_coal <- filter(nei, year %in% c(1999, 2002, 2005, 2008) & SCC %in% codes) %>%
        group_by(year) %>%
        summarise(total = sum(Emissions))

png("plot4.png")
ggplot(nei_coal, aes(x = year, y = total)) +
        geom_line() +
        labs(x = "Year", y = "PM2.5 Emissions",
             title = "Total PM2.5 Emissions from All Coal Combustion Sources")
dev.off()