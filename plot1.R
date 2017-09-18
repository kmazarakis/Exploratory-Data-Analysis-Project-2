## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Aggregate emission sums per year
data1 <- with(NEI, aggregate(Emissions, by = list(year), sum))

##Rename data1 column names
colnames(data1) <- c("Year", "Emissions")

##Plot the graph
barplot(data1$Emissions, names.arg = data1$Year, xlab = "Years", ylab = "Emissions", main = "Total PM2.5 Emissions per Year")
dev.copy(png, "plot1.png")
dev.off()
