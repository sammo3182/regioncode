if (!requireNamespace("pacman", quietly = TRUE)) {
  install.packages("pacman")
}
library(pacman)
p_load(pinyin)

# import---------------------------------------------------------------------------

load("R/sysdata.rda")

year_from = 1999
year_to = 2015
convert_to = "code"
incomplete_name = FALSE
zhixiashi = FALSE
to_dialect = "none"
to_pinyin = FALSE
province = FALSE

data_input <- c("东城区", "梅州市")
regioncode(data_input, convert_to = "code", year_from = 2019, year_to = 2020)
regioncode(data_input, convert_to = "name", year_from = 2019, year_to = 2020, to_pinyin = TRUE)


data_input <- c("北京市", "天津市")
regioncode(data_input, convert_to = "name", year_from = 2019, year_to = 2020, to_dialect = TRUE, zhixiashi = TRUE)


data_input <- c("河北省", "河南省")
regioncode(data_input, convert_to = "code", year_from = 2019, year_to = 2020, province = TRUE)

data_input <- c("北京", "天津")
regioncode(data_input, convert_to = "code", year_from = 2019, year_to = 2020, province = TRUE, incomplete_name = TRUE)
regioncode(data_input, convert_to = "name", year_from = 2019, year_to = 2020, province = TRUE, incomplete_name = TRUE)


data_input <- c("东城", "梅州")
regioncode(data_input, convert_to = "name", year_from = 2019, year_to = 2020, incomplete_name = TRUE)

