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

regioncode <- function(data_input,
                       year_from = 1999,
                       year_to = 2015,
                       convert_to = "code",
                       incomplete_name = FALSE,
                       zhixiashi = FALSE,
                       to_dialect = "none",
                       to_pinyin = FALSE,
                       province = FALSE) {
  # Validate inputs first
  validate_input(data_input, year_from, province, to_dialect, convert_to, zhixiashi, to_pinyin)

  # Pre-calculate common values
  is_numeric_input <- is.numeric(data_input[1])
  if (province) {
    # Province-level conversion logic
    if (to_dialect != "none") {
      year_from <- if (is_numeric_input) "prov_code" else "prov_name"

      if (to_dialect == "dia_super") {
        ls_index <- c(year_from, "prov_language")
      }
    } else {
      # Optimize data selection for province conversion
      prov_data <- unique(region_data[, c("prov_code", paste0("199", 8:9, "_nickname"), "area")])
      year_num <- if (year_from < 1999) 1998 else 1999
      year_from <- if (is_numeric_input) "prov_code" else "prov_name"

      # Use direct mapping instead of switch for better performance
      conversion_map <- list(
        name = "prov_name",
        code = "prov_code",
        area = "area",
        nameToabbre = c(from = "prov_name", to = paste0(year_num, "_nickname")),
        codeToabbre = c(from = "prov_code", to = paste0(year_num, "_nickname")),
        abbreToname = c(from = paste0(year_num, "_nickname"), to = "prov_name"),
        abbreTocode = c(from = paste0(year_num, "_nickname"), to = "prov_code"),
        abbreToarea = c(from = paste0(year_num, "_nickname"), to = "area")
      )

      conv <- conversion_map[[convert_to]]
      year_from <- if (length(conv) == 2) conv["from"] else year_from
      year_to <- if (length(conv) == 2) conv["to"] else conv

      ls_index <- c(year_from, year_to)
    }
  } else {
    # Prefectural-level conversion logic
    year_from <- if (is_numeric_input) {
      paste0(year_from, "_code")
    } else {
      paste0(year_from, "_name")
    }

    if (to_dialect != "none") {
      year_to <- if (to_dialect == "dia_group") "pref_language_all" else "dia_sub_language_all"
      ls_index <- c(year_from, year_to)
    } else {
      # Optimize data selection and deduplication
      region_data <- region_data[!duplicated(region_data$`2019_code`), ]

      # Direct mapping for conversion types
      year_to <- paste0(year_to, switch(convert_to,
        code = "_code",
        area = "",
        name = "_name",
        rank = "_rank"
      ))

      ls_index <- c(year_from, year_to)

      if (zhixiashi) {
        region_data <- process_zhixiashi(region_data)
      }
    }
  }

  # Optimize data processing
  data_input <- data.frame(x = data_input, stringsAsFactors = FALSE)
  names(data_input) <- ls_index[1]

  data_output <- unique(region_data[ls_index])

  if (incomplete_name) {
    data_input[[1]] <- substr(data_input[[1]], 1, 2)
    data_output[[1]] <- substr(data_output[[1]], 1, 2)
  }

  # Optimize matching and indexing
  result <- data_output[[year_to]][match(data_input[[1]], data_output[[1]])]
  if (to_pinyin) {
    result <- convert_to_pinyin(result)
  }

  return(result)
}

# Helper function for zhixiashi processing
process_zhixiashi <- function(region_data) {
  region_zhixiashi <- subset(region_data, zhixiashi)

  # Pre-compile patterns
  name_pattern <- "_name$"
  code_pattern <- "_code$"
  sname_pattern <- "_sname$"
  exclude_pattern <- "(_code$|_sname$|_name$|language$|_all$|_nickname$|dia_sub_group$|freq$)"

  # Process data in one pass
  cols <- list(
    name = grep(name_pattern, names(region_zhixiashi)),
    code = grep(code_pattern, names(region_zhixiashi)),
    sname = grep(sname_pattern, names(region_zhixiashi))
  )

  # Create replacement matrices efficiently
  for (type in names(cols)) {
    col_names <- names(region_zhixiashi)[cols[[type]]]
    replacement_data <- matrix(
      rep(region_zhixiashi[[paste0("prov_", type)]], length(col_names)),
      ncol = length(col_names)
    )
    region_zhixiashi[col_names] <- as.data.frame(replacement_data)
  }

  # Combine and return results
  region_zhixiashi <- unique(region_zhixiashi[order(names(region_zhixiashi))])
  region_province <- unique(region_data[!grepl(exclude_pattern, names(region_data))])

  rbind(region_zhixiashi, region_province[order(names(region_province))])
}

# Helper function for pinyin conversion
convert_to_pinyin <- function(data) {
  special_cases <- c(
    "\u9655\u897f" = "shaan_xi",
    "\u5185\u8499" = "inner_mongolia",
    "\u897f\u85cf" = "tibet",
    "\u6fb3\u95e8" = "macao",
    "\u9999\u6e2f" = "hong_kong"
  )
  first_two_chars <- substr(data, 1, 2)
  special_pinyin <- special_cases[first_two_chars]

  ifelse(
    is.na(special_pinyin),
    py(first_two_chars, dic = pydic(method = "toneless", dic = "pinyin2")),
    special_pinyin
  )
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
