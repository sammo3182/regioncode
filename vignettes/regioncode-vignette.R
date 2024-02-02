## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(message = FALSE, warning = FALSE)

if(!require(regioncode)) install.packages("regioncode")
library(regioncode)
library(tidyverse)

## ----code2code----------------------------------------------------------------
library(regioncode)

data("corruption")

# Conversion to the 1989 version
regioncode(data_input = corruption$prefecture_id, 
           convert_to = "code", # default setting
           year_from = 2019,
           year_to = 1989)

# Comparison
tibble(
  code2019 = corruption$prefecture_id,
  code1989 = regioncode(data_input = corruption$prefecture_id,
           convert_to = "code", # default setting
           year_from = 2019,
           year_to = 1989),
  name2019 = regioncode(data_input = corruption$prefecture_id,
           convert_to = "name", # default setting
           year_from = 2019,
           year_to = 2019),
  name1989 = regioncode(data_input = corruption$prefecture_id,
           convert_to = "name", # default setting
           year_from = 2019,
           year_to = 1989)
)

## ----code2name----------------------------------------------------------------
# Original name
tibble(
  id = corruption$prefecture_id,
  name = corruption$prefecture
)

# Codes to name
regioncode(data_input = corruption$prefecture_id, 
           convert_to = "name",
           year_from = 2019,
           year_to = 1989)

# Name to codes of the same year
regioncode(data_input = corruption$prefecture, 
           convert_to = "code",
           year_from = 2019,
           year_to = 2019)

# Name to name of a different year
regioncode(data_input = corruption$prefecture, 
           convert_to = "name",
           year_from = 2019,
           year_to = 1989)

## ----incomplete_name----------------------------------------------------------
# Original full names
corruption$prefecture

# Conversion to incomplete names in 1989
fake_incomplete <- regioncode(data_input = corruption$prefecture, 
           convert_to = "name",
           year_from = 2019,
           year_to = 1989,
           incomplete_name = "to")
fake_incomplete

# Conversion to full names in 2008
fake_full <- regioncode(data_input = fake_incomplete, 
           convert_to = "name",
           year_from = 1989,
           year_to = 2008,
           incomplete_name = "from")
fake_full

## ----municipality-------------------------------------------------------------
names_municipality <- c("北京市", # Beijing, a municipality
                        "海淀区", # A district of Beijing
                        "上海市", # Shanghai, a municipality
                        "静安区", # A district of Shanghai
                        "济南市") # A prefecture of Shandong

# When `zhixiashi` is FALSE, only the districts are recognized
regioncode(data_input = names_municipality, 
           year_from = 2019,
           year_to = 2019, 
           convert_to = "code",
           zhixiashi = FALSE)

# When `zhixiashi` is TRUE, municipalities are recognized
regioncode(data_input = names_municipality,
           year_from = 2019,
           year_to = 2019,
           convert_to = "code",
           zhixiashi = TRUE)

## ----rank---------------------------------------------------------------------
tibble(
  city = corruption$prefecture,
  rank1989 = regioncode(data_input = corruption$prefecture, 
           year_from = 2019,
           year_to = 1989, 
           convert_to="rank"),
  rank2014 = regioncode(data_input = corruption$prefecture, 
           year_from = 2019,
           year_to = 2014, 
           convert_to = "rank")
)

## ----pinyin-------------------------------------------------------------------
tibble(
  city = corruption$prefecture,
  cityPY = regioncode(data_input = corruption$prefecture, 
           year_from = 2019,
           year_to = 1989, 
           convert_to = "name",
           to_pinyin = TRUE
           ),
  cityIncomplete = regioncode(data_input = corruption$prefecture, 
           year_from = 2019,
           year_to = 1989, 
           convert_to = "name",
           incomplete_name = "to",
           to_pinyin = TRUE
           ),
  areaPY = regioncode(data_input = corruption$prefecture, 
           year_from = 2019,
           year_to = 1989, 
           convert_to = "area",
           to_pinyin = TRUE
           )
)

# Regions with special spelling
regioncode(data_input = c("山西", "陕西", "内蒙古", "香港", "澳门"), 
           year_from = 2019,
           year_to = 2008, 
           convert_to = "name",
           incomplete_name = "both",
           province = TRUE,
           to_pinyin = TRUE
           )

## ----provinces----------------------------------------------------------------
tibble(
  province = corruption$province_id,
  prov_name = regioncode(data_input = corruption$province_id, 
           convert_to = "name",
           year_from = 2019,
           year_to = 1989,
           province = TRUE),
  prov_abbre = regioncode(data_input = corruption$province_id, 
           convert_to = "codeToabbre",
           year_from = 2019,
           year_to = 1989,
           province = TRUE)
)

## ----2area--------------------------------------------------------------------
regioncode(data_input = corruption$prefecture, 
           year_from = 2019,
           year_to = 1989, 
           convert_to = "area")

## ----language_zone------------------------------------------------------------
tibble(
  city = corruption$prefecture,
  dialectGroup = regioncode(data_input = corruption$prefecture, 
           year_from = 2019,
           year_to = 1989,
           to_dialect = "dia_group"),
  dialectSubGroup = regioncode(data_input = corruption$prefecture, 
           year_from = 2019,
           year_to = 1989,
           to_dialect = "dia_sub_group")
)

