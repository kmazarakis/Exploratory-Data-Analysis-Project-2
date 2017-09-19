## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Find Vehicle Related sources from SCC
SCCvehicle <- grepl("vehicle", SCC$EI.Sector, ignore.case = T)
SCCvehiclefinal <- SCC[SCCvehicle, ]

##Find NEI Vehicle related from SCCvehiclefinal
NEIVehicleBaltimore <- NEI[NEI$SCC %in% SCCvehiclefinal$SCC & NEI$fips == "24510", ]
NEIVehicleLosAngeles <- NEI[NEI$SCC %in% SCCvehiclefinal$SCC & NEI$fips == "06037", ]

##Aggregate emission sums per year
dataBalt <- with(NEIVehicleBaltimore, tapply(Emissions, year, sum))
dataLA <- with(NEIVehicleLosAngeles, tapply(Emissions, year, sum))

##Plot the graphs
par(mfrow = c(2,1))
barplot(dataBalt, names.arg = names(dataBalt), main = "Total Vehicle Related Emissions per Year in Baltimore", xlab = "Years", ylab = "Emissions")
barplot(dataLA, names.arg = names(dataLA), main = "Total Vehicle Related Emissions per Year in Los Angeles", xlab = "Years", ylab = "Emissions")
dev.copy(png, "plot6.png")
dev.off()
