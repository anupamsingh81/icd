# Binaca geetmala scrape
# http://www.hindigeetmala.net/binaca_geetmala_1958.htm
library(rvest)


songlist = read_html("http://www.hindigeetmala.net/binaca_geetmala_1958.htm") # i made an error initially dont push empty strings

# html_text is different from html_table
# https://www.r-bloggers.com/using-rvest-to-scrape-an-html-table/

# on inspecting elements we see two table element .w185 and .w105
# on inspecting element i found w760

Text1 = songlist %>%
  html_nodes(".w185") %>% html_text()  # Put a comma between elements

Text2 = songlist %>%
  html_nodes(".w105") %>% html_text()


xpath ='//*[@id="c1"]/table[2]/tbody/tr/td[4]/table[4]/tbody/tr/td[2]/table[1]/tbody/tr/td/table[4]'
Tablenu = songlist %>%
  html_nodes("w760 fwb") %>% html_table()

Tablepref = songlist %>%
  html_nodes("table.b1.w760.pad2.allef") %>% html_table()




# Removing a column
#http://stackoverflow.com/questions/4605206/drop-data-frame-columns-by-name
#within(df, rm(x, y))
# DT[, c('a','b') := NULL]
# drop.cols <- c('Sepal.Length', 'Sepal.Width')
# iris %>% select(-one_of(drop.cols))
# dropping row
# myData <- myData[-c(2, 4, 6), ]
# Renaming headers
# colnames(DF) = DF[1, ]



str(Tablepref)
Tablepref[1]

Tablepref[2]
Table11 = as.data.frame(Tablepref[1])
Table12 = as.data.frame(Tablepref[2])

Tablepref[3]

# Merge data frames having same column how ?
# http://www.statmethods.net/management/merging.html
# here we bind by rows
total <- rbind(Table11,Table12) 

Tableheader = songlist %>%
  html_nodes("table.w760.fwb") %>% html_table()

Header = as.data.frame(Tableheader[1])

# Removing a column
#http://stackoverflow.com/questions/4605206/drop-data-frame-columns-by-name
#within(df, rm(x, y))
# DT[, c('a','b') := NULL]
# drop.cols <- c('Sepal.Length', 'Sepal.Width')
# iris %>% select(-one_of(drop.cols))
# dropping row
# myData <- myData[-c(2, 4, 6), ]
# Renaming headers
# colnames(DF) = DF[1, ]




Header = subset(Header,select =-c(X1,X9))

colnames(total) = Header[1,]

total$`Song Heading`

# our goal is to do a regex and remove last column 4.28 - 186 votes
# Here we can remove all characters after first number appears
# http://stackoverflow.com/questions/7185071/removing-certain-string-pattern-in-r
# https://www.r-bloggers.com/regular-expressions-in-r-vs-rstudio/


H = sapply(strsplit(total$`Song Heading`,"/d",fixed = TRUE),"[[",1)
H = gsub("votes","",H)
H =  gsub ("-","",H)

H = gsub("\\d", "", H) # gsub('[[:digit:]]+', '', x) , gsub('[0-9]+', '', x)

H
# Extract first four characters
# http://stat545.com/block022_regular-expression.html
# http://gastonsanchez.com/Handling_and_Processing_Strings_in_R.pdf
library(stringr)
G = word(H,1,5) # Extract from 1 to 5, read sanchez guide very good
# using youtube API
# https://www.analyticsvidhya.com/blog/2014/09/mining-youtube-python-social-media-analysis/
library(devtools)
devtools::install_github("soodoku/tuber", build_vignettes = TRUE)
apikey = c("AIzaSyCppcUGi2VqhT8hVMkAgaw10KXXmGj6k64")
appid = c("binacayoutube-147314")
clientid = c("1087391996437-lbu9k1hokr4qk9c8c0pqhrk7ktanlepo.apps.googleusercontent.com")
secret = c("Ye31S_-mMiCOiRHnj0dNihZd")
yt_oauth("1087391996437-lbu9k1hokr4qk9c8c0pqhrk7ktanlepo.apps.googleusercontent.com", "Ye31S_-mMiCOiRHnj0dNihZd")
G
a = yt_search(term="Obama", max_results = 2)
# url=“https://www.googleapis.com/youtube/v3/videos?q=ukrainian+protests&alt=json”


#https://www.googleapis.com/youtube/v3/search?part=id&q=ukraine&type=video&key=AIzaSyCppcUGi2VqhT8hVMkAgaw10KXXmGj6k64
# GET https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=10&order=date&type=video&key={AIzaSyCppcUGi2VqhT8hVMkAgaw10KXXmGj6k64}

# source code of function
# http://stackoverflow.com/questions/19226816/how-can-i-view-the-source-code-for-a-function

library(tuber)
getMethod(tuber::get_stats)
get_comments
tuber_GET
#Rcurl method
library(RCurl)
#query to get video id
curlPerform(url="https://www.googleapis.com/youtube/v3/search?part=id&q=ukraine&maxResults=1&type=video&key=AIzaSyCppcUGi2VqhT8hVMkAgaw10KXXmGj6k64")
# return stats from video id
curlPerform(url="https://www.googleapis.com/youtube/v3/videos?part=statistics&id=cvorg5tCmlQ&key=AIzaSyCppcUGi2VqhT8hVMkAgaw10KXXmGj6k64")# Earlier i missed a query after part?
# or from json like this
a = curlPerform(url="https://www.googleapis.com/youtube/v3/search?part=id&q=ukraine&maxResults=1&type=video&key=AIzaSyCppcUGi2VqhT8hVMkAgaw10KXXmGj6k64")
library(jsonlite)
b = fromJSON("https://www.googleapis.com/youtube/v3/search?part=id&q=ukraine&maxResults=1&type=video&key=AIzaSyCppcUGi2VqhT8hVMkAgaw10KXXmGj6k64")
b$items
C = b$items$id
D = C$videoId

target = paste0("https://www.googleapis.com/youtube/v3/videos?part=statistics&id=",D,"&key=AIzaSyCppcUGi2VqhT8hVMkAgaw10KXXmGj6k64")
target
rd <- readLines(target, warn="F") 
fromJSON(target)
fromJSON(rd)



get_stats(video_id = D)

get_stats(video_id = "cvorg5tCmlQ" )
# https://cran.r-project.org/web/packages/httr/vignettes/api-packages.html




