Sys.setlocale(category = "LC_COLLATE", locale = "Chinese")
Sys.setlocale(category = "LC_CTYPE", locale = "Chinese")

library(dplyr)
set.seed(313)

# Toy data for illustration

load("dev/corruption_data.rda")

name_official <- c("壮族自治.*$|回族自治.*$|满族自治.*$|维吾尔族自治.*$|苗族自治.*$|彝族自治.*$|土家族自治.*$|藏族自治.*$|蒙古族自治.*$|侗族自治.*$|布依族自治.*$|瑶族自治.*$|白族自治.*$|朝鲜族自治.*$|哈尼族自治.*$|黎族自治.*$|哈萨克族自治.*$|傣族自治.*$|畲族自治.*$|傈僳族自治.*$|东乡族自治.*$|仡佬族自治.*$|拉祜族自治.*$|佤族自治.*$|水族自治.*$|纳西族自治.*$|羌族自治.*$| 土族自治.*$|仫佬族自治.*$| 锡伯族自治.*$| 柯尔克孜族自治.*$|景颇族自治.*$|达斡尔族自治.*$|撒拉族自治.*$|布朗族自治.*$|毛南族自治.*$|塔吉克族自治.*$|普米族自治.*$|阿昌族自治.*$|怒族自治.*$|鄂温克族自治.*$|京族自治.*$|基诺族自治.*$|德昂族自治.*$|保安族自治.*$|俄罗斯族自治.*$|裕固族自治.*$|乌孜别克族自治.*$|门巴族自治.*$|鄂伦春族自治.*$|独龙族自治.*$|赫哲族自治.*$|高山族自治.*$|珞巴族自治.*$|塔塔尔族自治.*$|市|区|州|县")

corruption <- vignette_data %>%
  group_by(province) %>%
  slice_sample(n = 2) %>%
  ungroup() %>%
  mutate(prefecture_sname = gsub(name_official, "", prefecture, perl = TRUE))

usethis::use_data(corruption, overwrite = TRUE)

# Adding zhixiashi options

load("data/region_table.rda")
code_zhixiashi <- c("110000", "120000", "310000", "400000")

region_table <- region_table %>%
  mutate(zhixiashi = prov_code %in% code_zhixiashi)

usethis::use_data(region_table, overwrite = TRUE)


# Building the vignette

devtools::install(build_vignettes = TRUE)
