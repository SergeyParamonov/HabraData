library(e1071) 
topfile <- "all.csv"
data <- read.csv(topfile, stringsAsFactors = FALSE)
#remove duplicates
data <- data[!duplicated(data),]
#NA in favourites, means there is no-one who added it
data[is.na(data$favors),]$favors <- 0
#attach(data)
font <- sapply(data$isTutorial, function(x) if (x) 16 else 1)
colors <- sapply(data$isTutorial, function(x) if (x) "red" else "blue")
#plot(score, favors, col=colors)
tutorial <- data[data$isTutorial == 1,]
normal   <- data[data$isTutorial == 0,]

#plot(tutorial$score, tutorial$favors, ylim=c(0,1500), xlim=c(0,1000))
#plot(normal$score, normal$favors,ylim=c(0,1500), xlim=c(0,1000))
#plot(data$views, data$favors, col=colors)
predictionSet <- data[,c("favors", "score", "isTutorial")]
predictionSet$isTutorial <- as.factor(predictionSet$isTutorial)
 par(mfrow=c(1,2))
#model <- svm(isTutorial ~ ., data=predictionSet, class.weights = c("0"=1,"1"=30), cross=10)
xlabels <- c()
for(i in seq(0,8,2)){
  xlabels <- c(xlabels, eval(substitute(expression(i %*% 10^4), list(i=i))))
}
xlabels <- c(xlabels, eval(substitute(expression(i %*% 10^5), list(i=1))))
for(i in seq(1.2,1.6,0.2)){
  xlabels <- c(xlabels, eval(substitute(expression(i %*% 10^5), list(i=i))))
}

plot(data$score, data$favors, col=colors, xlim=c(0,350), ylim=c(0,1700), xlab="Голоса", ylab="Избранное")
abline(a=0,b=35,col="red")
abline(a=0,b=2.5,col="red")
abline(lm(favors ~ score, data=tutorial))
plot(data$views, data$favors,  col=colors, xlim=c(0,160000), ylim=c(0,1700), xlab="Просмотры",ylab="Избранное", xaxt='n')
axis(1, at = c(0,20000,40000,60000,80000,100000,120000,140000,160000), labels=xlabels)
abline(a=0,b=0.03,col="red")
abline(a=0,b=0.0045,col="red")
abline(lm(favors ~ views, data=tutorial))

mtext("Взаимное распределение избранное vs рейтинг статьи (слева), избранное vs просмотры (справа).\n Красный — tutorial, синий — обычный пост.\n Красные линии — основная область нахождения tutorial. Черная — основной тренд tutorial.", side=3, outer=TRUE, line=-3)

print(paste("normal median fav/score: ", median(normal$favors/normal$score)))
print(paste("tutorial median fav/score: ", median(tutorial$favors/tutorial$score)))

print(paste("normal median fav/views*1000: ", median(normal$favors/normal$views)*1000))
print(paste("tutorial median fav/views*1000: ", median(tutorial$favors/tutorial$views)*1000))
# plot(data$views, data$favors, col=colors, xlim=c(0,50000), ylim=c(0,1000))
#for all time data
#abline(h=1000, col="red")
#abline(b=3, a=-380,col="red")
#plot(model, predictionSet)
#print(summary(model))
#print(predictionSet)
