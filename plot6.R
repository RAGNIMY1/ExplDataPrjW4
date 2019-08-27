###################################################################################################################
## EXPLORATORY DATA ANALYSIS - WEEK 4 Project Assignment (PLOT6)   
## 27.08.2019
## Author               : Myriam Ragni
## Dataset & Purpose    : please refer to description in file plot1.R
## Question 6           : Compare emissions from motor vehicle sources in Baltimore City with emissions from
##                        motor vehicle sources in Los Angeles County, California (fips == "06037"). 
##                        Which city has seen greater changes over time in motor vehicle emissions?
## Output               : This script will produce plot6.png
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
## Building PLOT6 : barplot presenting the total PM 2.5 emissions from motor
##                  vehicle sources in the Baltimore City and Los Angeles County 
##                  from 1999 to 2008
## Note: the initial dataset has been subsetted to extract the observations:
##       - from Baltimore (fips = 24510) AND 
##       - Los Angeles (fips = 06037 ) AND
##       - those related to motor vehicle sources (assuming they are identified as
##         type = ON-ROAD)
## Plot is presented on the console and saved to a PNG file
## The plot shows that, emissions from motor vehicle sources in Baltimore City have
## decreased by ~258tons from 1999 to 2008 whereas they have increased by ~170 tons
## in Los Angeles
## =================================================================================

BaltLAOnRoadEmissions <- File1 %>% 
        filter((fips == "24510" | fips == "06037") & type == "ON-ROAD" ) %>%
        mutate(fips = factor(ifelse(fips == "24510", "Baltimore City, MD", "Los Angeles County, CA"))) %>%
        group_by(fips, year) %>% 
        summarise(AnnualEmissions = sum(Emissions)) 
 
graph <- ggplot(BaltLAOnRoadEmissions,aes(x=factor(year),y=AnnualEmissions, fill=factor(fips)))

graph + facet_grid(.~fips) + scale_fill_manual(values = brewer.pal(name="Set2",n=8)) + 
        geom_bar(aes(fill=factor(year)),stat="identity", width=0.75, show.legend=FALSE) + 
        ggtitle("Total Fine Particulate Emissions from Motor-Vehicle sources \nin Baltimore City and Los Angeles from 1999 to 2008 \n(in Tons)") +
        theme_bw() +
        theme(plot.title = element_text(hjust = 0.5)) +
        labs(x = NULL, y = expression("PM"[2.5]*" Emissions in Tons ")) +
        geom_text(data=BaltLAOnRoadEmissions,aes(x=factor(year),y=BaltLAOnRoadEmissions$AnnualEmissions,label=round(BaltLAOnRoadEmissions$AnnualEmissions,digits=2)),color="blue", vjust=-0.5,size=3,show.legend=FALSE)

dev.copy(png,filename="plot6.png", width=500, height=500)
dev.off()