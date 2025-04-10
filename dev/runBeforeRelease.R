# Check List for A New Release

library(here)
load(here("R", "sysdata.rda"))
save(corruption, region_data, file = here("R", "sysdata.rda"), compress = "bzip2")


## Vignette building
library(devtools)

install(build_vignettes = TRUE)
pkgdown::build_site()

## Spell checking
library(roxygen2)

spell_check()

rhub::validate_email(email = "yuehu@tsinghua.edu.cn") # the token needs to gain from email again

check_rhub(email = "yuehu@tsinghua.edu.cn")

## Run the CRAN check
# 1. Under the `Build` tab
# 1. Fixed all the errors and warnings

## Documentation

# 1. Update the version number in `DESCRIPTION`
# 1. Update `NEWS`

## Removing the htmls to release space

library(here)

ls_html <-
  list.files(here("inst/tutorials"),
             pattern = "*.html$",
             recursive = TRUE,
             full.names = TRUE)

file.remove(ls_html)

## Release

devtools::release()

## Change the version number in `DESCRIPTION` back to the dev version (i.e., "9999")

## Post the Release note when the package is on CRAN


## (No need if the package already has a website) Package website building
# library(devtools)
#
# usethis::git_vaccinate() #Adds .DS_Store, .Rproj.user, .Rdata, .Rhistory, and .httr-oauth to your global (a.k.a. user-level) .gitignore. This is good practice as it decreases the chance that you will accidentally leak credentials to GitHub.
#
# use_github_links()
# use_github_action_check_standard()
#
# library(pkgdown)
# build_site()
