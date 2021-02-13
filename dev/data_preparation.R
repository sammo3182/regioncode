Sys.setlocale(category = "LC_COLLATE", locale = "Chinese")
Sys.setlocale(category = "LC_CTYPE", locale = "Chinese")

library(dplyr)
set.seed(313)

# Toy data for illustration

load("dev/corruption_data.rda")

toy <- vignette_data %>%
  group_by(province) %>%
  slice_sample(n = 2)

usethis::use_data(toy, overwrite = TRUE)

# Adding zhixiashi options

load("data/region_data_all.RData")
name_zhixiashi <- c("北京","天津", "上海", "重庆")

region_table <- region_table %>%
  mutate(zhixiashi = prov_name %in% name_zhixiashi)

usethis::use_data(region_table, overwrite = TRUE)
