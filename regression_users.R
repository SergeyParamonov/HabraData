library("MASS")
data <- read.csv("users.csv", header=T, stringsAsFactors=F)
names(data) <- c("user","rating","karma","topic_score","comment_score")

fit <- lm(data=data, rating ~ karma + topic_score + comment_score - 1)
print("regular regression")
print(summary(fit))
fit <- rlm(data=data, rating ~ karma + topic_score + comment_score - 1)
print("robust regression")
print(summary(fit))
attach(data)
data$dif <- abs(rating - karma/10 - topic_score*0.8 - comment_score/100)
print(data[data$dif > 2, ])




