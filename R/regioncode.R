#' `regioncode` is developed to conquer the difficulties to convert various region names and administration division codes of Chinese regions. In the current version, `regioncode` enables seamlessly converting Chinese regions' formal names, common-used names, and geocodes between each other at the prefectural level from 1986 to 2019.
#'
#' @param data_input A character vector for names or a six-digit integer vector for division codes to convert.
#' @param year_from A integer to define the year of the input. The default value is 1999.
#' @param year_to A integer to define the year to convert. The default value is 2015.
#' @param convert_to A character indicating the converting methods. At the prefectural level, valid methods include converting between codes in different years, from codes to city ranks, from codes to region names, from region names to city ranks, from region names to division codes, from region names or division codes to sociopolitical area names, and between names in different years. The current version automatically detect the type of the input. Users only need to choose the output to be codes (`code`), names (`name`) , area (`area`) or city ranks (`rank`). The default option is `code`.
#'  When `province` is TRUE, one can also choose `abbre`, `abbreTocode`, `abbreToname`, and `abbreToarea` to convert between names/codes and abbreviations of provinces.
#' @param incomplete_name A character string indicating how incomplete (short) names are handled.
#'   One of \code{"none"} (default), \code{"from"}, \code{"to"}, or \code{"both"}. See "Details".
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
#'
#' @examples
#' \dontrun{
#' # The example can be run well but CRAN does not like Chinese characters, so here just "dontrun" it.
#'
#' library(regioncode)
#'
#' regioncode(
#'   data_input = corruption$prefecture_id,
#'   year_from = 2016,
#'   year_to = 2017
#' )
#' }
#'
#' @export
#'
#'

regioncode <- function(data_input,
                      year_from = 1999,
                      year_to = 2015,
                      convert_to = "code",
                      incomplete_name = "none",
                      zhixiashi = FALSE,
                      to_dialect = "none",
                      to_pinyin = FALSE,
                      province = FALSE) {
  validate_input(
    data_input,
    year_from,
    province,
    to_dialect,
    convert_to,
    zhixiashi,
    to_pinyin,
    incomplete_name
  )


  if (province) {
    zhixiashi <- FALSE

    # 1 Section of province-level converting
    if (to_dialect != "none") {
      # 1-1 If convert language zone
      year_from <- if (is.numeric(data_input[1])) {
        "prov_code"
      } else {
        "prov_name"
      }

      ls_index <- if (to_dialect == "dia_super") {
        year_to <- "prov_language"
        c(year_from, year_to)
      }
    } else {
      # 1-2 If not convert language zone
      prov_data <- unique(region_data[, c("prov_code", paste0("199", 8:9, "_nickname"), "area")])

      # Because province nicknames changed in 1999
      year_num <- ifelse(as.numeric(year_from) < 1999, 1998, 1999)
      year_from <- if (is.numeric(data_input[1])) {
        "prov_code"
      } else {
        "prov_name"
      }

      if (!is.na(year_to) && year_to < 1988) {
        data_input <- gsub("\u6d77\u5357\u7701", "\u5e7f\u4e1c\u7701", data_input)
      }
      if (!is.na(year_to) && year_to < 1997) {
        data_input <- gsub("\u91cd\u5e86\u5e02", "\u56db\u5ddd\u7701", data_input)
      }


      year_to <- switch(convert_to,
                        "name" = "prov_name",
                        "code" = "prov_code",
                        "area" = "area",
                        "nameToabbre" = {
                          year_from <- "prov_name"
                          paste0(year_num, "_nickname")
                        },
                        "codeToabbre" = {
                          year_from <- "prov_code"
                          paste0(year_num, "_nickname")
                        },
                        "abbreToname" = {
                          year_from <- paste0(year_num, "_nickname")
                          "prov_name"
                        },
                        "abbreTocode" = {
                          year_from <- paste0(year_num, "_nickname")
                          "prov_code"
                        },
                        "abbreToarea" = {
                          year_from <- paste0(year_num, "_nickname")
                          "area"
                        }
      )
      ls_index <- c(year_from, year_to)
    }
  } else {
    # 2 Section of prefectural-level converting
    if (to_dialect != "none") {
      # 2-1 If convert language zone
      year_from <- if (is.numeric(data_input[1])) {
        paste0(year_from, "_code")
      } else {
        paste0(year_from, "_name")
      }

      year_to <- if (to_dialect == "dia_group") {
        "pref_language_all"
      } else if (to_dialect == "dia_sub_group") {
        "dia_sub_language_all"
      }
      ls_index <- c(year_from, year_to)
    } else {
      # 2-2 If not convert language zone
      year_from <- if (is.numeric(data_input[1])) {
        paste0(year_from, "_code")
      } else {
        paste0(year_from, "_name")
      }

      region_data <- region_data[!duplicated(region_data$`2019_code`), ]

      year_to <- switch(convert_to,
                        "code" = paste0(year_to, "_code"),
                        "area" = "area",
                        "name" = paste0(year_to, "_name"),
                        "rank" = paste0(year_to, "_rank")
      )
      ls_index <- c(year_from, year_to)

      # Using the Municipal codes for within region codes
      if (zhixiashi) {
        region_zhixiashi <- subset(region_data, zhixiashi)

        # Gathering all the needed fields
        region_sname <- region_zhixiashi[grep("_sname$", names(region_zhixiashi))]
        region_name <- region_zhixiashi[grep("_name$", names(region_zhixiashi))]
        region_code <- region_zhixiashi[grep("_code$", names(region_zhixiashi))]
        region_remain <- region_zhixiashi[!grepl(
          "(_code$|_sname$|_name$|language$|_all$|_nickname$|dia_sub_group$|freq$)", names(region_zhixiashi)
        )]

        # Replacing prefectural names and codes with provincial ones
        region_name2 <- as.data.frame(matrix(
          rep(region_zhixiashi$prov_name, ncol(region_name)),
          ncol = ncol(region_name)
        ))
        names(region_name2) <- names(region_name)

        region_sname2 <- as.data.frame(matrix(
          rep(region_zhixiashi$prov_sname, ncol(region_sname)),
          ncol = ncol(region_sname)
        ))
        names(region_sname2) <- names(region_sname)

        region_code2 <- as.data.frame(matrix(
          rep(region_zhixiashi$prov_code, ncol(region_code)),
          ncol = ncol(region_code)
        ))
        names(region_code2) <- names(region_code)

        region_zhixiashi <- cbind(
          region_name2,
          region_code2,
          region_sname2,
          region_remain
        )
        region_zhixiashi <- unique(region_zhixiashi[, order(names(region_zhixiashi))])

        region_province <- unique(region_data[!grepl("language$|_all$|_nickname$|dia_sub_group$|freq$", names(region_data))])
        region_province <- region_province[, order(names(region_province))]

        region_data <- rbind(region_zhixiashi, region_province)
      }
    }
  }

  # Convert the input to a data.frame for later merging
  data_input <- as.data.frame(data_input)
  names(data_input) <- ls_index[1]

  # Determine sname column for output if needed
  out_sname_col <- if (incomplete_name %in% c("to", "both") && grepl("_name$", year_to)) {
    sub("_name$", "_sname", year_to)
  } else {
    NULL
  }

  # Fetch output table (include sname col if needed for output)
  cols_needed <- if (!is.null(out_sname_col)) c(ls_index, out_sname_col) else ls_index
  data_output <- unique(region_data[cols_needed])

  # Get matching index based on full or shortened names
  if (incomplete_name %in% c("from", "both") && grepl("_name$", ls_index[1])) {
    sname_in_col <- sub("_name$", "_sname", ls_index[1])
    index <- match(data_input[[ls_index[1]]], data_output[[sname_in_col]])
  } else {
    index <- match(data_input[[ls_index[1]]], data_output[[ls_index[1]]])
  }

  # Get output data (use sname column when "to" or "both")
  if (!is.null(out_sname_col)) {
    data_output <- data_output[index, out_sname_col, drop = TRUE]
  } else {
    data_output <- data_output[index, year_to, drop = TRUE]
  }

  # Because '2pinyin' can not be used as a variable name

  if (to_pinyin) {
    first_two_chars <- substr(data_output, 1, 2)
    result <- pinyin_lookup[first_two_chars]
    unknown_mask <- is.na(result) & !is.na(first_two_chars)
    if (any(unknown_mask)) {
      warning(
        "to_pinyin: no pinyin found for: ",
        paste(unique(first_two_chars[unknown_mask]), collapse = ", "),
        ". Returning NA for those entries."
      )
    }
    data_output <- unname(result)
  }

  return(data_output)
}
# Function to validate input

