print_stats <- function(dataset, name){
  n        <- nrow(dataset)
  tutorial <- dataset[dataset$isTutorial == TRUE,]
  print(paste("название: ", name))
  print(paste("для tutorials:",nrow(tutorial)/n))
}

allpost <- read.csv("all.csv")
alltime <- read.csv("dataset_top_all_time.csv")
monthly <- read.csv("habra_dataset_monthly.csv")
weekly  <- read.csv("habra_dataset_weekly.csv")

print_stats(allpost, "Все посты")
print_stats(alltime, "Лучшее за все время")
print_stats(monthly, "Лучшее за месяц")
print_stats(weekly,  "Лучшее за неделю")
