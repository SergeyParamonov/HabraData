#pdf("mainStatistics.pdf")
datafile <- "all.csv"
data <- read.csv(datafile, stringsAsFactors = FALSE)
#remove duplicates
#NA in favourites, means there is no-one who added it
data[is.na(data$favors),]$favors <- 0
#attach(data)
font <- sapply(data$isTutorial, function(x) if (x) 16 else 1)
colors <- sapply(data$isTutorial, function(x) if (x) "indianred1" else "deepskyblue")
#plot(score, favors, col=colors)
tutorial <- data[data$isTutorial == 1,]
normal   <- data[data$isTutorial == 0,]
#"average" mean median
average_tutorial <- array()
average_tutorial$favors <- median(tutorial$favors)
average_tutorial$views  <- median(tutorial$views )
average_tutorial$score  <- median(tutorial$score )

average_normal <- array()
average_normal$favors <- median(normal$favors)
average_normal$views  <- median(normal$views )
average_normal$score  <- median(normal$score )

average_data <- array()
average_data$favors <- median(data$favors)
average_data$views  <- median(data$views )
average_data$score  <- median(data$score )

par(mfrow=c(1,3))
par(cex=1.15)
barplot(c(average_data$score, average_normal$score, average_tutorial$score), ylim=c(0,25), names.arg=c("Все\nстатьи", "Обычный\nпост", "Tutorial"), main="Медиана количества плюсов", col=c("mediumorchid1","deepskyblue", "indianred1"), ylab="Рейтинг",las=1)

barplot(c(average_data$favors, average_normal$favors, average_tutorial$favors), ylim=c(0,110), names.arg=c("Все\nстатьи", "Обычный\nпост", "Tutorial"), main="Медиана количества favourites", col=c("mediumorchid1","deepskyblue", "indianred1"), ylab="Favourites", las=1)

barplot(c(average_data$views, average_normal$views, average_tutorial$views), ylim=c(0,16000), names.arg=c("Все\nстатьи", "Обычный\nпост", "Tutorial"), main="Медиана количества просмотров", col=c("mediumorchid1","deepskyblue", "indianred1"), ylab="Просмотры",yaxt='n')
axis(2, at = c(0,5000,10000,15000), labels=c("0k", "5k", "10k", "15k"),las=1)

print(average_tutorial)
print(average_normal)

#dev.off()
