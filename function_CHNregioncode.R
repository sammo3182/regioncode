############LOAD############
if (!require(pacman)) install.packages("pacman")
library(pacman)
p_load(
  dplyr
)

#load region data
# region_table <- as_tibble(read.csv('./data/region_data_all.csv', fileEncoding = "GBK"))
load('./data/region_data_all.rda')
#load sample data
sample_code <- read.csv('./data/sample_code.csv') %>% subset(select = -X)

sample_name <- read.csv('./data/sample_name.csv') %>% subset(select = -X)

#####sample_process#####
# sample data
# region_table <- read.csv('./data/region_data_all.csv')
# to_year = 'X2015_code'
# from_year = 'X1988_code'
# region_table <- as_tibble(region_table)
# 
# sampledata <- region_table[,c(to_year,from_year)]
# sampledata <- sampledata[sample(nrow(sampledata),20,replace=FALSE),]
# sampledata['GDP'] <- rnorm(20)
# names(sampledata) <- c("value", "year", "GDP")
# sampledata <- sampledata[, c('year', 'GDP')]
# write.csv(sampledata, './data/sample_code.csv')
# 
# from_year = 'X1988_name'
# to_year = 'X2015_name'
# sample_city_name <- region_table[,c(to_year,from_year)]
# sample_city_name <- sample_city_name[sample(nrow(sample_city_name),20,replace=FALSE),]
# sample_city_name['GDP'] <- rnorm(20)
# names(sample_city_name) <- c("value", "year", "GDP")
# sample_city_name <- sample_city_name[, c('year', 'GDP')]
# write.csv(sample_city_name, './data/sample_name.csv')

#############Function: CHNregioncode############

CHNregioncode <- function(import, year_col, from_year, 
                               to_year = 2015, type){
  if(class(import) != "data.frame") {stop('Import error. Please input class == "data.frame" import')}
  
  if(type != 'code2name' & type != 'code2code' & type != 'code2sname' & type != 'name2name' &  type != 'name2code' & type != 'name2sname' & type != 'sname2name' & type != 'sname2code' & type != 'sname2sname') {stop('Type error.')}
  
  switch (type,
          'code2code' = {
            #如果要转换的类型为城市编码(年份转换)
            from_year <- paste('X', as.character(from_year) , '_code', sep = '')
            to_year <- paste('X', as.character(to_year), '_code', sep = '')
            
            name <- merge(import, region_table[,c(from_year, to_year)], by.x = year_col , by.y = from_year, all.x = TRUE)
            name[year_col] = name[to_year]
            name <- name[,-grep(to_year,colnames(name))] %>% unique()
            rownames(name) <- NULL
            return(name)
          },
          'name2code' = {
            #如果要转换的类型为城市名name
            from_year <- paste('X', as.character(from_year) , '_name', sep = '')
            to_year <- paste('X', as.character(to_year), '_code', sep = '')
            
            name <- merge(import, region_table[,c(from_year, to_year)], by.x = year_col , by.y = from_year, all.x = TRUE)
            name[year_col] = name[to_year]
            name <- name[,-grep(to_year,colnames(name))] %>% unique()
            rownames(name) <- NULL
            return(name)
          },
          'sname2code' = {
            #如果要转换的类型为城市名sname
            from_year <- paste('X', as.character(from_year) , '_sname', sep = '')
            to_year <- paste('X', as.character(to_year), '_code', sep = '')
            
            name <- merge(import, region_table[,c(from_year, to_year)], by.x = year_col , by.y = from_year, all.x = TRUE)
            name[year_col] = name[to_year]
            name <- name[,-grep(to_year,colnames(name))] %>% unique()
            rownames(name) <- NULL
            return(name)
          },
          
          'code2name' = {
            #如果要转换的类型为城市编码
            from_year <- paste('X', as.character(from_year) , '_code', sep = '')
            to_year <- paste('X', as.character(to_year), '_name', sep = '')
            
            name <- merge(import, region_table[,c(from_year, to_year)], by.x = year_col , by.y = from_year, all.x = TRUE)
            name[year_col] = name[to_year]
            name <- name[,-grep(to_year,colnames(name))] %>% unique()
            rownames(name) <- NULL
            return(name)
          },
          'name2name' = {
            #如果要转换的类型为城市名name(年份转换)
            from_year <- paste('X', as.character(from_year) , '_name', sep = '')
            to_year <- paste('X', as.character(to_year), '_name', sep = '')
            
            name <- merge(import, region_table[,c(from_year, to_year)], by.x = year_col , by.y = from_year, all.x = TRUE)
            name[year_col] = name[to_year]
            name <- name[,-grep(to_year,colnames(name))] %>% unique()
            rownames(name) <- NULL
            return(name)
          },
          'sname2name' = {
            #如果要转换的类型为城市名sname
            from_year <- paste('X', as.character(from_year) , '_sname', sep = '')
            to_year <- paste('X', as.character(to_year), '_name', sep = '')
            
            name <- merge(import, region_table[,c(from_year, to_year)], by.x = year_col , by.y = from_year, all.x = TRUE)
            name[year_col] = name[to_year]
            name <- name[,-grep(to_year,colnames(name))] %>% unique()
            rownames(name) <- NULL
            return(name)
          },
          
          'code2sname' = {
            #如果要转换的类型为城市编码
            from_year <- paste('X', as.character(from_year) , '_code', sep = '')
            to_year <- paste('X', as.character(to_year), '_sname', sep = '')
            
            name <- merge(import, region_table[,c(from_year, to_year)], by.x = year_col , by.y = from_year, all.x = TRUE)
            name[year_col] = name[to_year]
            name <- name[,-grep(to_year,colnames(name))] %>% unique()
            rownames(name) <- NULL
            return(name)
          },
          'name2sname' = {
            #如果要转换的类型为城市名name
            from_year <- paste('X', as.character(from_year) , '_name', sep = '')
            to_year <- paste('X', as.character(to_year), '_sname', sep = '')
            
            name <- merge(import, region_table[,c(from_year, to_year)], by.x = year_col , by.y = from_year, all.x = TRUE)
            name[year_col] = name[to_year]
            name <- name[,-grep(to_year,colnames(name))] %>% unique()
            rownames(name) <- NULL
            return(name)
          },
          'sname2sname' = {
            #如果要转换的类型为城市名sname(年份转换)
            from_year <- paste('X', as.character(from_year) , '_sname', sep = '')
            to_year <- paste('X', as.character(to_year), '_sname', sep = '')
            
            name <- merge(import, region_table[,c(from_year, to_year)], by.x = year_col , by.y = from_year, all.x = TRUE)
            name[year_col] = name[to_year]
            name <- name[,-grep(to_year,colnames(name))] %>% unique()
            rownames(name) <- NULL
            return(name)
          },
          
  )
}


############TEST: Function CHNregioncode################
conver_data <- CHNregioncode(import = sample_name, year_col = 'year', from_year = 1988,
                               to_year = 1989, type = "name2name")
sample_name
conver_data

conver_data <- CHNregioncode(import = sample_name, year_col = 'year', 
                         from_year = 1988, to_year = 2014, type = 'name2name' )
sample_name
conver_data

conver_data <- CHNregioncode(import = sample_name, year_col = 'year', 
                               from_year = 1988, to_year = 2015, type = 'love_qiubao' )

