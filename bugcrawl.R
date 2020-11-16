install.packages("XML")
install.packages("RCurl")
library(XML)
#用于对网页文本XML读取
library(RCurl)
#用于抓取网页文本
url1986 <- "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220859.html"
url1987 <- "http://www.mca.gov.cn/article/sj/xzqh/1980/1980/201911180950.html"
url1988 <- "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220903.html"
url1989 <- "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708041017.html"
url1990 <- "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708041018.html"
url1991 <- "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708041020.html"
url1992 <- "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220910.html"
url1993 <- "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708041023.html"
url1994 <- "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220911.html"
url1995 <- "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220913.html"
url1996 <- "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220914.html"
url1997 <- "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220916.html"
url1998 <- "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220918.html"
url1999 <- "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220921.html"
url2000 <- "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220923.html"
url2001 <- "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220925.html"
url2002 <- "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220927.html"
url2003 <- "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220928.html"
url2004 <- "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220930.html"
url2005 <- "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220935.html"
url2006 <- "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220936.html"
url2007 <- "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220939.html"
url2008 <- "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220941.html"
url2009 <- "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220943.html"
url2010 <- "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220946.html"
url2011 <- "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201707271552.html"#2011、2012年格式可能不同
url2012 <- "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201707271556.html"
url2013 <- "http://files2.mca.gov.cn/cws/201404/20140404125738290.htm" #2013年包含所有市和县而且file类型不好打开
url2014 <- "http://files2.mca.gov.cn/cws/201502/20150225163817214.html"
url2015 <- "http://www.mca.gov.cn/article/sj/tjbz/a/2015/201706011127.html"
url2016 <- "http://www.mca.gov.cn/article/sj/xzqh/1980/201705/201705311652.html"
url2017 <- "http://www.mca.gov.cn/article/sj/xzqh/1980/201803/201803131454.html"
url2018 <- "http://www.mca.gov.cn/article/sj/xzqh/1980/201903/201903011447.html"
url2019 <- "http://www.mca.gov.cn/article/sj/xzqh/1980/2019/202002281436.html"
#这里可以修改为字符串数组方便获取url

doc <- getURL(url)
#用getURL获取对应年份的文本
city <- unlist(strsplit(doc,split = " </tr>"))[-(1:2)]
#进行基础的删除和切割操作，剔除不需要的格式文本解释
#后期文本process存放到code和name中