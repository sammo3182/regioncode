## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(message = FALSE, warning = FALSE)

Sys.setlocale(category = "LC_COLLATE", locale = "Chinese")
Sys.setlocale(category = "LC_CTYPE", locale = "Chinese")

## ----toy, eval=FALSE----------------------------------------------------------
#  library(dplyr)
#  library(regioncode)
#  
#  corruption

## ----code2code, eval=FALSE----------------------------------------------------
#  # original geocodes. It's 2019 version
#  corruption$prefecture_id
#  
#  # after conversion. It's 1999 version
#  regioncode(data_input = corruption$prefecture_id,
#             year_from = 2019,
#             year_to = 1999)

## ----code2name, eval=FALSE----------------------------------------------------
#  regioncode(data_input = corruption$prefecture_id,
#             year_from = 2019,
#             year_to = 1999,
#             method = "code2name")

## ----name2code, eval=FALSE----------------------------------------------------
#  corruption$prefecture
#  
#  regioncode(data_input = corruption$prefecture,
#             year_from = 2019,
#             year_to = 1999,
#             method = "name2code")
#  
#  regioncode(data_input = corruption$prefecture,
#             year_from = 2019,
#             year_to = 1999,
#             method = "name2name")

## ----incompleteName, eval=FALSE-----------------------------------------------
#  # Full, official names
#  corruption$prefecture
#  
#  # Incomplete names
#  corruption$prefecture_sname
#  
#  # Converting
#  regioncode(data_input = corruption$prefecture_sname,
#             year_from = 2019,
#             year_to = 1999,
#             method = "name2code",
#             incompleteName = "from")

## ----zhixiashi, eval=FALSE----------------------------------------------------
#  # In the sample data, the division code of municipalities were coded as NA. Filling the codes of municipalities with their provinces' codes.
#  code_zhixiashi <- c("110000", "120000", "310000", "400000")
#  
#  corruption <- corruption %>%
#    mutate(prefecture_id = ifelse(province_id %in% code_zhixiashi, province_id, prefecture_id))
#  
#  # Converting
#  
#  regioncode(data_input = corruption$prefecture_id,
#             year_from = 2019,
#             year_to = 1999,
#             zhixiashi = TRUE)

