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

      if (!is.na(year_to) && year_to < 1988) {
        data_input <- gsub("海南省", "广东省", data_input)
      }

      # 重庆市在1997年前属四川
      if (!is.na(year_to) && year_to < 1997) {
        data_input <- gsub("重庆市", "四川省", data_input)
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
