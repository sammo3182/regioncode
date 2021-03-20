#' regioncode
#'
#' `regioncode` is developed to conquer the difficulties to convert various region names and administration division codes of Chinese regions. In the current version, `regioncode` enables seamlessly converting Chinese regions' formal names, common-used names, and geocodes between each other at the prefectural level from 1986 to 2019.
#'
#' @param data_input A character vector for names or a six-digit integer vector for division codes to convert.
#' @param year_from A integer to define the year of the input. The default value is 1999.
#' @param year_to A integer to define the year to convert. The default value is 2015.
#' @param method A character indicating the converting methods. At the prefectural level, valid methods include converting between codes in different years (`code2code`), from codes to region names (`code2name`), from region names to division codes(`name2code`), and between names in different years (`name2name`). The default option is `code2code`.
#' At the provincial level, valid methods include converting provincial codes to full names (`code2name`) or abbreviations (`code2abbre`), names or abbreviations to codes (`name2code` and `abbre2code`), abbreviations to names (`abbre2name`), and provincial name to abbreviations (`name2abbre` and `name2name`, see Details for the usage of `name2name`).
#' @param province A logic string to indicate the level of converting. The default is FALSE.
#' @param zhixiashi (Only makes a difference for prefectural-level conversion) A logic string to indicate whether treat division codes and names of municipality directly under the central government ("zhixiashi" in Chinese Pinyin). The default is FALSE.
#' @param incompleteName A character to specify if a short name of region is used. See the Details for more information. The default is "none". Other options are "from", "to", and "both". The default value is "none".
#'
#' @details In many national and regional data in China studies, the source applies incomplete names instead of the official, full name of a given region. A typical case is that "Xinjiang" is used much more often than "Xinjiang Weiwuer Zizhiqu" (the Xinjiang Uygur Autonomous Region) for the name of the province. In other cases the "Shi" (City) is often omitted to refer to a prefectural city. `regioncode` accounts this issue by offering the argument `incompleteName`. The argument has four options: "none", "from", "to", and "both".
#' \itemize{
#'   \item "none": no short name will be used for either input or output;
#'   \item "from": input data is short names instead of the full, official ones;
#'   \item "to": output results will be short names;
#'   \item "both": both input and output are using short names.
#' }
#'
#' The argument makes a difference only when `name2code` or `name2name` are chose in `method`.
#' Users can use this argument together with `name2name` to convert between names and incomplete names.
#'
#' @returns The function returns a character or numeric vector depending on what method is specified.
#'
#' @import dplyr
#'
#'
#' @examples
#'
#' # library(regioncode)
#'
#'
#' # regioncode(data_input = corruption$prefecture_id,
#' #            year_from = 2019,
#' #           year_to = 1999)
#'
#'
#' @export

