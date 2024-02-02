# regioncode 0.2.0

- New function `rank` for level of cities
- New method in `incomplete_name` so that the function can deal with input with only part of incomplete region names
- Bug fix
  - present Shaanxi, tibet, macao, hongkong, inner_mongolia correctly
  - full name of "Ning Xia"
  - Correct name of Xinjiang

# regioncode 0.1.1

+ Styled function with tidyverse style
+ Rewrote `method ` as `convert_to`
+ Rewrote `incompleteName` as `incomplete_name`
+ Rewrote `language_region` and `language_trans`  as `to_dialect`
+ Simplified the codes.
+ Added more detailed warning messages.

# regioncode 0.0.9

+ Enable to provincial-level conversion with `province`
+ Fixed the error of `incompleteName`
+ Simplified the codes.
+ Add parameter topinyin & method "2area"
+ Remove unnecessary warning about 'code2code'
+ Fix the bug in language_region
