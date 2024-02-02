# citylevel2021
# 目的：在sysdata.rda中增加2022城市商业魅力排行榜数据（变量：2022_level）
# 数据：《2022城市商业魅力排行榜》
# 数据来源：第一财经·新一线城市研究所（https://www.datayicai.com/readReport/286）
# preparation
if (!requireNamespace("pacman", quietly = TRUE)) {
  install.packages("pacman")
}
library(pacman)
p_load("rio",
       "tidyverse")

# import---------------------------------------------------------------------------

load("R/sysdata.rda")
df_report <- import("data/report2021.xlsx")


# name-----------------------------------------------------------------------------

df_report$level2021 <- df_report$level2021 %>%
  factor(levels = c("一线",
                    "新一线",
                    "二线",
                    "三线",
                    "四线",
                    "五线"),
         labels = c(1:6)
         )

region_table <- rename(region_table,c("sname2019" = "2019_sname"))
region_table <- rename(region_table,c("code2019" = "2019_code"))
region_table <- rename(region_table,c("name2019" = "2019_name"))

ID <- c(1:1143)
ID <- tibble(ID)
region_table <- cbind(ID,region_table)
# 分类————————————————————————————————————————————————————————————————————————--

## 直辖市及其对应等级
metro <- filter(region_table, zhixiashi ==TRUE)
report_metro <- filter(df_report, region == "北京"|
                         region == "天津"|
                         region == "上海"|
                         region == "重庆")

##其他城市及其对应等级

city <- filter(region_table, zhixiashi == FALSE)
report_city <- filter(df_report, !grepl("北京|天津|上海|重庆", region))

# 赋值————————————————————————————————————————————————————————————————————————--

## 直辖市赋值

names(report_metro) <- c("prov_sname","level2021")

### 一线直辖市（1）

report_metro1 <- filter(report_metro, level2021 == 1)
name_report_metro1 <- paste(report_metro1$prov_sname, collapse = "|")
metro1 <- filter(metro, grepl(name_report_metro1,prov_sname))
metro1$level2021 <- 1

### 新一线直辖市（2）

report_metro2 <- filter(report_metro, level2021 == 2)
name_report_metro2 <- paste(report_metro2$prov_sname, collapse = "|")
metro2 <- filter(metro, grepl(name_report_metro2,prov_sname))
metro2$level2021 <- 2

## 城市赋值

names(report_city) <- c("sname2019","level2021")

### 一线城市(1)

report_city1 <- filter(report_city, level2021 == 1)
name_report_city1 <- paste(report_city1$sname2019, collapse = "|")
city1 <- filter(city, str_detect(city$name2019, name_report_city1) ==TRUE)
city1$level2021 <- 1

### 新一线城市（2）

report_city2 <- filter(report_city, level2021 == 2)
name_report_city2 <- paste(report_city2$sname2019, collapse = "|")
city2 <- filter(city, str_detect(city$name2019, name_report_city2) ==TRUE)
city2$level2021 <- 2

### 二线城市（3）

report_city3 <- filter(report_city, level2021 == 3)
name_report_city3 <- paste(report_city3$sname2019, collapse = "|")
city3 <- filter(city, str_detect(city$name2019, name_report_city3) ==TRUE)
city3$level2021 <- 3

### 三线城市（4）

report_city4 <- filter(report_city, level2021 == 4)
name_report_city4 <- paste(report_city4$sname2019, collapse = "|")
city4 <- filter(city, str_detect(city$name2019, name_report_city4) ==TRUE)
city4$level2021 <- 4

### 四线城市（5）

report_city5 <- filter(report_city, level2021 == 5)
name_report_city5 <- paste(report_city5$sname2019, collapse = "|")
city5 <- filter(city, str_detect(city$name2019, name_report_city5) ==TRUE)
city5$level2021 <- 5

### 五线城市（6）

report_city6 <- filter(report_city, level2021 == 6)
name_report_city6 <- paste(report_city6$sname2019, collapse = "|")
city6 <- filter(city, str_detect(city$name2019, name_report_city6) ==TRUE)
city6$level2021 <- 6

### 未计入城市（7）

result1_6 <- rbind(metro1,metro2,city1,city2,city3,city4,city5,city6)
citylevel2021 <- select(result1_6, ID, level2021)
region_table1_6 <- left_join(region_table,citylevel2021, by = "ID")

region_table1_6$level2021[is.na = TRUE] <- 7


# 整合、输出————————————————————————————————————————————————————————————————————————--

region_table1_6$level2021 <- region_table1_6$level202 %>%
  ordered(levels = c(1:7),
          labels = c("一线",
                     "新一线",
                     "二线",
                     "三线",
                     "四线",
                     "五线",
                     "未计入"))

region_table1_7 <- region_table1_6








