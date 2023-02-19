fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
zipFile <- "pm25 emissions.zip"

library(ggplot2)

if (!file.exists(zipFile)) {
  download.file(fileUrl, zipFile, mode = "wb")
}
data <- "Data"
if (!file.exists(data)) {
  unzip(zipFile)
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

mv <- grepl("vehicle", SCC$EI.Sector, ignore.case=TRUE)
SCC_mv <- SCC[mv,]
mv_NEI <- merge(NEI, SCC_mv, by="SCC")

baltimore <- subset(mv_NEI, fips=="24510")

balt_mv <- tapply(baltimore$Emissions, baltimore$year, sum)

balt_mv <- as.data.frame(balt_mv)
names(balt_mv)[1] <- "Emissions"
rownames(balt_mv) <- c(1:4)
balt_mv$Year <- c(1999, 2002, 2005, 2008)

png("plot5.png")
ggplot(balt_mv, aes(x=Year, y=Emissions)) +
  geom_line() + geom_point() + xlab("Year") + ylab("Total PM.25 Emissions (tons)") + ggtitle("Total PM2.5 Emissions from Motor Vehicle Sources in Baltimore by Year")



dev.off()