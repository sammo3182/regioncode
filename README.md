[![CRAN version](http://www.r-pkg.org/badges/version/regioncode)](https://cran.r-project.org/package=regioncode) ![](http://cranlogs.r-pkg.org/badges/grand-total/regioncode)

------------------------------------------------------------------------
regioncode
=========

Inspired by Professor Vincent Arel-Bundock's well-known [`countrycode`](https://joss.theoj.org/papers/10.21105/joss.00848), `regioncode` is indigenous version for China studies. 
Chinese government gives unique geocodes for each county, city, and provincial level administrative unit. 
The geocodes were consistently adjusted to matched the national and regional plans of development, taking the new centrally-administered municipality Chongqing (1997) and new state-level new area Xiong'an (2016) as examples. 

The package is developed to conquer the difficulties to match regional data across years due such geocodes adjustments. 
In the current version, `regioncode` enables seamlessly converting regions' formal names, common-used names, and geocodes between each other and across thirty-four years from 1986. 

To install:

* the latest released version: `install.packages("regioncode")`.
* the latest developing version: `remotes::install_github("sammo3182/regioncode")`.

More details are available at:

http://cran.r-project.org/web/packages/regioncode/vignettes/regioncode-vignette.html


Please note that this project is released with a [Contributor Code of Conduct](https://github.com/sammo3182/regioncode/blob/master/CONDUCT.md). By participating in this project you agree to abide by its terms.
