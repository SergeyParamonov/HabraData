# -*- coding: utf-8 -*-

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import imp
import matplotlib
from matplotlib import rc
matplotlib.style.use('ggplot')
rc('font',**{'family':'serif'})
rc('text', usetex=True)
rc('text.latex',unicode=True)
rc('text.latex',preamble='\\usepackage[utf8]{inputenc}')
rc('text.latex',preamble='\\usepackage[russian]{babel}')

data  = pd.read_csv("user_dataset.csv")
karma    = data['karma']
pubs     = data['publications']
comments = data['comments']
favs     = data['favourites']
followers = data['followers']
rating   = data['rating']

def main():
    pass
    #hist = data['karma'].plot(kind='hist', bins=1000)
    
#   get_overall_distribution(rating, u"рейтинга по количеству пользователей", u"Рейтинг", u"Количество таких пользователей")
#   make_2d_scatter(karma, rating, u"Карма", u"Рейтинг", u"Зависимость рейтинга от кармы")
#   make_2d_scatter(followers, karma, u"Число подписчиков", u"Карма", u"Зависимость кармы от числа подписчиков")
  # make_bar(pubs,"статей", step=0.1)
#   make_bar(followers," последователей ", step=0.1)
#   make_bar(karma," кармы ", step=0.1)
#   make_bar(favs,"избранного")
#   make_bar(comments,"комментариев")
#   get_karma_bar(karma)
#   get_overall_distribution(pubs, u"cтатей по количеству пользователей", u"Количество публикаций", u"Количество таких пользователей")
#   get_overall_distribution(karma, u"кармы по количеству пользователей", u"Карма", u"Количество таких пользователей")
#   get_overall_distribution(comments, u"комментариев по количеству пользователей", u"Комментарии", u"Количество таких пользователей")
#   get_overall_distribution(favs, u"записей избранного по количеству пользователей", u"Избранное", u"Количество таких пользователей")


def make_2d_scatter(x,y,xlabel,ylabel,title):
    fig = plt.figure()
    ax = plt.gca()
    fit = np.polyfit(x,y,1)
    fit_fn = np.poly1d(fit) 
#   plt.plot(x,y,'bo', x, fit_fn(x), '--k')

    plt.scatter(x, y)
    plt.title(title, fontsize=28)
    plt.xlabel(xlabel, fontsize=23)
    plt.ylabel(ylabel, fontsize=23)
#   ax.set_xscale('log')
    plt.xlim((-1,100))
    plt.ylim((-1,150))
    plt.show()
    plt.close()


def proportion_of_karma(karma, x, strict=False):
  if strict:
    top_x_karma = karma[karma > karma.quantile(x)].sum()
  else:
    top_x_karma = karma[karma >= karma.quantile(x)].sum()
  all_karma = karma.sum()
  return top_x_karma/all_karma

def get_fraction_percentile(karma, step, strict):
    for x in np.arange(0,1,step):  
        a = proportion_of_karma(karma,x,strict=strict)
        b = proportion_of_karma(karma,x+step,strict=strict)
        x_fraction = a - b
        yield x_fraction

def get_overall_distribution(x, param, xlabel, ylabel):

    plt.figure()
    N = 250
#   plt.xlim((0,N))
    plt.hist(x, bins=N, log=True)
    plt.title(u"Распределение "+param, fontsize=27)
    plt.tick_params(axis='both', which='major', labelsize=20)
    plt.xlabel(xlabel, fontsize=23)
    plt.ylabel(ylabel, fontsize=23)
#   plt.xticks(per_ids+bar_width/2,('100-90%', '90-80%', '80-70%', '70-60%', '60-50%', '50-40%', '40-30%', '30-20%', '20-10%', '10%'))

#   plt.ylabel("Доля от общей кармы", fontsize=23)
    plt.show()
    plt.close()



def make_bar(data, name, step=0.1, strict=False):
    percentiles = list(get_fraction_percentile(data, step, strict=strict))

    plt.figure()
    bar_width = 0.5
    per_ids   = np.array((range(len(percentiles))))
    plt.bar(per_ids, percentiles, bar_width)
    plt.title("Сколько " + name + " приходится на i-ый перцентиль пользователей?", fontsize=27)
    plt.tick_params(axis='both', which='major', labelsize=20)
    plt.xlabel("Прослойка пользователей от топ X% до топ Y%. Последнее значение top X%", fontsize=23)
    plt.xticks(per_ids+bar_width/2,('100-90\%', '90-80\%', '80-70\%', '70-60\%%', '60-50\%', '50-40\%', '40-30\%', '30-20\%', '20-10\%', '10\%'))

    plt.ylabel("Доля от общей кармы", fontsize=23)
    plt.show()
    plt.close()


if __name__ == "__main__":
    main()
