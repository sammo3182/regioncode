# Fix script for v0.2.2 — addresses issues #55 and #51
# Run from package root: Rscript dev/fix_v0.2.2.R

load("R/sysdata.rda")

# ---- Fix #55: Danzhou region code (2015 upgrade to prefecture-level city) ----
# Note: data uses U+512B (not the standard U+5110 "儋") — visually identical
dan_idx <- which(region_data$prov_code == 460000 &
                 region_data$`2022_code` == 469003)
stopifnot(length(dan_idx) == 1)
cat("Danzhou row index:", dan_idx, "\n")

years_to_fix <- 2015:2022
for (y in years_to_fix) {
  col <- paste0(y, "_code")
  old <- region_data[[col]][dan_idx]
  region_data[[col]][dan_idx] <- 460400
  cat(sprintf("%s: %s -> 460400\n", col, old))
}

# ---- Fix #51: rename cityranking columns to follow _rank convention ----
rename_map <- c(
  "2020_cityranking" = "2020_rank",
  "2021_cityrankin"  = "2021_rank",
  "2022_cityranking" = "2022_rank"
)
nm <- names(region_data)
for (old_n in names(rename_map)) {
  pos <- which(nm == old_n)
  if (length(pos) == 1) {
    nm[pos] <- rename_map[[old_n]]
    cat(sprintf("renamed: %s -> %s\n", old_n, rename_map[[old_n]]))
  } else {
    cat(sprintf("WARN: column %s not found\n", old_n))
  }
}
names(region_data) <- nm

# ---- Save ----
save(region_data, corruption, pinyin_lookup,
     file = "R/sysdata.rda", compress = "xz")
cat("\nsysdata.rda saved.\n")
