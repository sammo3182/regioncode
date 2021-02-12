load("data/region_data_all.RData")
name_zhixiashi <- c("北京","天津", "上海", "重庆")

region_table <- region_table %>%
  mutate(zhixiashi = prov_name %in% name_zhixiashi)

save(region_table, "data/region_data_all.RData")
