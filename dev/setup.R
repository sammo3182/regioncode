# Sys.setlocale(category = "LC_COLLATE", locale = "Chinese")
# Sys.setlocale(category = "LC_CTYPE", locale = "Chinese")

load("R/sysdata.rda")
library(dplyr)

year_from = 1999
year_to = 2015
province = FALSE
zhixiashi = FALSE
incomplete_name = FALSE
to_dialect = "none"
to_pinyin = FALSE

province = TRUE
data_input <- c("黑龙江省", "天津市")
convert_to <- "area"

regioncode(c("沈阳", "吉林市", "河东"), incomplete_name = TRUE, zhixiashi = FALSE)

region_table$prov_scode <- str_sub(region_table$prov_code, end = 2)

provName <- read.csv("provinceName.csv") %>%
  rename(`1998_nickname` = X1998p_nickname,
         `1999_nickname` = X1999p_nickname)

region_table <- left_join(region_table, provName)

region_table <- relocate(region_table, prov_code, prov_scode, prov_sname, prov_name,  `1998_nickname`, `1999_nickname`)

save(region_table, file = "R/sysdata.rda")


data_input <- c("湖南省", "天津市", "内蒙古自治区")
data_input <- regioncode(data_input = data_input, province = TRUE, year_to = 1998, method = "name2abbre")

regioncode(data_input = data_input, province = TRUE, method = "name2code", incompleteName = "from")

ifelse(province,
       select(prov_table, !!ls_index),
       select(region_table, !!ls_index)) %>%
  class()

temp <-     select(region_table, !!ls_index)
