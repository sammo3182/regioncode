#' regioncode
#'
#' `regioncode` is developed to conquer the difficulties to convert various region names and administration division codes of Chinese regions. In the current version, `regioncode` enables seamlessly converting Chinese regions' formal names, common-used names, and geocodes between each other at the prefectural level from 1986 to 2019.
#'
#' @param data_input A character vector for names or a six-digit integer vector for division codes to convert.
#' @param year_from A integer to define the year of the input. The default value is 1999.
#' @param year_to A integer to define the year to convert. The default value is 2015.
#' @param convert_to A character indicating the converting methods. At the prefectural level, valid methods include converting between codes in different years, from codes to city ranks, from codes to region names, from region names to city ranks, from region names to division codes, from region names or division codes to sociopolitical area names, and between names in different years. The current version automatically detect the type of the input. Users only need to choose the output to be codes (`code`), names (`name`) , area (`area`) or city ranks (`rank`). The default option is `code`.
#'  When `province` is TRUE, one can also choose `abbre`, `abbreTocode`, `abbreToname`, and `abbreToarea` to convert between names/codes and abbreviations of provinces.
#' @param incomplete_name A logic strong to indicate if the input has incomplete names (not nickname). See more in "Details".
#' @param zhixiashi A logic string to indicate whether treating division codes and names of municipality directly under the central government (Only makes a difference for prefectural-level conversion). The default value is FALSE.
#' @param to_pinyin A logic string to indicate whether the output is in pinyin spelling instead of Chinese characters. The default is FALSE.
#' @param to_dialect A character indicating the language transformation. At the prefectural level, valid transformation include `dia_group`,`dia_sub_group`. At the province level, valid transformation is `dia_super`. The default value is "none".
#'  When `province` is TRUE, one can also choose `dia_super` to get the language zone of provinces.
#' @param province A logic string to indicate the level of converting. The default is FALSE.
#'
#'
#' @details In many national and regional data in China studies, the source applies incomplete names instead of the official, full name of a given region. A typical case is that "Xinjiang" is used much more often than "Xinjiang Weiwuer Zizhiqu" (the Xinjiang Uygur Autonomous Region) for the name of the province. In other cases the "Shi" (City) is often omitted to refer to a prefectural city. `regioncode` accounts this issue by offering the argument `incomplete_name`.
#' \itemize{
#'   \item "none": no short name will be used for either input or output;
#'   \item "from": input data is short names instead of the full, official ones;
#'   \item "to": output results will be short names;
#'   \item "both": both input and output are using short names.
#' }
#'
#' The argument makes a difference only when `code` or `name` are chose in `convert_to`.
#' Users can use this argument together with `name` to convert between names and incomplete names.
#'
#' @returns The function returns a character or numeric vector depending on what method is specified.
#'
#' @import pinyin
#' @import dplyr
#'
#' @examples
#'
#'\dontrun{
#'# The example can be run well but CRAN does not like Chinese characters, so here just "dontrun" it.
#'
#' library(regioncode)
#'
#' regioncode(data_input = corruption$prefecture_id,
#'            year_from = 2016,
#'            year_to = 2017)
#'}
#'
#'
#' @export
regioncode <- function(data_input,
                       year_from = 1999,
                       year_to = 2015,
                       convert_to = "code",
                       incomplete_name = FALSE,
                       zhixiashi = FALSE,
                       to_dialect = "none",
                       to_pinyin = FALSE,
                       province = FALSE) {

  if (!is.character(data_input[1]) & !is.numeric(data_input[1])) {
    stop(
      "Invalid input: only region names as a character vector or division codes as an integer vector are valid."
    )
  }

  if (!is.numeric(year_from)) {
    stop("Invalid input: Converting years must be integers.")
  }

  if (province) {
    if (to_dialect != "none") {
      if (to_dialect != "dia_super") {
        stop("Invalid input: please choose a valid converting transformation.")
      }
    } else {
      if (!(
        convert_to %in% c(
          "name",
          "code",
          "area",
          "rank",
          "nameToabbre",
          "codeToabbre",
          "abbreToname",
          "abbreTocode",
          "abbreToarea"
        )
      )) {
        stop("Invalid input: please choose a valid converting method.")
      }
    }
  } else if (to_dialect != "none") {
    if (!(to_dialect %in% c("dia_group", "dia_sub_group"))) {
      stop("Invalid input: please choose a valid converting transformation.")
    }
  } else {
    if (!(convert_to %in% c("name", "code", "area","rank"))) {
      stop("Invalid input: please choose a valid converting method.")
    }
  }

  if (province == "TRUE" & zhixiashi == "FALSE" & convert_to %in% c("rank")){
    stop("Invalid input: province can not convert to rank.")
    }

  if (!is.logical(province)) {
    stop("Invalid input: param `zhixiashi` must be logical class.")
  }

  if (!is.character(to_dialect)) {
    stop("Invalid input: param `to_dialect` must be character class.")
  }

  if (!is.logical(zhixiashi)) {
    stop("Invalid input: param `zhixiashi` must be logical class.")
  }

  if (!is.logical(to_pinyin)) {
    stop("Invalid input: param `to_pinyin` must be logical class.")
  }

  if (to_pinyin & convert_to == "code" & to_dialect == FALSE) {
    stop("Invalid input: can not translate administrative codes to pinyin.")
  }

  if (province) {
    zhixiashi <- FALSE

    # 1 Section of province-level converting
    if (to_dialect != "none") {
      # 1-1 If convert language zone
      if (is.numeric(data_input[1])) {
        year_from <- "prov_code"
      }
      if (is.character(data_input[1])) {
        year_from <- "prov_name"
      }


      ls_index <- switch(to_dialect,
                         "dia_super" = {
                           year_to <- "prov_language"
                           c(year_from, year_to)
                         }
      )
    } else {
      # 1-2 If not convert language zone
      prov_data <- region_data %>%
        select(prov_code:`1999_nickname`, "area") %>%
        distinct()

      # Because province nicknames changed in 1999
      year_from <- ifelse(year_from < 1999, 1998, 1999)
      year_to <- ifelse(year_to < 1999, 1998, 1999)

      # Getting the correct "from" column
      year_from <- case_when(
        is.numeric(data_input[1]) ~ "prov_code",
        is.character(data_input[1]) ~ "prov_name"
      )

      ls_index <- switch(convert_to,
                         "name" = {
                           year_to <- "prov_name"
                           c(year_from, year_to)
                         },
                         "code" = {
                           year_to <- "prov_code"
                           c(year_from, year_to)
                         },
                         "area" = {
                           year_to <- "area"
                           c(year_from, year_to)
                         },
                         "nameToabbre" = {
                           year_from <- "prov_name"
                           year_to <- paste0(year_to, "_nickname")
                           c(year_from, year_to)
                         },
                         "codeToabbre" = {
                           year_from <- "prov_code"
                           year_to <- paste0(year_to, "_nickname")
                           c(year_from, year_to)
                         },
                         "abbreToname" = {
                           year_from <- paste0(year_to, "_nickname")
                           year_to <- "prov_name"
                           c(year_from, year_to)
                         },
                         "abbreTocode" = {
                           year_from <- paste0(year_from, "_nickname")
                           year_to <- "prov_code"
                           c(year_from, year_to)
                         },
                         "abbreToarea" = {
                           year_from <- paste0(year_from, "_nickname")
                           year_to <- "area"
                           c(year_from, year_to)
                         }
      )
    }
  } else {
    # 2 Section of prefectural-level converting
    if (to_dialect != "none") {
      # 2-1 If convert language zone
      if (is.numeric(data_input[1])) {
        year_from <- paste0(year_from, "_code")
      }
      if (is.character(data_input[1])) {
        year_from <- paste0(year_from, "_name")
      }

      ls_index <- switch(to_dialect,
                         "dia_group" = {
                           year_to <- "pref_language_all"
                           c(year_from, year_to)
                         },
                         "dia_sub_group" = {
                           year_to <- "dia_sub_language_all"
                           c(year_from, year_to)
                         }
      )
    } else {
      # 2-2 If not convert language zone
      if (is.numeric(data_input[1])) {
        year_from <- paste0(year_from, "_code")
      }
      if (is.character(data_input[1])) {
        year_from <- paste0(year_from, "_name")
      }

      region_data <- region_data[!duplicated(region_data$`2019_code`), ]

      ls_index <- switch(convert_to,
                         "code" = {
                           year_to <- paste0(year_to, "_code")
                           c(year_from, year_to)
                         },
                         "area" = {
                           year_to <- "area"
                           c(year_from, year_to)
                         },
                         "name" = {
                           year_to <- paste0(year_to, "_name")
                           c(year_from, year_to)
                         },
                         "rank" = {
                           year_to <- paste0(year_to, "_rank")
                           c(year_from, year_to)
                         }
      )


      # Using the Municipal codes for within region codes
      if (zhixiashi) {

        region_zhixiashi <- region_data %>%
          dplyr::filter(zhixiashi)

        region_sname <- region_zhixiashi %>%
          select(ends_with("_sname"))

        region_name <- region_zhixiashi %>%
          select(ends_with("_name"))

        region_code <- region_zhixiashi %>%
          select(ends_with("_code"))

        region_remain <- region_zhixiashi %>%
          select(-ends_with("_code"),
                 -ends_with("_sname"),
                 -ends_with("_name"),
                 -ends_with("language"),
                 -ends_with("_all"),
                 -ends_with("_nickname"),
                 -'dia_sub_group',
                 -'freq')

        # replacing the prefectural names and codes with provincial names and codes

        region_name2 <-
          replicate(ncol(region_name), region_zhixiashi$prov_name) %>%
          as.data.frame()
        names(region_name2) <- names(region_name)

        region_sname2 <-
          replicate(ncol(region_name), region_zhixiashi$prov_name) %>%
          as.data.frame()
        names(region_sname2) <- names(region_sname2)

        region_code2 <-
          replicate(ncol(region_code), region_zhixiashi$prov_code) %>%
          as.data.frame()
        names(region_code2) <- names(region_code)


        region_zhixiashi <-
          cbind(region_name2, region_code2,region_sname2,region_remain)
        region_zhixiashi <- distinct(
          region_zhixiashi[, order(colnames(region_zhixiashi))])
        region_zhixiashi <- region_zhixiashi %>%
          select('1986_code':prov_scode)

        region_province <- distinct(
          select(region_data,
                 -ends_with("language"),
                 -ends_with("_all"),
                 -ends_with("_nickname"),
                 -dia_sub_group,
                 -freq)
        )
        region_province <- region_province[, order(colnames(region_province))]


        region_data <- bind_rows(region_zhixiashi, region_province)
      }
    }
  }

  # Convert the input to a data.frame for later merging

  data_input <- data_input %>% as.data.frame()
  names(data_input) <- ls_index[1]

  data_output <- select(region_data, !!ls_index) %>%
    distinct()

  if (incomplete_name) {
    data_input[[ls_index[1]]] <-
      substr(data_input[[ls_index[1]]], start = 1, stop = 2) # using the first two characters to match

    data_output[[ls_index[1]]] <-
      substr(data_output[[ls_index[1]]], start = 1, stop = 2) # using the first two characters to match
  }

  data_output <- left_join(data_input, data_output) |>
    # using left_join to keep the order of the input data
    pull(!!year_to)

  # Because '2pinyin' can not be used as a variable name

  if (to_pinyin) {
    data_output <- case_when(
      substr(data_output, start = 1, stop = 2) == "\u9655\u897f" ~ "shaan_xi",
      substr(data_output, start = 1, stop = 2) == "\u5185\u8499" ~ "inner_mongolia",
      substr(data_output, start = 1, stop = 2) == "\u897f\u85cf" ~ "tibet",
      substr(data_output, start = 1, stop = 2) == "\u6fb3\u95e8" ~ "macao",
      substr(data_output, start = 1, stop = 2) == "\u9999\u6e2f" ~ "hong_kong",
      TRUE ~ py(char = substr(data_output, start = 1, stop = 2), dic = pydic(method = "toneless", dic = "pinyin2"))
    )
  }

  return(data_output)  }

