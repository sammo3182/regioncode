<<<<<<< HEAD
## Submission

This is a maintenance release (0.3.0). It fixes the `incomplete_name` matching
for short-name inputs, simplifies and speeds up the core conversion function,
cleans the internal region data, and makes the vignette build reproducibly.

## Test environments

* Local Windows 11, R-devel
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 0 notes

## Notes

The package and vignette contain Chinese (UTF-8) characters, which are
essential to its purpose of converting Chinese region names and codes. All
such strings declare `\VignetteEncoding{UTF-8}` and the package sets
`Encoding: UTF-8`. Examples that print Chinese characters are wrapped in
`\dontrun{}` in the manual.
=======
## Resubmission
This is the second error-correction release after 0.2.1. It fixes:

* The region code for Danzhou (儋州市) for 2015–2022 (#55).
* A typo and naming-inconsistency in the 2020–2022 city-rank columns that caused `convert_to = "rank"` to silently return NA for those years (#51).

## Test environments
* Local macOS install, R 4.4.3

## R CMD check results
0 errors | 0 warnings | 0 notes
>>>>>>> 77e5333652aeb34daa8512764b76d195a8959c89
