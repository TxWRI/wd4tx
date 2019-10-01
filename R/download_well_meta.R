
#' Download "TWDB" Well Metadata
#'
#' @param opts list of curl options passed to crul::HttpClient()
#' @return sf
#' @export
#'
download_well_meta <- function(opts = list()) {
  ## downloads geojson and returns a sf tibble
  url <- "https://www.waterdatafortexas.org"
  path <- paste0("groundwater/wells.geojson")

  content <- get_download(url,
                          path,
                          accept = "json",
                          opts = opts)
  attr.url <- attr(content, 'url')

  content <- sf::read_sf(content)
  attr(content, 'url') <- attr.url

  return(content)
}



