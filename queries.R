data   <- read.csv("all.csv")
query1 <- subset(data, favors > 1000 & score < 50 & isTutorial == FALSE)
print(query1)

query2 <- subset(data, favors > 10*score & score > 25)
print(head(query2,10))
