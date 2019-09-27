#' Download 'TWDB' Coastal Geographic Boundaries
#'
#' @param type character, required. One of \code{c("basin", "bay", "estuary",
#'   "sub_watershed", "watershed")}
#'
#' @return sf
#' @export
#'
download_coastal_geometry <- function(type) {
  url <- sprintf("https://waterdatafortexas.org/coastal/api/geometries/%s",
                 type)

  ## extra data in the geojson, need to figure out how to get the data
  ## into the sf

  content <- get_download(url,
                          path = NULL,
                          accept = "json")
  return(content)
}
