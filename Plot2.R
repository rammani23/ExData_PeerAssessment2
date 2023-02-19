
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
zipFile <- "pm25 emissions.zip"


if (!file.exists(zipFile)) {
  download.file(fileUrl, zipFile, mode = "wb")
}
data <- "Data"
if (!file.exists(data)) {
  unzip(zipFile)
}


NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


baltimore <- subset(NEI, fips=="24510")


balt_emissions <- tapply(baltimore$Emissions, baltimore$year, sum)


png("plot2.png")
barplot(balt_emissions, xlab="Year", ylab="PM2.5 Emissions (tons)", main="Total PM2.5 Emissions in Baltimore by Year", ylim=c(0, 3500))

dev.off()
