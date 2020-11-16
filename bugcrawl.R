install.packages("XML")
install.packages("RCurl")
library(XML)
#用于对网页文本XML读取
library(RCurl)
#用于抓取网页文本
url <- c("http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220859.html",
         "http://www.mca.gov.cn/article/sj/xzqh/1980/1980/201911180950.html",
         "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220903.html",
         "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708041017.html",
         "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708041018.html",
         "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708041020.html",
         "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220910.html",
         "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708041023.html",
         "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220911.html",
         "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220913.html",
         "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220914.html",
         "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220916.html",
         "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220918.html",
         "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220921.html",
         "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220923.html",
         "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220925.html",
         "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220927.html",
         "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220928.html",
         "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220930.html",
         "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220935.html",
         "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220936.html",
         "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220939.html",
         "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220941.html",
         "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220943.html",
         "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220946.html",
         "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201707271552.html",#2011、2012年格式可能不同
         "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201707271556.html",
         "http://files2.mca.gov.cn/cws/201404/20140404125738290.htm", #2013年包含所有市和县而且file类型不好打开
         "http://files2.mca.gov.cn/cws/201502/20150225163817214.html",
         "http://www.mca.gov.cn/article/sj/tjbz/a/2015/201706011127.html",
         "http://www.mca.gov.cn/article/sj/xzqh/1980/201705/201705311652.html",
         "http://www.mca.gov.cn/article/sj/xzqh/1980/201803/201803131454.html",
         "http://www.mca.gov.cn/article/sj/xzqh/1980/201903/201903011447.html",
         "http://www.mca.gov.cn/article/sj/xzqh/1980/2019/202002281436.html")
year <- c(1986:2019)#年份对应
crawltable <- data.frame(year,url)#制作成表格供参考抓取
rm(url,year)#删除不必要的数据

doc <- getURL(crawltable$url[])
#用getURL获取对应年份的文本
city <- unlist(strsplit(doc,split = " </tr>"))[-(1:3)]
#进行基础的删除和切割操作，剔除不需要的格式文本解释




#后期文本process存放到code和name中
