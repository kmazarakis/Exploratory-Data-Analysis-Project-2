## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Subset NEI
Baltimore <- subset(NEI, fips == "24510")

##Aggregate emission sums per year
data2 <- with(Baltimore, aggregate(Emissions, by = list(year), sum))

##Rename data2 column names
colnames(data2) <- c("Year", "Emissions")

##Plot the graph
barplot(data2$Emissions, names.arg = data2$Year, xlab = "Years", ylab = "Emissions", main = "Total PM2.5 Emissions in Baltimore per Year")
dev.copy(png, "plot2.png")
dev.off()
