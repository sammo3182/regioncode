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

The Chinese government gives unique geocodes for each county, city (prefecture), and provincial-level administrative unit. The so-called “administrative division codes” were consistently adjusted to matched national and regional plans of development. Geocode adjustments disturb researchers when they merge data with different versions of geocodes or region names. Especially, when researchers render statistical data on Chinese map, different geocodes between map data and statistical data may cause mess-up data output or visualization.


The package is developed to conquer such difficulties to match regional data across years more conveniently and correctly. Inspired by Vincent Arel-Bundock’s well-known `countrycode` [@Arel-Bundock2018], we created `regioncode` to achieve similar functions specifically for China studies. In the current version, `regioncode` enables seamlessly converting formal names, common-used names, and division codes of Chinese prefecture regions between each other and across thirty-four years from 1986 to 2019.

# Examples

```r
library(regioncode)

# Division codes across years 

## original geocodes. It's 2019 version
corruption$prefecture_id

## after conversion. It's 1999 version
regioncode(data_input = corruption$prefecture_id, 
           year_from = 2019,
           year_to = 1999)

# Division codes to region name

regioncode(data_input = corruption$prefecture_id, 
           year_from = 2019,
           year_to = 1999, 
           method = "code2name")

# Advanced Usages: incomplete input

## Full, official names
corruption$prefecture

## Incomplete names
corruption$prefecture_sname

## Converting
regioncode(data_input = corruption$prefecture_sname, 
           year_from = 2019,
           year_to = 1999, 
           method = "name2code",
           incompleteName = "from")
           
```

# Acknowledgements

We acknowledge contributions from Yuyang Shi, Yujia Xu, and Yuxin Pan, Haiting Tian, Weihang Shao, and Yuanqian Chen.

# References