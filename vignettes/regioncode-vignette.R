## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(message = FALSE, warning = FALSE)

## ----code2code----------------------------------------------------------------
library(regioncode)

data("corruption")

# Original 2019 version
corruption$prefecture_id

# 1999 version
regioncode(data_input = corruption$prefecture_id,
           convert_to = "code", # default set
           year_from = 2019,
           year_to = 1989)

## ----code2name----------------------------------------------------------------
# The original name
corruption$prefecture

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
# Full, official names
corruption$prefecture

regioncode(data_input = corruption$prefecture,
           convert_to = "name",
           year_from = 2019,
           year_to = 1989,
           incomplete_name = "to")

## ----2area--------------------------------------------------------------------
regioncode(data_input = corruption$prefecture,
           year_from = 2019,
           year_to = 1989,
           convert_to="area")

## ----rank-----------------------------------------------------------------
regioncode(data_input = corruption$prefecture,
           year_from = 2011,
           year_to = 1989,
           convert_to="rank")

## ----language_zone------------------------------------------------------------
regioncode(data_input = corruption$prefecture,
           year_from = 2019,
           year_to = 1989,
           to_dialect = "dia_group")

regioncode(data_input = corruption$prefecture,
           year_from = 2019,
           year_to = 1989,
           to_dialect = "dia_sub_group")

## ----pinyin-------------------------------------------------------------------
regioncode(data_input = corruption$prefecture,
           year_from = 2019,
           year_to = 1989,
           convert_to="name",
           to_pinyin=TRUE
           )

regioncode(data_input = corruption$prefecture,
           year_from = 2019,
           year_to = 1989,
           convert_to="name",
           incomplete_name = "to",
           to_pinyin=TRUE
           )

regioncode(data_input = corruption$prefecture,
           year_from = 2019,
           year_to = 1989,
           convert_to="area",
           to_pinyin=TRUE
           )

## ----provinces----------------------------------------------------------------
regioncode(data_input = corruption$province_id,
           convert_to = "codeToabbre",
           year_from = 2019,
           year_to = 1989,
           province = TRUE)

