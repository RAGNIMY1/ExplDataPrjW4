###################################################################################################################
## EXPLORATORY DATA ANALYSIS - WEEK 4 Project Assignment (PLOT2)   
## 27.08.2019
## Author               : Myriam Ragni
## Dataset & Purpose    : please refer to description in file plot1.R
## Question 2           : Have total emissions from PM2.5 decreased in the Baltimore City, Maryland(fips == "24510")
##                        from 1999 to 2008?
## Output               : This script will produce plot2.png
## How to run the script: Change the working directory accordingly (setwd command). Note: we assume that the data
##                        files have already been downloaded for the creation of Plot1
###################################################################################################################

## ===============================================================================
## Set the environment
## ===============================================================================
#### Set the working directory !!!! TO BE CHANGED ACCORDINGLY
setwd("C:/RAGNIMY1/datasciencecoursera/ExplDataPrjW4")
#### Clear variables in the workspace
rm(list = ls())
#### Change locale settings to ensure that date/time is shown in English format
Sys.setlocale("LC_TIME", "English")
#### Load the needed libraries
library(dplyr)

## =================================================================================
## Read the data files and load them into data frames
## =================================================================================
DataFile1 <- "summarySCC_PM25.rds"
DataFile2 <- "Source_Classification_Code.rds"
File1<- readRDS(file=DataFile1) ##6497651 obs. 6 variables
File2<- readRDS(file=DataFile2) ##11717 obs. 15 variables

## =================================================================================
## Building PLOT2 : plot of points and lines presenting the total emissions from 
##                  PM2.5 in Baltimore City from 1999 to 2008
## Note: the initial dataset has been subsetted to extract the observations from
##       Baltimore using the fips code as filter (fips = 24510)
## Plot is presented on the console and saved to a PNG file with a width of 
## 500 pixels and a height of 500 pixels.
## The plot shows that the PM2.5 emitted in Baltimore City has decreased from 1999 
## to 2002, increased from 2002 to 2005 and significantly decreased from 2005 to 2008
## =================================================================================
BaltimoreEmissions <- File1 %>% 
        filter(fips == "24510") %>%
        group_by(year) %>% 
        summarise(AnnualEmissions = sum(Emissions)/1000)

with(BaltimoreEmissions, plot(year, AnnualEmissions, type="b", xaxt="none",
                                         xlab="Year", ylab=expression("PM"[2.5]*" Emissions in Kilotons "),
                                         ylim=c(0.8*min((AnnualEmissions)),1.1*max(AnnualEmissions)), col=c("purple"), pch=19, lty=2,
                                         main="Total Fine Particulate Emissions in Baltimore City from 1999 to 2008 \n(in Kilotons)"))

text(x=BaltimoreEmissions$year,y=BaltimoreEmissions$AnnualEmissions, label=round(BaltimoreEmissions$AnnualEmissions,digits=2), pos=3, cex=0.8, col="red")
axis(1,BaltimoreEmissions$year)

dev.copy(png,filename="plot2.png", width=500, height=500)
dev.off()
