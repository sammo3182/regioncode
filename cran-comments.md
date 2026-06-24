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
