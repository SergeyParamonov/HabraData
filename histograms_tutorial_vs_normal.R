datafile <- "all.csv"
data     <- read.csv(datafile, stringsAsFactors = FALSE)
#NA in favourites, means there is no-one who added it
data[is.na(data$favors),]$favors <- 0
#attach(data)
font <- sapply(data$isTutorial, function(x) if (x) 16 else 1)
colors <- sapply(data$isTutorial, function(x) if (x) "red" else "blue")
#plot(score, favors, col=colors)
tutorial <- data[data$isTutorial == 1,]
normal   <- data[data$isTutorial == 0,]

par(mfrow=c(3,2))
xlabfav <- "Число favourites у поста"
ylab <- "Относительное число постов"

#Рисуем гистограммы избранного
hist(tutorial$favors[tutorial$favors <= 1500], freq=FALSE, breaks=220, main="Гистограмма числа favourites\n среди tutorial", ylim=c(0,0.014), xlab=xlabfav,ylab=ylab, cex.lab=1.2, col="indianred1")
favmedian <- median(tutorial$favors)
abline(v=favmedian,col="black")
axis(1, at=c(favmedian), labels=c(paste(" медиана:", favmedian,sep = "")))

hist(normal$favors[normal$favors <= 1500], freq=FALSE, breaks=220, main="Гистограмма числа favourites\n среди обычных постов", xlab=xlabfav,ylab=ylab, cex.lab=1.2, col="deepskyblue")
favnorm <- median(normal$favors)
abline(v=favnorm,col="black")
axis(1, at=c(favnorm), labels=c(paste("            медиана:",favnorm, sep="")))

#Рисуем гистограммы рейтингов
xlabscore <- "Число плюсов у поста"
hist(tutorial$score[tutorial$score <= 300], freq=FALSE, breaks=220, main="Гистограмма числа плюсов\n среди tutorial", xlab=xlabscore,ylab=ylab, cex.lab=1.2, col="indianred1")
scoremedian <- median(tutorial$score)
abline(v=scoremedian,col="black")
axis(1, at=c(scoremedian), labels=c(paste("   медиана:", scoremedian, sep="")))

hist(normal$score[normal$score <= 300], freq=FALSE, breaks=220, main="Гистограмма числа плюсов\n среди обычных постов", xlab=xlabscore,ylab=ylab, cex.lab=1.2, col="deepskyblue")
normscore <- median(normal$score)
abline(v=normscore,col="black")
axis(1, at=c(normscore), labels=c(paste("медиана:", normscore)))

options(scipen=5)

#Гистограммы просмотров
xlabviews <- "Число просмотров у поста"
hist(tutorial$views[tutorial$views <= 150000], freq=FALSE, breaks=275, main="Гистограмма числа просмотров\n среди tutorial", xlab=xlabviews,ylab=ylab, cex.lab=1.2, col="indianred1")
viewmedian <- median(tutorial$views)
abline(v=viewmedian,col="black")
axis(1, at=c(viewmedian), labels=c(paste("        медиана:",viewmedian)))

hist(normal$views[normal$views <= 150000], freq=FALSE, breaks=275, main="Гистограмма числа просмотров\n среди обычных постов", xlab=xlabviews,ylab=ylab, cex.lab=1.2, col="deepskyblue")
normview <- median(normal$views)
abline(v=normview,col="black")
axis(1, at=c(normview), labels=c(paste("медиана:",normview)))
