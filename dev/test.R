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
data_input <- c("北京市", "天津市")
data_input <- c("河北省", "河南省")

regioncode(data_input, zhixiashi = TRUE)
