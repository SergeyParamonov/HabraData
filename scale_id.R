n      <- 250
data   <- read.csv("alive_test_id.csv")
alive  <- data[data$type == "alive",2]
dead   <- setdiff(data$id, alive)

for(line in 0:25){
  lowerid <- line*n+1
  upperid <- (line+1)*n 
  colors <- sapply(data$id[lowerid:upperid], function(x) if (x %in% alive) "red" else "deepskyblue")
  ys     <- rep(2*line + 1, n)
  if(line == 0){
    plot(1:n,ys, col=colors, ylim=c(0,50), pch='|', xaxt='n',yaxt='n', xlab="Последовательные по id посты", ylab="Группа по 250 постов", main="Относительная плотность живых ссылок по id на http://habrahabr.ru/post/<id>\n красный – живая ссылка, синий – мертвая", cex=1.2, cex.lab=1.5)
  }
  else{
    points(1:n,ys, col=colors, pch='|')
  }
}
