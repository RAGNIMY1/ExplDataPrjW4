###################################################################################################################
## EXPLORATORY DATA ANALYSIS - WEEK 4 Project Assignment (PLOT1)   
## 27.08.2019
## Author  : Myriam Ragni
## Dataset : This assignment uses data provided by the Environmental Protection Agency on emissions of fine 
##           particulate matter (PM2.5) in the United States for each type of PM source by year.
##           URL: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
##               summarySCC_PM25.rds :  data frame with the number of tons of PM2.5 emitted from a specific 
##                                      type of sources for 1999, 2002, 2005, and 2008.
##               Source_Classification_Code.rds: mapping from the SCC digit strings in the emissions table to the 
##                                               actual name of the PM2.5 source.
## Purpose : The overall goal of this assignment is to explore the National Emissions Inventory database and see what
##           it says about fine particulate matter pollution in the United states over the period 1999-2008.
##           Six questions must be addressed; for each of then a single plot will be created. The related code is
##           stored in single files.
## Question 1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
## Output  : This script will produce plot1.png
## How to run the script: Change the working directory accordingly (setwd command)
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
## Download and unzip the raw data file
## =================================================================================
SrcFileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
DataFileZip <- "FNEI_data.zip"
DataFile1 <- "summarySCC_PM25.rds"
DataFile2 <- "Source_Classification_Code.rds"


#### Check if zipped data file was already downloaded, if not, download the file
if (!file.exists(DataFileZip)){
        download.file(SrcFileURL, destfile=DataFileZip)
}

#### Check if unzipped data files exist, if not, unzip the data files
if (!file.exists(DataFile1)){ 
        unzip(DataFileZip) 
        } else {
                if (!file.exists(DataFile2)){ 
                        unzip(DataFileZip)
                        }
        }

## =================================================================================
## Read the data files and load them into data frames
## summarySCC_PM25.rds: contains a data frame with all of the PM2.5 emissions data 
## for 1999, 2002, 2005, and 2008
##    fips: A five-digit number (represented as a string) indicating the U.S. county
##    SCC: The name of the source as indicated by a digit string (see source code 
##         classification table)
##    Pollutant: A string indicating the pollutant (Polluant = PM25-PRI in the file 
##               used for the assignment)
##    Emissions: Amount of PM2.5 emitted, in tons
##    type: The type of source (POINT, NON-POINT, ON-ROAD, or NON-ROAD)
##    year: The year of emissions recorded (1999,2002,2005,2008)
##
## Source_Classification_Code.rds: mapping from the SCC code in the Emissions table 
##                                 to the actual name of the PM2.5 source.
## =================================================================================
File1<- readRDS(file=DataFile1) ##6497651 obs. 6 variables
File2<- readRDS(file=DataFile2) ##11717 obs. 15 variables

## =================================================================================
## Building PLOT1 : barplot presenting the total emissions from PM2.5 in the US from
##                  1999 to 2008
## Plot is presented on the console and saved to a PNG file with a width of 
## 500 pixels and a height of 500 pixels.
## The plot shows that the PM2.5 emitted in the US has decreased from 1999 to 2008.
## =================================================================================
TotalEmissions <- File1 %>% 
        group_by(year) %>% 
        summarise(AnnualEmissions = sum(Emissions)/1000000)

xposbars <- with(TotalEmissions, barplot(height=AnnualEmissions, names.arg=year, 
                       xlab="Year", ylab=expression("PM"[2.5]*" Emissions in Millions of Tons "),
                       ylim=c(0,1.1*max(AnnualEmissions)), col=c("red","orange","yellow","yellowgreen"), 
                       main="Total Fine Particulate Emissions in the United States from 1999 to 2008 \n(in Millions of Tons)"))

text(x= xposbars, y=TotalEmissions$AnnualEmissions, label=round(TotalEmissions$AnnualEmissions,digits=2), col="red", pos=3, cex=0.8)

dev.copy(png,filename="plot1.png", width=580, height=580)
dev.off()
