#Webscraping from pubmed

article  = read_html("http://www.ncbi.nlm.nih.gov/pubmed/27637004")
abstract = article %>%
  html_nodes("abstracttext") %>%
  html_text()
authors = article %>%
  html_nodes(".auths") %>%
  html_text()

journal = article %>%
  html_nodes(".cit") %>%
  html_text()

title =  article %>%
  html_nodes("h1") %>%
  html_text()

authors
journal
title

# RSIMed,PubMed.miner are pubmed labs

# paste is like concatenate in other languages,let us try it
# Let us separate characters by new line
Full_abstract = paste(title,journal,authors,abstract,sep = "\n")
Full_abstract
#https://stat.ethz.ch/pipermail/r-help/2008-November/180183.html
# Effect of paste will be seen in print.
# clear console http://stackoverflow.com/questions/14260340/function-to-clear-the-console-in-r
cat("\014")

cat(Full_abstract)
# 

Full_abstract

##library(pubmed.mineR)
#x= 27637004
pmids_to_abstracts()


