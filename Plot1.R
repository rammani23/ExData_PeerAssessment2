
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


Emissions <- tapply(NEI$Emissions, NEI$year, sum)


png("plot1.png")
barplot(Emissions/1000000, xlab="Year", ylab="PM2.5 Emissions (millions of tons)", main="Total PM2.5 Emissions in US by Year", ylim=c(0,8))

dev.off()
