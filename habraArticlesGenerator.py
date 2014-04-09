from __future__ import print_function
import time
from habraPageParser import HabraPageParser 
from article import HabraArticle

class HabraPageGenerator:

  @staticmethod
  def generatePages(rooturl):
    articles = []
    suffix = "page"
    for i in range(1,101):
      if i > 1:
        url = rooturl+suffix+str(i)
      else:
        url = rooturl
      print(url)
      pageArticles = HabraPageParser.parse(url)
      if pageArticles is not None:
        articles = articles + pageArticles
      else:
        break
    return articles

  @staticmethod
  def generateTops():
    WEEK_URL    = 'http://habrahabr.ru/posts/top/weekly/'
    MONTH_URL   = 'http://habrahabr.ru/posts/top/monthly/' 
    ALLTIME_URL = 'http://habrahabr.ru/posts/top/alltime/'
    articles = []
    articles = articles + HabraPageGenerator.generatePages(ALLTIME_URL)
    articles = articles + HabraPageGenerator.generatePages(MONTH_URL)
    articles = articles + HabraPageGenerator.generatePages(WEEK_URL)
    return articles

  @staticmethod
  def generateDataset(dataset_name):
    FIRST_TUTORIAL = 152563
    LAST_INDEX     = 219000
    BASE_URL       = 'http://habrahabr.ru/post/'
    logname  = "log-test-alive.txt"
    logfile  = open(logname, "w")
    datafile = HabraArticle.init_file(dataset_name)
    print("generate all pages", file=logfile)
    print(time.strftime("%H:%M:%S"), file=logfile)
    logfile.flush()
    for postIndex in range(FIRST_TUTORIAL, LAST_INDEX):
      url = BASE_URL + str(postIndex)
      print("test: "+url, file=logfile)
      try:
        article = HabraPageParser.parse(url)
        if article:
          print("alive: "+url, file=logfile)
          assert(len(article) == 1)
          article[0].write_to_file(datafile)
      except:
        continue
      logfile.flush()
    logfile.close()
    datafile.close()

  
