#Download data file
url<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
path<-file.path(getwd(),"dpa.zip")
download.file(url,path)
nei<-readRDS( unzip(path, "summarySCC_PM25.rds"))
dim(nei) #6497651       6
scc<-readRDS( unzip(path, "Source_Classification_Code.rds"))
dim(scc) #11717    15

library(ggplot2)

# Subsetting emission  in the Baltimore City, Maryland
nei_balt  <- nei[nei$fips=="24510", ]
total_emission <- aggregate(Emissions ~ year + type, nei_balt, sum)


png("plot3.png", width=640, height=480)
p <- ggplot(total_emission, aes(year, Emissions, color = type))
p <- p + geom_line() +
  xlab("year") + ylab(expression('Total Emissions')) +
  ggtitle('Total Emissions in Baltimore from 1999 to 2008')
print(p)
dev.off()
