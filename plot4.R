###################################################################################################################
## EXPLORATORY DATA ANALYSIS - WEEK 4 Project Assignment (PLOT4)   
## 27.08.2019
## Author               : Myriam Ragni
## Dataset & Purpose    : please refer to description in file plot1.R
## Question 4           : Across the United States, how have emissions from coal combustion-related sources changed 
##                        from 1999-2008?
## Output               : This script will produce plot4.png
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
## Building PLOT4 : barplot presenting the total PM 2.5 emissions from coal 
##                  combustion-related sources in the United States
##                  from 1999 to 2008
## Note: the initial dataset has been subsetted to extract the observations 
## containing the key words:
##  - "comb" (not case-sensitive) in the EI.Sector variable (Sector/Industry using 
##    combustion) AND
##  - "coal" (not case-sensitive) in the SCC.Level.Three variable to filter emissions
##    from coal
## Plot is presented on the console and saved to a PNG file
## The plot shows that, emissions from coal combustion-related sources have decreased
## from 1999 to 2008 in the United States.
## =================================================================================

#### Returns a vector comb with TRUE/FALSE if EI.Sector contains/does not contain "Comb"
comb <- grepl("Comb",File2$EI.Sector, ignore.case=TRUE) ##530obs. TRUE
#### Returns a vector coal with TRUE/FALSE if File2$SCC.Level.Three contains/does not contain "Coal"
coal <- grepl("Coal",File2$SCC.Level.Three, ignore.case=TRUE) ##181obs. TRUE
#### Returns all SCCs for which EI.Sector contains "Comb" and SCC.Level.Three contains "Coal"
subsetSCC <- File2[comb & coal,"SCC"] ##80 SCC
#### Extracts only the observations from coal combustion-related sources from the initial PM2.5 emissions data set
subsetFile1 <- File1[File1$SCC %in% subsetSCC,] ##40347obs. 6 variables

TotalEmissions <- subsetFile1 %>% 
        group_by(year) %>% 
        summarise(AnnualEmissions = sum(Emissions)/1000)

graph <- ggplot(TotalEmissions,aes(x=factor(year),y=AnnualEmissions, fill=factor(year)))

graph + scale_fill_brewer(palette="Greens") + geom_bar(stat="identity", width=0.75, show.legend=FALSE) + 
        ggtitle("Total Fine Particulate Emissions from Coal Combustion-related sources \nin the United States from 1999 to 2008 \n(in Kilotons)") +
        theme(plot.title = element_text(hjust = 0.5)) +
        labs(x = NULL, y = expression("PM"[2.5]*" Emissions in Kilotons ")) +
        geom_text(data=TotalEmissions,aes(x=factor(year),y=TotalEmissions$AnnualEmissions,label=round(TotalEmissions$AnnualEmissions,digits=2)),color="blue", vjust=-0.5,size=3,show.legend=FALSE)

dev.copy(png,filename="plot4.png", width=500, height=500)
dev.off()

