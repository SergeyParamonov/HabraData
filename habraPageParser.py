import urllib2
from bs4 import BeautifulSoup
import re
from article import HabraArticle

class HabraPageParser:
  @staticmethod
  def parse(url):
    try:
      response = urllib2.urlopen(url) 
    except urllib2.HTTPError, err:
      if err.code == 404:
        return None
      else:
        raise 
    html = response.read().decode("utf-8")
    soup = BeautifulSoup(html)
   #print(soup.decode('utf-8'))
    #if the post is closed, return None
    cyrillicPostIsClosed = '\xd0\xa5\xd0\xb0\xd0\xb1\xd1\x80\xd0\xb0\xd1\x85\xd0\xb0\xd0\xb1\xd1\x80 \xe2\x80\x94 \xd0\x94\xd0\xbe\xd1\x81\xd1\x82\xd1\x83\xd0\xbf \xd0\xba \xd1\x81\xd1\x82\xd1\x80\xd0\xb0\xd0\xbd\xd0\xb8\xd1\x86\xd0\xb5 \xd0\xbe\xd0\xb3\xd1\x80\xd0\xb0\xd0\xbd\xd0\xb8\xd1\x87\xd0\xb5\xd0\xbd'   
    if soup.title.text == cyrillicPostIsClosed.decode('utf-8'):
      return None  
    articles = soup.find_all(class_="post shortcuts_item")
    habraArticles = []
    for article in articles:
      isScoreShown = article.find(class_="mark positive ")
      #if the score is published already, then article is in, otherwise we go on to next one
      if not isScoreShown:
        continue
      post_id  = article["id"]
      author   = article.find(class_="author")
      if author:
        author = author.a.text
      title    = article.find(class_="post_title").text
      score    = article.find(class_="score"     ).text
      views    = article.find(class_="pageviews" ).text
      favors   = article.find(class_="favs_count").text 
      tutorial = article.find(class_="flag flag_tutorial")
      #we need to escape the symbols in the title, it might contain commas
      title    = re.sub(r',', " comma ", title)
      #if something went wrong skip this article
      if not post_id or not author or not title:
        return None
      habraArticle = HabraArticle(post_id,title,author,score,views,favors,tutorial)
      habraArticles.append(habraArticle)
    return habraArticles
