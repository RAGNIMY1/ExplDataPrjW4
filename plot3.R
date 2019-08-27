###################################################################################################################
## EXPLORATORY DATA ANALYSIS - WEEK 4 Project Assignment (PLOT3)   
## 27.08.2019
## Author               : Myriam Ragni
## Dataset & Purpose    : please refer to description in file plot1.R
## Question 3           : Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
##                        variable, which of these four sources have seen decreases in emissions from 1999-2008 for 
##                        Baltimore City? Which have seen increases in emissions from 1999-2008?
## Output               : This script will produce plot3.png
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

## =================================================================================
## Read the data files and load them into data frames
## =================================================================================
DataFile1 <- "summarySCC_PM25.rds"
DataFile2 <- "Source_Classification_Code.rds"
File1<- readRDS(file=DataFile1) ##6497651 obs. 6 variables
File2<- readRDS(file=DataFile2) ##11717 obs. 15 variables

## =================================================================================
## Building PLOT3 : barplot presenting the total PM 2.5 emissions in Baltimore City
##                  by source type from 1999 to 2008
## Note: the initial dataset has been subsetted to extract the observations from
##       Baltimore using the fips code as filter (fips = 24510)
## Plot is presented on the console and saved to a PNG file
## The plot shows that, for 3 types of sources (NON_ROAD,NONPOINT, ON-ROAD), the 
## PM2.5 emitted in Baltimore City has decreased from 1999 to 2008. For POINT sources
## it has sightly increased with a higher peek in 2005.
## =================================================================================
BaltimoreEmissions <- File1 %>% 
        filter(fips == "24510") %>%
        group_by(type,year) %>% 
        summarise(AnnualEmissions = sum(Emissions)/1000)

graph <- ggplot(BaltimoreEmissions,aes(x=factor(year),y=AnnualEmissions,fill=type))
graph + geom_bar(stat="identity") + facet_grid(.~type) + 
        ggtitle("Total Fine Particulate Emissions in Baltimore City by Source Type \nfrom 1999 to 2008 \n(in Kilotons)") +
        theme(plot.title = element_text(hjust = 0.5)) +
        labs(x = NULL, y = expression("PM"[2.5]*" Emissions in Kilotons ")) +
        scale_fill_discrete(name="Emissions Sources") +
        geom_text(data=BaltimoreEmissions,aes(x=factor(year),y=BaltimoreEmissions$AnnualEmissions,label=round(BaltimoreEmissions$AnnualEmissions,digits=2),colour=factor(type)),vjust=-0.5,size=3,show.legend=FALSE)

dev.copy(png,filename="plot3.png", width=800, height=800)
dev.off()

