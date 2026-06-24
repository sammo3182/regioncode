#' `regioncode` is developed to conquer the difficulties to convert various region names and administration division codes of Chinese regions. In the current version, `regioncode` enables seamlessly converting Chinese regions' formal names, common-used names, and geocodes between each other at the prefectural level from 1986 to 2022.
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

  # `region_data` and `pinyin_lookup` are internal lookup tables (see data-raw/).
  is_code <- is.numeric(data_input)

  if (province) {
    # 1 Province-level conversion (municipalities never apply here)
    zhixiashi <- FALSE

    if (to_dialect != "none") {
      # 1-1 Language zone (only `dia_super` is valid at this level)
      from_col <- if (is_code) "prov_code" else "prov_name"
      to_col <- "prov_language"
    } else {
      # 1-2 Names, codes, areas, and abbreviations
      # Province nicknames changed in 1999, so pick the matching column.
      year_num <- if (as.numeric(year_from) < 1999) 1998 else 1999
      nickname_col <- paste0(year_num, "_nickname")

      # Regions that did not yet exist as provinces in the target year
      if (!is.na(year_to) && year_to < 1988) {
        data_input <- gsub("\u6d77\u5357\u7701", "\u5e7f\u4e1c\u7701", data_input)
      }
      if (!is.na(year_to) && year_to < 1997) {
        data_input <- gsub("\u91cd\u5e86\u5e02", "\u56db\u5ddd\u7701", data_input)
      }

      from_col <- if (is_code) "prov_code" else "prov_name"
      to_col <- switch(convert_to,
        "name" = "prov_name",
        "code" = "prov_code",
        "area" = "area",
        "nameToabbre" = { from_col <- "prov_name"; nickname_col },
        "codeToabbre" = { from_col <- "prov_code"; nickname_col },
        "abbreToname" = { from_col <- nickname_col; "prov_name" },
        "abbreTocode" = { from_col <- nickname_col; "prov_code" },
        "abbreToarea" = { from_col <- nickname_col; "area" }
      )
    }
  } else {
    # 2 Prefecture-level conversion
    from_col <- if (is_code) paste0(year_from, "_code") else paste0(year_from, "_name")

    if (to_dialect != "none") {
      # 2-1 Language zone
      to_col <- if (to_dialect == "dia_group") "pref_language_all" else "dia_sub_language_all"
    } else {
      # 2-2 Names, codes, areas, and ranks
      region_data <- region_data[!duplicated(region_data$`2019_code`), ]

      to_col <- switch(convert_to,
        "code" = paste0(year_to, "_code"),
        "area" = "area",
        "name" = paste0(year_to, "_name"),
        "rank" = paste0(year_to, "_rank")
      )

      # Treat municipalities as prefectures by giving them provincial codes/names
      if (zhixiashi) {
        region_data <- expand_zhixiashi(region_data)
      }
    }
  }

  # Resolve which columns to match on / read from. With `incomplete_name`,
  # swap a name column for its short-name (`_sname`) counterpart.
  if (incomplete_name %in% c("from", "both") && grepl("_name$", from_col)) {
    from_col <- sub("_name$", "_sname", from_col)
  }
  if (incomplete_name %in% c("to", "both") && grepl("_name$", to_col)) {
    to_col <- sub("_name$", "_sname", to_col)
  }

  # The first matching row wins, mirroring a left join on `from_col`.
  data_output <- region_data[[to_col]][match(data_input, region_data[[from_col]])]

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

  data_output
}

# Rebuild the lookup table so that municipalities ("\u76f4\u8f96\u5e02") carry
# their provincial names and codes across every year, then stack them back with
# the rest of the regions. Used when `zhixiashi = TRUE`.
expand_zhixiashi <- function(region_data) {
  drop_pattern <- "language$|_all$|_nickname$|dia_sub_group$|freq$"
  region_zhixiashi <- region_data[region_data$zhixiashi %in% TRUE, ]

  # Columns to overwrite with the provincial value, and the value to use
  replace_map <- list(
    "_name$" = region_zhixiashi$prov_name,
    "_sname$" = region_zhixiashi$prov_sname,
    "_code$" = region_zhixiashi$prov_code
  )
  for (pattern in names(replace_map)) {
    cols <- grep(pattern, names(region_zhixiashi), value = TRUE)
    region_zhixiashi[cols] <- replace_map[[pattern]]
  }

  region_zhixiashi <- region_zhixiashi[!grepl(drop_pattern, names(region_zhixiashi))]
  region_zhixiashi <- unique(region_zhixiashi[order(names(region_zhixiashi))])

  region_province <- unique(region_data[!grepl(drop_pattern, names(region_data))])
  region_province <- region_province[order(names(region_province))]

  rbind(region_zhixiashi, region_province)
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
