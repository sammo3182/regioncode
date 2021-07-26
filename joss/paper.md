---
title: 'regioncode: Convert Region Names and Division Codes of China Over Years'
tags:
- R
- CRAN
- social science
- region names
- region codes
- Chinese geography
date: "14 July 2021"
output: pdf_document
authors:
- name: Yue Hu
  orcid: 0000-0002-2829-3971
  affiliation: 1
- name: Yufei Sun
  affiliation: 1
- name: Wenquan Wu
  affiliation: 1
bibliography: paper.bib
affiliations:
- name: Department of Political Science, Tsinghua University
  index: 1
---

# Summary

The Chinese government gives unique geocodes for each county, city (prefecture), and provincial-level administrative unit. The so-called “administrative division codes” were consistently adjusted to matched national and regional plans of development. Geocode adjustments disturb researchers when they merge data with different versions of geocodes or region names. Especially, when researchers render statistical data on a Chinese map, different geocodes between map data and statistical data may cause mess-up data output or visualization.

The package is developed to conquer such difficulties to match regional data across years more conveniently and correctly. Inspired by Vincent Arel-Bundock’s well-known `countrycode` [@Arel-Bundock2018], we created `regioncode` to achieve similar functions specifically for China studies. `regioncode` enables seamlessly converting formal names, common-used names, and division codes of Chinese prefecture regions between each other and across thirty-four years from 1986 to 2019.

In the current version, we provide three basic functions` 2code`, `2name`, and `2sname` to convert formal names, common-used names, and division codes between each other. We also provide some useful features: `incompleteName`, which completes incomplete parameters; `2area`, which converts region codes and names of the region into the municipal area that they belong to; `topinyin`, which convert the names or areas into the form of pinyin; and `todialect`, which offers a function to convert the name of prefecture from any year to language(local dialect) zone.

# Examples

## Division codes across years

`regioncode` function accept numeric and character vectors as the input division codes and region names respectively. To achieve an accurate conversion, users have to specify the year of the source data correctly in the argument year_from. Then they can set the year they want the output is. That’s it. See the following example to convert the 2019-version codes to the 1999 version:

```R
# load toy data and package
library(regioncode)
library(dplyr)
corruption <- sample_n(na.exclude(corruption), 10)

# original geocodes. It's 2019 version
corruption$prefecture_id
[1] 430100 371700 530100 640300 431100 621100 330400 360400 441500 421000

# after conversion. It's 1999 version
regioncode(data_input = corruption$prefecture_id, 
           year_from = 2019,
           year_to = 1999)
[1] 430100 372900 530100 640300 431100 622400 330400 360400 441500 421000
```

## Division codes to region name

In some cases, the original data may only have division codes or region names, but users need the other form or both formats of data. In such cases, `regioncode` offers a function to convert division codes from any year to region names in any year. Users only need to alter the converting method, for example, to “2name” in order to convert division codes to region names.

```R
regioncode(data_input = corruption$prefecture_id, 
           year_from = 2019,
           year_to = 1999, 
           method = "2name")
```

> [1] "长沙市"   "菏泽地区" "昆明市"   "吴忠市"   "永州市"   "定西地区"
> [7] "嘉兴市"   "九江市"   "汕尾市"   "荆州市"



