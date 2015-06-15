#Download data file
url<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
path<-file.path(getwd(),"dpa.zip")
download.file(url,path)
nei<-readRDS( unzip(path, "summarySCC_PM25.rds"))
dim(nei) #6497651       6
scc<-readRDS( unzip(path, "Source_Classification_Code.rds"))
dim(scc) #11717    15

#Total emission
total_emission <- aggregate(Emissions ~ year, nei, sum)

# Barplot Building
png('plot1.png')
barplot(height=total_emission$Emissions/1000000, names.arg=total_emission$year, xlab="years", ylab=expression('total Emission'),main=expression('Total PM Emissions (in mln) at various years'),col="blue")
dev.off()
