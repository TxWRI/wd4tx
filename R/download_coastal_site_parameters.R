
#' Download 'TWDB' Coastal Station Parameters
#'
#' @param station character, required.
#'
#' @return tibble
#' @export
#'
download_coastal_site_parameters <- function(station) {
  if(!is.character(station)) {
    stop("'station' must be a character object")
  }

  url <- sprintf("https://waterdatafortexas.org/coastal/api/stations/%s/parameters",
                 station)
  path <- NULL
  ## download
  content <- get_download(url, path, accept = "json")

  ## parse the returned json
  content <- jsonlite::fromJSON(content)

  ## return as tibble
  content <- tibble::as_tibble(content)

  return(content)

}
