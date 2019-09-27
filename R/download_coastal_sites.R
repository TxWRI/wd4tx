
#' Download 'TWDB' Coastal Station Information
#'
#' @param all_stations logical. Defaults is FALSE. If FALSE, returns all
#'   stations for which actual data is available. If TRUE, returns all stations
#'   regardless of data availability.
#'
#' @return tibble
#' @export
download_coastal_sites <- function(all_stations = FALSE) {
  url <- "https://www.waterdatafortexas.org/coastal/api/stations"
  path <- NULL

  if(isTRUE(all_stations))
    args = list(all = "true")
  else args = list(all = "false")

  ## download
  content <- get_download(url, path, args, accept = "json")

  ## parse the returned json
  content <- jsonlite::fromJSON(content)

  ## return as tibble
  content <- tibble::as_tibble(content)

  return(content)
  }
