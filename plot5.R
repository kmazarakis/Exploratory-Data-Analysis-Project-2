## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Find Vehicle Related sources from SCC
SCCvehicle <- grepl("vehicle", SCC$EI.Sector, ignore.case = T)
SCCvehiclefinal <- SCC[SCCvehicle, ]

##Find NEI Vehicle related from SCCvehiclefinal
NEIVehicleBaltimore <- NEI[NEI$SCC %in% SCCvehiclefinal$SCC & NEI$fips == "24510", ]

##Aggregate emission sums per year
data5 <- with(NEIVehicleBaltimore, tapply(Emissions, year, sum))

##Plot the graph
barplot(data5, names.arg = names(data5), main = "Total Vehicle Related Emissions per Year in Baltimore", xlab = "Years", ylab = "Emissions")
dev.copy(png, "plot5.png")
dev.off()
