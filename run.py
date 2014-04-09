from __future__ import print_function
import time
from habraArticlesGenerator import HabraPageGenerator 
from habraPageParser        import HabraPageParser
from article                import HabraArticle

if __name__ == "__main__":
  dataset = "all.csv" 
  HabraPageGenerator.generateDataset(dataset)
  reading_test = open(dataset, "r")
  for line in reading_test:
    print(line, end="")
  reading_test.close()
