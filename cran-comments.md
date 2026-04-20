## Resubmission
This is the second error-correction release after 0.2.1. It fixes:

* The region code for Danzhou (儋州市) for 2015–2022 (#55).
* A typo and naming-inconsistency in the 2020–2022 city-rank columns that caused `convert_to = "rank"` to silently return NA for those years (#51).

## Test environments
* Local macOS install, R 4.4.3

## R CMD check results
0 errors | 0 warnings | 0 notes
