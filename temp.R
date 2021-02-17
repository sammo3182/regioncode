library(readxl)
temp <- read_excel('./data/missing/temp.xlsx')
save(temp, file = './data/missing/temp.csv')


library(readxl)
temp <- read_excel('./data/missing/temp.xlsx')
save(temp, file = './data/missing/temp1.csv')
write.csv(temp,file = './data/missing/full.csv')

unique(temp$prov_name)

region_table <- read.csv('./data/missing/full.csv')

unique(full$prov_name)


save(full,file = './data/missing/region_data_all.rds')
test <- readRDS('region_data_all.rds')

save(region_table, file = "./data/region_table.rda")

unique(region_table$prov_name)