regioncode <- function(data_input,
                       year_from = 1999,
                       year_to = 2015,
                       method = "code2code",
                       province = FALSE,
                       zhixiashi = TRUE,
                       incompleteName = "none") {
  if (!is.character(data_input) & !is.numeric(data_input))
    stop(
      'Invalid input: only region names as a character vector or division codes as an integer vector are valid.'
    )

  if (!is.numeric(year_from))
    stop("Invalid input: Converting years must be integers.")

  if(province){
    if (!(method %in% c('code2name', 'code2abbre', 'name2name', 'name2code', 'name2abbre', 'abbre2name', 'abbre2code')))
      stop("Invalid input: please choose a valid converting method.")
  } else {
    if (!(method %in% c('code2name', 'code2code', 'name2name', 'name2code')))
      stop("Invalid input: please choose a valid converting method.")
  }

  if (!(incompleteName %in% c("none", "from", "to", "both")))
    stop(
      "Invalid input: the options of `incompleteName` are one of 'none', 'from', 'to', and 'both'."
    )

  if (province) {
    if (method == 'code2code')
      stop(
        "Invalid input: there is no provincial level code converting. You may want to set the argument `province` to FALSE."
      )

    prov_table <- region_table %>%
      select(prov_code:`1999_nickname`) %>%
      distinct

    year_from <- ifelse(year_from < 1999, 1998, 1999)
    year_to <- ifelse(year_to < 1999, 1998, 1999)

    ls_index <- switch (
      method,
      "code2name" = {
        year_from <- "prov_code"
        year_to <- "prov_name"
        c(year_from, year_to)
      },
      "code2abbre" = {
        year_from <- "prov_code"
        year_to <- paste0(year_to, "_nickname")
        c(year_from, year_to)
      },
      "name2code" = {
        year_from <- "prov_name"
        year_to <- "prov_code"
        c(year_from, year_to)
      },
      "name2name" = {
        year_from <- "prov_name"
        year_to <- "prov_name"
        c(year_from, year_to)
      },
      "name2abbre" = {
        year_from <- "prov_name"
        year_to <- paste0(year_to, "_nickname")
        c(year_from, year_to)
      },
      "abbre2name" = {
        year_from <- paste0(year_from, "_nickname")
        year_to <- "prov_name"
        c(year_from, year_to)
      },
      "abbre2code" = {
        year_from <- paste0(year_from, "_nickname")
        year_to <- "prov_code"
        c(year_from, year_to)
      }
    )


  } else {
    # when doing prefectural level converting

    ls_index <- switch(
      method,
      "code2code" = {
        year_from <- paste0(year_from, '_code')
        year_to <- paste0(year_to, '_code')
        c(year_from, year_to)
      },
      "code2name" = {
        year_from <- paste0(year_from, '_code')
        year_to <- paste0(year_to, '_name')
        c(year_from, year_to)
      },
      "name2code" = {
        year_from <- paste0(year_from, '_name')
        year_to <- paste0(year_to, '_code')
        c(year_from, year_to)
      },
      "name2name" = {
        year_from <- paste0(year_from, '_name')
        year_to <- paste0(year_to, '_name')
        c(year_from, year_to)
      }
    )

    # Using the Municipal codes for within region codes

    if (zhixiashi) {
      region_zhixiashi <- region_table %>%
        filter(zhixiashi)

      region_sname <- region_zhixiashi %>%
        select(ends_with("_sname"))

      region_name <- region_zhixiashi %>%
        select(ends_with("_name"))

      region_code <- region_zhixiashi %>%
        select(ends_with("_code"))

      # replacing the prefectural names and codes with provincial names and codes
      region_sname2 <-
        replicate(ncol(region_sname), region_zhixiashi$prov_name) %>%
        as.data.frame()
      names(region_sname2) <- names(region_sname)

      region_name2 <-
        replicate(ncol(region_name), region_zhixiashi$prov_name) %>%
        as.data.frame()
      names(region_name2) <- names(region_name)

      region_code2 <-
        replicate(ncol(region_code), region_zhixiashi$prov_code) %>%
        as.data.frame()
      names(region_code2) <- names(region_code)

      region_zhixiashi <-
        bind_cols(region_sname2, region_name2, region_code2)
      region_zhixiashi <-
        region_zhixiashi[, order(colnames(region_zhixiashi))]

      region_province <- region_table %>%
        filter(!zhixiashi)
      region_province <-
        region_province[, order(colnames(region_province))]

      region_table <- bind_rows(region_zhixiashi, region_province)
    }

  }


  # When using sname instead of the official name

  ls_index <- case_when(
    incompleteName == "both" ~ gsub("_name", "_sname", ls_index),
    incompleteName == "from" ~ c(gsub("_name", "_sname", ls_index[1]), ls_index[2]),
    incompleteName == "to" ~ c(ls_index[1], gsub("_name", "_sname", ls_index[2])),
    incompleteName == "none" ~ ls_index
  )

  # Updating the year_from/to after the evaluation of `incompleteName`
  if (incompleteName != "none") {
    year_from <- ls_index[1]
    year_to <- ls_index[2]
  }


  # Convert the input to a data.frame for later merging

  df_input <- data_input %>% as.data.frame
  names(df_input) <- ls_index[1]

  data_output <-
    select(region_table, !!ls_index) %>%
    distinct() %>%
    left_join(df_input,.) %>% # using left_join to keep the order of the input data
    pull(!!year_to)

  return(data_output)
}

