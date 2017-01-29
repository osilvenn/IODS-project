# This is the code for exercise 2 of the IODS course

# Part 1
learning2014 <- read.table("/Users/ollisilvennoinen/IODS-project/data/learning2014.txt", sep = ",", header = TRUE)
str(learning2014)
dim(learning2014)

# Part 2
install.packages("ggplot2")
library(ggplot2)
install.packages("GGally")
library(GGally)
pairs(learning2014[-4], col = learning2014$gender)
p <- ggpairs(learning2014, mapping = aes(col = gender), lower = list(combo = wrap("facethist", bins = 20)))
p
learning2014$gender
model1 <- lm(points ~ gender + attitude + stra, data = learning2014)
summary(model1)
model2 <- lm(points ~ attitude, data = learning2014)
model2

par(mfrow = c(2,2))
plot(model2, which = c(1, 2, 5))
