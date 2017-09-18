## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Subset NEI fro Baltimore
Baltimore <- subset(NEI, fips == "24510")

##Aggregate emission sums per year and source type
data3 <- with(Baltimore, aggregate(Emissions, by = list(year, type), sum))

##Rename data3 column names
colnames(data3) <- c("Year", "Type", "Emissions")


##Plot the graph
library(ggplot2)
ggplot(data3, aes(as.character(Year), Emissions, fill = Type))+geom_bar(stat = "identity")+xlab("Year")+ylab("Emissions")+facet_grid(.~Type)+ggtitle("Total PM2.5 Emissions in Baltimore by Source Type")
dev.copy(png, "plot3.png")
dev.off()
