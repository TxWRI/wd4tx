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
                            select(-c(geometry, properties))) %>%
    mutate(geometry = st_as_sfc(content, GeoJSON = TRUE)) %>%
    st_as_sf()

  return(sf_content)
}
