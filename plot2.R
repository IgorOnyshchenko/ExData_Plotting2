#Download data file
url<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
path<-file.path(getwd(),"dpa.zip")
download.file(url,path)
nei<-readRDS( unzip(path, "summarySCC_PM25.rds"))
dim(nei) #6497651       6
scc<-readRDS( unzip(path, "Source_Classification_Code.rds"))
dim(scc) #11717    15

# Subsetting emission  in the Baltimore City, Maryland
nei_balt  <- nei[nei$fips=="24510", ]
total_emission <- aggregate(Emissions ~ year, nei_balt, sum)

#barplot building
png('plot2.png')
barplot(height=total_emission$Emissions, names.arg=total_emission$year, xlab="years", ylab=expression('total PM emission'),main=expression('Total PM in Baltimore, MD emissions at various years'),col="blue")
dev.off()
