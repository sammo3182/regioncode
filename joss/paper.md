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

# Basic Usage

We uses a randomly drawn sample of Yuhua Wang's [`China’s Corruption Investigations Dataset`](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/9QZRAD) to illustrate how the package works.

In `regioncode` package, we named administrative division codes as `code`, regions' formal names as `name`, and their commonly used abbreviation as `sname`. In the current version, the function can produce three types of output at both the prefectural and provincial levels: codes (`code`), names (`name`) and area (`area`).One just needs to specify which type of the output they want in the argument `convert_to` and corresponding years of the input and output.

For example, the following codes convert the 2019 geocodes in the `corruption` data to their 1989 version:

```r
library(regioncode)

data("corruption")

# Original 2019 version
corruption$prefecture_id
```

![](https://user-images.githubusercontent.com/39488085/127256350-6e40d218-49f0-4c88-b996-08a375b83fcf.png)

```r
# 1999 version
regioncode(data_input = corruption$prefecture_id, 
           convert_to = "code", # default set
           year_from = 2019,
           year_to = 1989)
```

![](https://user-images.githubusercontent.com/39488085/127259452-0c807d54-dc3a-4aa3-9c5f-48caa53ff2e5.png)

Note that if a region was initially geocoded in e.g., 1989 and included in a new region, in 2019, the new region geocode will be used hereafter.If a big place was broken into several regions, the later-year codes will be aligned with the first region according to the ascendant order of the regions' numeric geocodes.

By altering the output format to `name`, one can easily convert codes or region names of a given year to region names in another year.`regioncode` automatically detects the input format, so users need to specify the *output* format only (together with the input and output years) to gain what they want.

```R
# The original name
corruption$prefecture
```

![](https://user-images.githubusercontent.com/39488085/127256356-768cd2bc-fdf7-43ca-b755-5256264bd57e.png)

```R
# Codes to name

regioncode(data_input = corruption$prefecture_id, 
           convert_to = "name",
           year_from = 2019,
           year_to = 1989)
```

![](https://user-images.githubusercontent.com/39488085/127256360-70c87af1-f180-4eb2-9530-5f167b57d2a9.png)

```R
# Name to codes of the same year

regioncode(data_input = corruption$prefecture, 
           convert_to = "code",
           year_from = 2019,
           year_to = 2019)
```

![](https://user-images.githubusercontent.com/39488085/127256361-ad389b45-a30f-4bba-929d-3024fe608e83.png)

# Advanced Applications

To further help uses with "messier" data and diverse demands, `regioncode` provides five special conversions: conversion from data with incomplete data, specification of municipalities, conversion sociopolitical areas and linguistic areas, and pinyin output.

## Incomplete naming prefectures.

More than often, data codes may omit the administrative level when recording geo-information. To accomplish conversions of such data, one needs to specify the `incomplete_name` argument. If the input data is incomplete, users should set the argument as "from". Optional values also include "to" and '"both"'.

```R
# Full, official names
corruption$prefecture
```

![](https://user-images.githubusercontent.com/39488085/127256365-a8a22896-0527-4877-b756-3536ff62a33f.png)

```R
regioncode(data_input = corruption$prefecture, 
           convert_to = "name",
           year_from = 2019,
           year_to = 1989,
           incomplete_name = "to")
```

![](https://user-images.githubusercontent.com/39488085/127256368-eff66803-3e9f-413f-a623-88f78783a624.png)

## Municipalities

Municipalities (named "zhixiashi" in Chinese Pinyin) are geographically cities but administratively provincial. `regioncode` sets an argument `zhixiashi`. When the argument is set `TRUE`, the municipalities are treated as whole prefectures, and their provincial codes are used as the geocodes.

## Sociopolitical and Linguistic Areas

Due to social, political, and martial reasons, Chinese regions are divided into eight regions:

![](https://user-images.githubusercontent.com/39488085/127285356-fd127c29-0c58-462a-8879-aacea3f8bb50.png)

`regioncode` also offers a method "area" to convert codes and names of the region into such areas.

```R
regioncode(data_input = corruption$prefecture, 
           year_from = 2019,
           year_to = 1989, 
           convert_to="area")
```

![](https://user-images.githubusercontent.com/39488085/127256372-67f37c57-da41-4c0b-9a5a-1da8565fc4b4.png)

China is a multilingual country with a variety of dialects. These dialects may be used by several prefectures in a province or province. Prefectures from different provinces may also share the same dialect. `regioncode` allows users to gain linguistic zones the prefectures belong as an output. Users can gain two levels of linguistic zones, dialect groups and dialect sub-groups by setting the argument `to_pinyin` to `dia_group` or `dia_sub_group`. 

```R
regioncode(data_input = corruption$prefecture, 
           year_from = 2019,
           year_to = 1989,
           to_dialect = "dia_group")
```

![](https://user-images.githubusercontent.com/39488085/127256373-88f4f02e-6653-4971-906a-4f796dab1bb0.png)

## Pinyin

Pinyin is a Chinese phonetic romanization. Some data stores the region names with pinyin instead of Chinese characters. The default name output of `regioncode` uses Chinese characters, but one can gain pinyin output by setting the argument `to_pinyin = TRUE`. 

```R
regioncode(data_input = corruption$prefecture, 
           year_from = 2019,
           year_to = 1989, 
           convert_to="name",
           to_pinyin=TRUE
           )
```

![](https://user-images.githubusercontent.com/39488085/127256378-f5063101-049b-4bf3-abe2-adea2f4ee67e.png)

## Provinces

`regioncode` allows conversions at not only the prefectural but provincial level. By setting the argument `province = TRUE`, users can accomplish all the code, name, and area conversions at the provincial level. When the inputs are abbreviations, users can set the `convert_to` argument to `abbreTocode`, `abbreToname`, or `abbreToarea`. 

```R
regioncode(data_input = corruption$province_id, 
           convert_to = "codeToabbre",
           year_from = 2019,
           year_to = 1989,
           province = TRUE)
```

![](https://user-images.githubusercontent.com/39488085/127256346-72c3b942-fa32-445f-a74e-4a2440e5cb91.png)

# Acknowledgements

We acknowledge contributions from Meng Zhu, Xueyan Liu, Yuyang Shi, Yujia Xu, and Yuxin Pan, Haiting Tian, Weihang Shao, and Yuanqian Chen.

# References
