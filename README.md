<img src="https://user-images.githubusercontent.com/58319029/109606703-fe189480-7b61-11eb-8235-49d3be2e620a.png" width = "116.9" height = "135" align="right" />

[![CRAN version](http://www.r-pkg.org/badges/version/regioncode)](https://cran.r-project.org/package=regioncode) ![](http://cranlogs.r-pkg.org/badges/grand-total/regioncode)

------------------------------------------------------------------------
regioncode
=========

Inspired by Vincent Arel-Bundock's well-known [`countrycode`](https://joss.theoj.org/papers/10.21105/joss.00848), `regioncode` is an indigenous version for China studies. 


The Chinese government gives unique geocodes for each county, city (prefecture), and provincial-level administrative unit. The so-called "administrative division codes" were consistently adjusted to matched national and regional plans of development. Geocode adjustments disturb researchers when they merge data with different versions of geocodes or region names. Especially, when researchers render statistical data on Chinese map, different geocodes between map data and statistical data may cause mess-up data output or visualization.

The package is developed to conquer such difficulties to match regional data across years more conveniently and correctly. 
In the current version, `regioncode` enables seamlessly converting formal names, common-used names, and division codes of Chinese prefecture regions(named '地级市' in Chinese) between each other and across thirty-four years from 1986 to 2019.

To install:

* the latest released version: `install.packages("regioncode")`.
* the latest developing version: `remotes::install_github("sammo3182/regioncode")`.

More details are available at:

http://cran.r-project.org/web/packages/regioncode/vignettes/regioncode-vignette.html


Please note that this project is released with a [Contributor Code of Conduct](https://github.com/sammo3182/regioncode/blob/master/CONDUCT.md). By participating in this project you agree to abide by its terms.
