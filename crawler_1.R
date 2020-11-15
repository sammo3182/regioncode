#爬取网站#
install.packages("rvest")
library(rvest)
url_NBS <- "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220859.html"
web_NBS <- read_html(url_NBS)

#下载表格#
table <- html_table(web_NBS)

#数据处理#
