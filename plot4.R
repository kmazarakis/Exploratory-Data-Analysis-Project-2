## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Find Coal Related sources from SCC
SCCcoal <- grepl("coal", SCC$EI.Sector, ignore.case = T)
SCCcoalfinal <- SCC[SCCcoal == "TRUE", ]

##Find NEI Coal related from SCCcolafinal
NEIcoal <- NEI[NEI$SCC %in% SCCcoalfinal$SCC,]

##Aggregate emission sums per year
data4 <- with(NEIcoal, tapply(Emissions, year, sum))

##Plot the graph
barplot(data4, names.arg = names(data4), main = "Total Coal Combustion Related Emissions per Year", xlab = "Years", ylab = "Emissions")
dev.copy(png, "plot4.png")
dev.off()
