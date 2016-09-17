library(rvest)
movie = read_html("http://www.imdb.com/title/tt1431045")
movie %>%
html_nodes(".summary_text") %>%
html_text()

cast <- movie %>%
  html_nodes("#titleCast .itemprop span") %>%
  html_text()

storyline = movie %>%
  html_nodes("p") %>%
  html_text()

storyline = movie %>%
  html_nodes("#titleStoryLine") %>%
  html_text()

paste(storyline,collapse=" ")
storyline1 = movie %>%
  html_nodes("#titleStoryLine h2") %>%
  html_text()

storyline1





