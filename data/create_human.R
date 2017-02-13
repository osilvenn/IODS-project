# Reading the files into R
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Structure and dimensions of 'hd': 195 observations, 8 variables
str(hd)
dim(hd)

# Structure and dimensions of 'gii': 195 observations, 10 variables
str(gii)
dim(gii)

# Summaries of both datasets
summary(hd)
summary(gii)

# Renaming the column names in 'hd'
colnames(hd)
colnames(hd)[3] <- "HDI"
colnames(hd)[4] <- "Life.Expectancy"
colnames(hd)[5] <- "Education.Expected"
colnames(hd)[6] <- "Education.Mean"
colnames(hd)[7] <- "GNI"
colnames(hd)[8] <- "GNI.Minus.HDI.Rank"

# Renaming the column names in 'gii'
colnames(gii)
colnames(gii)[3] <- "GII"
colnames(gii)[4] <- "Maternal.Mortality"
colnames(gii)[6] <- "Parliamentary.Representation"
colnames(gii)[7] <- "Secondary.Education.F"
colnames(gii)[8] <- "Secondary.Education.M"
colnames(gii)[9] <- "Labour.Force.F"
colnames(gii)[10] <- "Labour.Force.M"

# Mutating the 'gii' data
library(dplyr)
library(ggplot2)
gii <- mutate(gii, Secondary.Education.Ratio = Secondary.Education.F / Secondary.Education.M)
gii <- mutate(gii, Labour.Force.Ratio = Labour.Force.F / Labour.Force.M)

# Joining the two datasets
human <- inner_join(hd, gii, by = "Country")

# Creating a new file
write.csv(human, file = "/Users/ollisilvennoinen/IODS-project/data/human.csv")
