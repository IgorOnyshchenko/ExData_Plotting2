#Download data file
url<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
path<-file.path(getwd(),"dpa.zip")
download.file(url,path)
nei<-readRDS( unzip(path, "summarySCC_PM25.rds"))
dim(nei) #6497651       6
scc<-readRDS( unzip(path, "Source_Classification_Code.rds"))
dim(scc) #11717    15

library(ggplot2)

#emissions from motor vehicle sources in Baltimore or Los Angeles County
nei_balt_los <- nei[(nei$fips=="24510"|nei$fips=="06037") & nei$type=="ON-ROAD",  ]

total_emission <- aggregate(Emissions ~ year + fips, nei_balt_los, sum)
total_emission$fips[total_emission$fips=="24510"] <- "Baltimore"
total_emission$fips[total_emission$fips=="06037"] <- "Los Angeles"

#plot building
png("plot6.png", width=1040, height=480)
p <- ggplot(total_emission, aes(factor(year), Emissions))
p <- p + facet_grid(. ~ fips)
p <- p + geom_bar(stat="identity",col='blue')  +
  xlab("year") + ylab(expression('Total PM Emissions')) +
  ggtitle('Total Emissions from motor vehicle in Baltimore vs Los Angeles 1999-2008')
print(p)
dev.off()


