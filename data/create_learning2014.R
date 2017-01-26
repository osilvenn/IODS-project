# Olli Silvennoinen, 26 January 2017
# This file is for doing the RStudio exercises for week 2 of the IODS course.

# Preliminaries
install.packages("dplyr")
library(dplyr)

# Reading the data file:
data1 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", header = TRUE)

# Structure and dimensions of the data file (183 observations x 60 variables):
str(data1)
dim(data1)

# Creating the analysis dataset:
data1$attitude <- data1$Attitude / 10
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D07","D14","D22","D30")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
deep_columns <- select(data1, one_of(deep_questions))
data1$deep <- rowMeans(deep_columns)
surface_columns <- select(data1, one_of(surface_questions))
data1$surf <- rowMeans(surface_columns)
strategic_columns <- select(data1, one_of(strategic_questions))
data1$stra <- rowMeans(strategic_columns)
data1 <- filter(data1, Points > 0)
colnames(data1)
colnames(data1)[57] <- "age"
colnames(data1)[59] <- "points"
keep_columns <- c("age", "attitude", "points", "gender", "deep", "surf", "stra")
data1 <- select(data1, one_of(keep_columns))

# Working with the dataset in Github
write.csv(data1, file = "learning2014.txt", row.names = FALSE)
learning2014 <- read.csv("/Users/ollisilvennoinen/IODS-project/data/learning2014.txt")
str(learning2014)
head(learning2014)
