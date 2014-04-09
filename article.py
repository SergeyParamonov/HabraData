from __future__ import print_function

class HabraArticle:
  def __init__(self,post_id,title,author,score,views,favors,isTutorial):
    self.post_id = post_id 
    self.title   = title
    self.author  = author  
    self.score   = score   
    self.views   = views   
    self.favors  = favors  
    if isTutorial:
      self.isTutorial = 1
    else:
      self.isTutorial = 0
  def printall(self):
    print("id: ",         self.post_id )
    print("title: ",      self.title)
    print("author: ",     self.author  )
    print("score: ",      self.score   )
    print("views: ",      self.views   )
    print("favors: ",     self.favors  )
    print("isTutorial: ", self.isTutorial)
  def get_csv_line(self):
    return self.post_id+","+self.title+","+self.author+","+ self.score+","+self.views+","+self.favors+","+str(self.isTutorial) +"\n"
  
  @staticmethod
  def printCSVHeader():
    return "id, title, author, score, views, favors, isTutorial"

  @staticmethod
  def init_file(filename):
    datafile = open(filename, 'w')
    datafile.close()
    datafile = open(filename, 'a')
    print(HabraArticle.printCSVHeader(), file=datafile)
    return datafile

  def write_to_file(self,datafile):
    csv_line = self.get_csv_line()
    datafile.write(csv_line.encode('utf-8'))
    datafile.flush()
