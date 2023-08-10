# citylevel_population
# 目的：在sysdata.rda中增加城市规模，根据城市的人口计算出城市规模。
# 数据：中国城市统计年鉴、中国人口统计年鉴
rm(list = ls())
setwd("C:/Users/amand/Documents/GitHub/regioncode_new")

if (!requireNamespace("dplyr", quietly = TRUE)) {
  install.packages("dplyr")
}
library(dplyr)

if (!requireNamespace("pacman", quietly = TRUE)) {
  install.packages("pacman")
}
library(pacman)
p_load("rio",
       "tidyverse")

# import---------------------------------------------------------------------------

load("R/sysdata.rda")
df_citylevel<- import("data/cityranking.xls")

library(tidyverse)

# 定义函数，根据population生成cityranking变量-----------------------------------------
generate_cityranking <- function(df) {
  year <- unique(df$year)
  year_cityranking <- paste0(year, "_cityranking")
  if (year %in% 1986:2013) {
    df[[year_cityranking]] <- case_when(
      df$population > 100 ~ "特大城市",
      df$population > 50 & df$population <= 100 ~ "大城市",
      df$population > 20 & df$population <= 50 ~ "中等城市",
      df$population <= 20 ~ "小城市",
      TRUE ~ NA_character_
    )
  } else if (year %in% 2014:2019) {
    df[[year_cityranking]] <- case_when(
      df$population > 1000 ~ "超大城市",
      df$population > 500 & df$population <= 1000 ~ "特大城市",
      df$population > 300 & df$population <= 500 ~ "I型大城市",
      df$population > 100 & df$population <= 300 ~ "II型大城市",
      df$population > 50 & df$population <= 100 ~ "中等城市",
      df$population > 20 & df$population <= 50 ~ "I型小城市",
      df$population <= 20 ~ "II型小城市",
      TRUE ~ NA_character_
    )
  }
  df <- select(df, -year, -population,-population_original)
  df
}

# 按年份拆分并生成cityranking变量--------------------------------------------------------
dfs <- map(1986:2019, ~df_citylevel %>%
             filter(year == .x) %>%
             generate_cityranking())

# 合并86-19年的数据集-----------------------------------------------------------------
cityranking<- reduce(dfs, full_join, by = c("city_code", "city_name"))

# 删除city_code为空值的观测-----------------------------------------------------------
cityranking <- cityranking[!is.na(cityranking$city_code), ]

# region_table新建一列city_code-------------------------------------------------------
region_table$city_code <- ifelse(region_table$zhixiashi == "TRUE", region_table$prov_code, region_table$`2019_code`)

#合并---------------------------------------------------------------------------------
region_data <- merge(region_table,cityranking, by = "city_code")
region_data <- select(region_data, -city_code,-city_name)

save(region_data, region_table, corruption,file = "~/R/sysdata.rda")

