
#' Download "TWDB" Individual Well Data
#'
#' @param state_well_nmbr required character. State well number.
#'
#' @return dataframe
#' @export
#'
download_well <- function(state_well_nmbr) {

  # check for valid arguments
  if(!is.character(state_well_nmbr)) {
    stop("`state_well_nmbr` must be a character object type")
  }

  url <- "https://www.waterdatafortexas.org"
  path <- paste0("groundwater/well/", state_well_nmbr, ".csv")

  content <- get_reservoirs(url = url,
                            path = path)

  writeLines(content)

  df <- readr::read_csv(content,
                        comment = "#")
}
