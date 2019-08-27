###################################################################################################################
## EXPLORATORY DATA ANALYSIS - WEEK 4 Project Assignment (PLOT5)   
## 27.08.2019
## Author               : Myriam Ragni
## Dataset & Purpose    : please refer to description in file plot1.R
## Question 5           : How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
## Output               : This script will produce plot5.png
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
library(ggplot2)
library(RColorBrewer)

## =================================================================================
## Read the data files and load them into data frames
## =================================================================================
DataFile1 <- "summarySCC_PM25.rds"
DataFile2 <- "Source_Classification_Code.rds"
File1<- readRDS(file=DataFile1) ##6497651 obs. 6 variables
File2<- readRDS(file=DataFile2) ##11717 obs. 15 variables

## =================================================================================
## Building PLOT5 : barplot presenting the total PM 2.5 emissions from motor
##                  vehicle sources in the Baltimore City from 1999 to 2008
## Note: the initial dataset has been subsetted to extract the observations:
##       - from Baltimore using the fips code (fips = 24510) AND
##       - those related to motor vehicle sources (assuming they are identified as
##         type = ON-ROAD)
## Plot is presented on the console and saved to a PNG file
## The plot shows that, emissions from motor vehicle sources in Baltimore City have 
## significantly decreased from 1999 to 2008.
## =================================================================================

BaltOnRoadEmissions <- File1 %>% 
        filter(fips == "24510" & type == "ON-ROAD" ) %>%
        group_by(year) %>% 
        summarise(AnnualEmissions = sum(Emissions))

graph <- ggplot(BaltOnRoadEmissions,aes(x=factor(year),y=AnnualEmissions, fill=factor(year)))

graph + scale_fill_brewer(palette="Blues") + geom_bar(stat="identity", width=0.75, show.legend=FALSE) + 
        ggtitle("Total Fine Particulate Emissions from Motor-Vehicle sources \nin Baltimore City from 1999 to 2008 \n(in Tons)") +
        theme(plot.title = element_text(hjust = 0.5)) +
        labs(x = NULL, y = expression("PM"[2.5]*" Emissions in Tons ")) +
        geom_text(data=BaltOnRoadEmissions,aes(x=factor(year),y=BaltOnRoadEmissions$AnnualEmissions,label=round(BaltOnRoadEmissions$AnnualEmissions,digits=2)),color="blue", vjust=-0.5,size=3,show.legend=FALSE)

dev.copy(png,filename="plot5.png", width=500, height=500)
dev.off()