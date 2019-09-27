
#' Download "TWDB" Well Metadata
#'
#' @return sf
#' @export
#'
download_well_meta <- function() {
  ## downloads geojson and returns a sf tibble
  url <- "https://www.waterdatafortexas.org"
  path <- paste0("groundwater/wells.geojson")

  content <- get_download(url, path, accept = "json")
  content <- sf::read_sf(content)
  return(content)
}



