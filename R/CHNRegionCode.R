############LOAD############
if (!require(pacman)) install.packages("pacman")
library(pacman)
p_load(
  tidyverse,
  magrittr
)

region_table <- read_rds("./R/data/region_data_all.rds")

#############Function: CHNRegionCode############
#' Title
#'
#' @param import A character vector
#' @param year_col A character vector
#' @param from_year A character vector
#' @param to_year A character vector
#' @param type A character vector
#'
#' @import tidyverse
#' @import magrittr
#' @export
#'
#' @examples
CHNRegionCode <- function(import, year_col, from_year,
                               to_year = 2015, type){
  if(class(import) != "data.frame") {stop('Import error. Please input class == "data.frame" import')}

  if(type != 'code2name' & type != 'code2code' & type != 'code2sname' & type != 'name2name' &  type != 'name2code' & type != 'name2sname' & type != 'sname2name' & type != 'sname2code' & type != 'sname2sname') {stop('Type error.')}

  switch (type,
          'code2code' = {
            #如果要转换的类型为城市编码
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
            #如果要转换的类型为城市名name
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
            #如果要转换的类型为城市名sname
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