validate_input <- function(
    data_input,
    year_from,
    province,
    to_dialect,
    convert_to,
    zhixiashi,
    to_pinyin,
    incomplete_name) {
  # Fast type check for data_input using first element only
  input_type <- typeof(data_input[1])

  if (!(input_type %in% c("character", "double", "integer"))) {
    stop("Invalid input: only region names or division codes are valid.")
  }

  # Single logical check for multiple boolean parameters
  if (!is.logical(province) || !is.logical(zhixiashi) || !is.logical(to_pinyin)) {
    stop("Invalid input: Boolean parameters must be TRUE or FALSE.")
  }

  # Simple numeric check
  if (!is.numeric(year_from)) {
    stop("Invalid input: year_from must be numeric.")
  }
  # Pre-define valid conversion sets
  base_conversions <- c("name", "code", "area", "rank")
  province_conversions <- c(
    base_conversions,
    "nameToabbre",
    "codeToabbre",
    "abbreToname",
    "abbreTocode",
    "abbreToarea"
  )

  # Direct lookup for valid conversions
  valid_conversions <- if (province && to_dialect == "none") {
    province_conversions
  } else {
    base_conversions
  }

  # Single membership test
  if (!(convert_to %in% valid_conversions)) {
    stop("Invalid input: please choose a valid converting method.")
  }

  # Direct condition check for pinyin conversion
  if (to_pinyin && convert_to == "code" && to_dialect == "none") {
    stop("Invalid input: cannot translate administrative codes to pinyin.")
  }

  if (!incomplete_name %in% c("none", "from", "to", "both")) {
    stop('Invalid input: incomplete_name must be one of "none", "from", "to", or "both".')
  }
}
