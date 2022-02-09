#' Download 'TWDB' Coastal Geographic Boundaries
#'
#' @param type character, required. One of \code{c("basin", "bay", "estuary",
#'   "sub_watershed", "watershed")}
#' @param opts list of curl options passed to crul::HttpClient()
#'
#' @return simple features data_frame
#' @importFrom sf st_as_sfc
#' @importFrom sf st_as_sf
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr select mutate
#' @importFrom tibble as_tibble
#' @importFrom rlang .data
#' @export
#'
download_coastal_geometry <- function(type,
                                      opts = list()) {
  url <- sprintf("https://waterdatafortexas.org/coastal/api/geometries/%s",
                 type)

  ## extra data in the geojson, need to figure out how to get the data
  ## into the sf

  content <- get_download(url,
                          path = NULL,
                          accept = "json",
                          opts = opts)
  attr.url <- attr(content, 'url')

  ## parse the json
  parsed_content <- jsonlite::fromJSON(content)

  ## go from geojson to sf
  ## note to future self, read_sf returned the geometry and features
  ## but does not provide any fields.
  ## Instead, the following will pull the parsed features as a tibble,
  ## then I add the geometry column and coerce to sf

  ## also note, some topological errors in the source data cause issues when analyzing data
  ## be sure to document and provide an example

  sf_content <- as_tibble(parsed_content$features %>%
                            select(-c(.data$geometry, .data$properties))) %>%
    mutate(geometry = sf::st_as_sfc(content, GeoJSON = TRUE)) %>%
    sf::st_as_sf()

  attr(sf_content, 'url') <- attr.url

  return(sf_content)
}
