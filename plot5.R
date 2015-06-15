#Download data file
url<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
path<-file.path(getwd(),"dpa.zip")
download.file(url,path)
nei<-readRDS( unzip(path, "summarySCC_PM25.rds"))
dim(nei) #6497651       6
scc<-readRDS( unzip(path, "Source_Classification_Code.rds"))
dim(scc) #11717    15

library(ggplot2)

#emissions from motor vehicle sources in Baltimore
road_sub <- nei[nei$fips=="24510" & nei$type=="ON-ROAD",  ]
total_emission <- aggregate(Emissions ~ year, road_sub, sum)

#plot building
png("plot5.png", width=840, height=480)
p <- ggplot(total_emission, aes(factor(year), Emissions))
p <- p + geom_bar(stat="identity",col='blue') +
  xlab("year") + ylab(expression('Total PM Emissions')) +
  ggtitle('Total Emissions from motor vehicle in Baltimore from 1999 to 2008')
print(p)
dev.off()
