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
                      incomplete_name = FALSE,
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
    to_pinyin
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

  data_output <- unique(region_data[ls_index])
  data_output_match <- data_output

  # Get matching index based on full or shortened names
  if (incomplete_name) {
    data_output_match[[ls_index[1]]] <- substr(data_output[[ls_index[1]]], 1, 2)
    data_input[[ls_index[1]]] <- substr(data_input[[ls_index[1]]], 1, 2)
    index <- match(data_input[[ls_index[1]]], data_output_match[[ls_index[1]]])
  } else {
    index <- match(data_input[[ls_index[1]]], data_output[[ls_index[1]]])
  }

  # Get output data
  data_output <- data_output[index, year_to, drop = TRUE]

  # Shorten output names if needed
  if (incomplete_name && convert_to == "name" && incomplete_name %in% c("to", "both")) {
    data_output <- substr(data_output, 1, 2)
  }

  # Because '2pinyin' can not be used as a variable name

  if (to_pinyin) {
    # Predefined mapping for special cases with Chinese characters
    special_cases <- c(
      "\u9655\u897f" = "shaan_xi",
      "\u5185\u8499" = "inner_mongolia",
      "\u897f\u85cf" = "tibet",
      "\u6fb3\u95e8" = "macao",
      "\u9999\u6e2f" = "hong_kong"
    )

    # Extract the first two characters of each entry in data_output
    first_two_chars <- substr(data_output, 1, 2)

    # Apply special cases mapping
    special_pinyin <- special_cases[first_two_chars]

    # Use py function where no special case is matched
    data_output <- ifelse(is.na(special_pinyin),
      py(
        char = first_two_chars,
        dic = pydic(method = "toneless", dic = "pinyin2")
      ),
      special_pinyin
    )
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
    to_pinyin) {
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
}

