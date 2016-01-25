import pandas as pd
#hist = data['karma'].plot(kind='hist', bins=1000)
data  = pd.read_csv(" user_dataset.csv")
karma = data['karma']
def proportion_of_karma(x):
  top_x_karma = karma[karma > karma.quantile(x)].sum()
  all_karma = karma.sum()
  return top_x_karma/all_karma


