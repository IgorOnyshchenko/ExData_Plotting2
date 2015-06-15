#Download data file
url<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
path<-file.path(getwd(),"dpa.zip")
download.file(url,path)
nei<-readRDS( unzip(path, "summarySCC_PM25.rds"))
dim(nei) #6497651       6
scc<-readRDS( unzip(path, "Source_Classification_Code.rds"))
dim(scc) #11717    15

library(ggplot2)

#emissions from coal combustion-related sources
coal_scc  <- grepl("coal", scc$Short.Name, ignore.case=TRUE)
coal_sub <- scc[coal_scc, ]
neiscc<-nei[nei$SCC %in% coal_sub$SCC,]
total_emission <- aggregate(Emissions ~ year, neiscc, sum)

#building plot
png("plot4.png", width=640, height=480)
p <- ggplot(total_emission, aes(factor(year), Emissions))
p <- p + geom_bar(stat="identity",col='blue') +
  xlab("year") + ylab(expression('Total PM Emissions')) +
  ggtitle('Total Emissions from coal sources from 1999 to 2008')
print(p)
dev.off()
