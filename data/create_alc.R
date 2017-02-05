# Author: Olli Silvennoinen
# Date: 4 Feb 2017
# This is the code for the data wrangling exercise for week 3 of the course Introduction to Open Data Science. The dataset concerns student alcohol consumption and is acquired from UCI Machine Learning Repository.

# Reading the files into R
mat <- read.table("/Users/ollisilvennoinen/IODS-project/data/student-mat.csv", sep = ";", header = TRUE)
por <- read.table("/Users/ollisilvennoinen/IODS-project/data/student-por.csv", sep = ";", header = TRUE)

# Exploring the structure of the files
str(mat)
dim(mat)
str(por)
dim(por)

# Joining the two datasets but only those students that are included in both
library(dplyr)
join_by <- c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery", "internet")
mat_por <- inner_join(mat, por, by = join_by, suffix = c(".mat", ".por"))

# Exploring the structure of the new dataset
glimpse(mat_por)
dim(mat_por)

# Combining the duplicated answers (this part depends heavily on the code provided in DataCamp)
alc <- select(mat_por, one_of(join_by))
notjoined_columns <- colnames(mat)[!colnames(mat) %in% join_by]
for(column_name in notjoined_columns) {
  two_columns <- select(mat_por, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]
  if(is.numeric(first_column)) {
    alc[column_name] <- round(rowMeans(two_columns))
  } else { 
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# Averaging weekday and weekend alcohol consumption
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_use > 2)

# Having a glimpse of the resulting dataset
glimpse(alc)
dim(alc)

# Creating a file based on the dataset and saving it in the 'data' folder
write.csv(alc, "/Users/ollisilvennoinen/IODS-project/data/alc.csv")
