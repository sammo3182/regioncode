# 0.3.0

- Fixed `incomplete_name = "from"` and `"both"`: short-name inputs are now
  matched correctly instead of always returning `NA` (this also restores
  `to_pinyin` output for province conversions from incomplete names).
- Simplified and sped up the core `regioncode()` conversion by matching on the
  lookup vectors directly and removing redundant data-frame copies and dead code.
- Cleaned trailing whitespace from the internal region data.
- Vignette no longer depends on a fragile relative path to the package's
  internal data and renders reproducibly.

# 0.2.1

- Fixed the `to_pinyin` function
- Fixed the `incomplete_name` function

# 0.2.0

- Updated the code to assign province‘s name to a city based on the year
- Added more data like Yunnan and Guizhou
- Extended the year range to 2022
- Fixed some data errors
- Vectorized the merging functions
- Corrected the region codes of Xinjiang

# 0.1.2

- New function `rank` for level of cities
- New method in `incomplete_name` so that the function can deal with input with only part of incomplete region names
- Bug fix
  - present Shaanxi, tibet, macao, hongkong, inner_mongolia correctly
  - full name of "Ning Xia"
  - Correct name of Xinjiang

# 0.1.1

+ Styled function with tidyverse style
+ Rewrote `method ` as `convert_to`
+ Rewrote `incompleteName` as `incomplete_name`
+ Rewrote `language_region` and `language_trans`  as `to_dialect`
+ Simplified the codes.
+ Added more detailed warning messages.

# 0.0.9

+ Enable to provincial-level conversion with `province`
+ Fixed the error of `incompleteName`
+ Simplified the codes.
+ Add parameter topinyin & method "2area"
+ Remove unnecessary warning about 'code2code'
+ Fix the bug in language_region
