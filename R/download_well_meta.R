
#' Download "TWDB" Well Metadata
#'
#' @return sf
#' @export
#'
download_well_meta <- function() {
  ## downloads geojson and returns a sf tibble
  url <- "https://www.waterdatafortexas.org"
  path <- paste0("groundwater/wells.geojson")

  content <- get_well_meta(url, path)
  return(content)
}


get_well_meta <- function(url,
                           path,
                           args = list(),
                           ...) {
  cli <- crul::HttpClient$new(
    url = url,
    headers = list(Accept = "application/json")
  )

  res <- cli$get(path)
  print(res$url)

  if(res$status_code != 200) {
    stop(paste0("Server returned: "), res$response_headers$status)
  }

  content <- res$parse("UTF-8")

  content <- sf::read_sf(content)

  return(content)
}
