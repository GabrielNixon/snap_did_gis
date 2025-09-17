# ===========================
# SNAP APT extraction to CSVs
# From PDFs named 2012.pdf, 2013.pdf, …, 2019.pdf, 2022.pdf, 2023.pdf in ./data
# Outputs:
#   - outputs/tables/snap_timeliness_wide.csv      (50 states + DC)
# ===========================

# ---- Packages ----
need <- c("pdftools","stringr","dplyr","tibble","purrr","readr","tidyr","janitor")
new  <- need[!(need %in% installed.packages()[,"Package"])]
if (length(new)) install.packages(new, repos = "https://cloud.r-project.org")
invisible(lapply(need, library, character.only = TRUE))

dir.create("outputs/tables", recursive = TRUE, showWarnings = FALSE)
canon_states <- c(state.name, "District of Columbia", "Guam", "Virgin Islands")
lookup <- tibble(
  canon = canon_states,
  alt   = toupper(canon_states)
)

# Common PDF variants
variant_map <- tibble::tribble(
  ~alt,                  ~canon,
  "DIST. OF COL.",       "District of Columbia",
  "DIST OF COL",         "District of Columbia",
  "DISTRICT OF COLUMBIA","District of Columbia",
  "D.C.",                "District of Columbia",
  "DC",                  "District of Columbia",
  "VIRGIN ISLANDS",      "Virgin Islands",
  "GUAM",                "Guam"
)

lookup <- dplyr::bind_rows(lookup, variant_map)

alts_sorted <- lookup$alt[order(nchar(lookup$alt), decreasing = TRUE)]
state_pat   <- paste0("(?i)\\b(", paste(stringr::str_replace_all(alts_sorted, " ", "\\\\s+"), collapse="|"), ")\\b")
num_pat   <- "(\\d{1,3}(?:\\.\\d{1,2})?)%?"
full_pat  <- paste0(state_pat, "\\s+", num_pat)  

normalize_state <- function(x) {
  u <- toupper(stringr::str_squish(x))
  out <- tibble(alt = u) |>
    dplyr::left_join(lookup, by = "alt") |>
    dplyr::mutate(canon = dplyr::if_else(is.na(canon), stringr::str_to_title(alt), canon)) |>
    dplyr::pull(canon)
  out
}

extract_pdf <- function(file, year) {
  txt <- paste(pdftools::pdf_text(file), collapse = "\n")
  m   <- stringr::str_match_all(txt, full_pat)[[1]]
  if (is.null(m) || nrow(m) == 0) {
    warning("No matches in: ", basename(file))
    return(tibble::tibble(state = character(), rate = double(), year = integer()))
  }
  tibble(
    state_raw = m[,2],
    rate      = as.numeric(m[,3])
  ) |>
    dplyr::mutate(
      state = normalize_state(state_raw),
      year  = as.integer(year)
    ) |>
    dplyr::filter(state %in% canon_states) |>
    dplyr::group_by(state, year) |>
    dplyr::summarise(rate = mean(rate, na.rm = TRUE), .groups = "drop")
}

files <- list.files("data", pattern = "^\\d{4}\\.pdf$", full.names = TRUE)
stopifnot(length(files) > 0)
years <- as.integer(gsub("\\.pdf$", "", basename(files)))
empty_files <- character(0)
one <- function(f, y) {
  df <- extract_pdf(f, y)
  if (nrow(df) == 0) empty_files <<- c(empty_files, basename(f))
  df
}
all_data <- purrr::map2_dfr(files, years, one) |>
  dplyr::arrange(year, state)

wide_all <- all_data |>
  tidyr::pivot_wider(names_from = year, values_from = rate) |>
  dplyr::arrange(state)
wide_all <- wide_all[, c("state", sort(setdiff(names(wide_all), "state"), decreasing = TRUE))]
readr::write_csv(wide_all, "outputs/tables/snap_timeliness_wide_all.csv")

# ---- WIDE (USA only) ----
wide_usa <- all_usa |>
  tidyr::pivot_wider(names_from = year, values_from = rate) |>
  dplyr::arrange(state)
wide_usa <- wide_usa[, c("state", sort(setdiff(names(wide_usa), "state"), decreasing = TRUE))]
readr::write_csv(wide_usa, "outputs/tables/snap_timeliness_wide.csv")
