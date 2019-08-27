# ExplDataPrjW4
Exploratory Data Project Assignment Week 4
## Introduction

Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that it is harmful to human health. In the United States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for fine PM and for tracking the emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its database on emissions of PM2.5. This database is known as the National Emissions Inventory (NEI).
For each year and for each type of PM source, the NEI records how many tons of PM2.5 were emitted from that source over the course of the entire year. 

# Data

The data used for this assignment are for 1999, 2002, 2005, and 2008 and can be downloaded from the site: 
<a href="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"></a>. 

The zip file contains two files:

PM2.5 Emissions Data (`summarySCC_PM25.rds`):  A data frame with the number of tons of PM2.5 emitted from a specific type of sourcea for 1999, 2002, 2005, and 2008. Extract of the file: 
````
##    fips      SCC Pollutant Emissions  type year
##4  09001 10100401  PM25-PRI    15.714 POINT 1999
##8  09001 10100404  PM25-PRI   234.178 POINT 1999
##12 09001 10100501  PM25-PRI     0.128 POINT 1999
##16 09001 10200401  PM25-PRI     2.036 POINT 1999
##20 09001 10200504  PM25-PRI     0.388 POINT 1999
##24 09001 10200602  PM25-PRI     1.490 POINT 1999
````

* `fips`: A five-digit number (represented as a string) indicating the U.S. county
* `SCC`: The name of the source as indicated by a digit string (see source code classification table)
* `Pollutant`: A string indicating the pollutant
* `Emissions`: Amount of PM2.5 emitted, in tons
* `type`: The type of source (point, non-point, on-road, or non-road)
* `year`: The year of emissions recorded

Source Classification Code Table (`Source_Classification_Code.rds`): This table provides a mapping from the SCC digit strings int he Emissions table to the actual name of the PM2.5 source. The sources are categorized in a few different ways from more general to more specific and you may choose to explore whatever categories you think are most useful. For example, source “10100101” is known as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.

# Assignment

The overall goal of this assignment is to explore the National Emissions Inventory database and see what it says about fine particulate matter pollution in the United states over the period 1999-2008. Any R package can be used for the analysis.
The following questions and tasks must be addressed in the exploratory analysis. For each question/task a single plot must be created. Unless specified, any plotting system in R to make your plot.

### Question 1
Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
Output: plot1.png
Outcome: The plot shows that the PM2.5 emitted in the United States has decreased from 1999 to 2008.

### Question 2
Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips=="24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.
Output: plot2.png
Outcome: The plot shows that the PM2.5 emitted in Baltimore City has decreased from 1999 to 2002, increased from 2002 to 2005 and significantly decreased from 2005 to 2008.

### Question 3
Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
Output: plot3.png
Outcome: The plot shows that, for 3 types of sources (NON_ROAD,NONPOINT, ON-ROAD), the PM2.5 emitted in Baltimore City has decreased from 1999 to 2008. For POINT sources it has sightly increased with a higher peek in 2005.

### Question 4
Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
Output: plot4.png
Outcome: The plot shows that, emissions from coal combustion-related sources have decreased from 1999 to 2008 in the United States.

### Question 5
How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
Output: plot5.png
Outcome: The plot shows that emissions from motor vehicle sources in Baltimore City have significantly decreased from 1999 to 2008.

### Question 6
Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips=="06037"). Which city has seen greater changes over time in motor vehicle emissions?
Output: plot6.png
Outcome: The plot shows that, emissions from motor vehicle sources in Baltimore City have decreased by ~258tons from 1999 to 2008 whereas they have increased by ~170 tons in Los Angeles. LA has the most changes over time. 

**Notes**: 
* The code to download and unzip the raw data file is only included in the first script (plot1.R). In the other scripts we assume that the files are already stored in the working directory.
* To execute the script, the working directory has to be changed accordingly (setwd command)


