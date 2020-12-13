library(rvest)
library(tidyverse)
library(stringr)

#下载表格#
url_1987 <- "http://www.mca.gov.cn/article/sj/xzqh/1980/1980/201911180950.html"
web_1987 <- read_html(url_1987)
table_1987 <- html_table(web_1987)

#数据处理#
table_1987_1 <- table_1987[[1]][-c(1,2,3), -c(1,4,5,6,7,8,9)] 
head(table_1987_1)
prov <- str_sub(table_1987_1[,1], 1, 2) #选取前两位省代号
prov_coun <- str_sub(table_1987_1[,1], 3, 4) #选取中间两位以区分省直辖县
city <- str_sub(table_1987_1[,1], 5, 6) #选取最后两位以区分地级市
table_1987_2 <- data.frame(table_1987_1, prov, prov_coun, city)

#河北省1987年数据#
hebei_1987_1 <- 
  subset(
          table_1987_2, 
          table_1987_2[,3]==13 & (table_1987_2[,5]=="00" | table_1987_2[,4]=="90")
        )
hebei_1987 <- hebei_1987_1[,-c(3,4,5)]

#辽宁省1987年数据#
liaoning_1987_1 <- 
  subset(
          table_1987_2, 
          table_1987_2[,3]==21 & (table_1987_2[,5]=="00" | table_1987_2[,4]=="90")
        )
liaoning_1987 <- liaoning_1987_1[,-c(3,4,5)]

#吉林省1987年数据#
jilin_1987_1 <- 
  subset(
          table_1987_2, 
          table_1987_2[,3]==22 & (table_1987_2[,5]=="00" | table_1987_2[,4]=="90")
        )
jilin_1987 <- jilin_1987_1[,-c(3,4,5)]

#黑龙江省1987年数据#
heilongjiang_1987_1 <- 
  subset(
          table_1987_2,   
          table_1987_2[,3]==23 & (table_1987_2[,5]=="00" | table_1987_2[,4]=="90")
        )
heilongjiang_1987 <- heilongjiang_1987_1[,-c(3,4,5)]
