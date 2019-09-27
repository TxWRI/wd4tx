
#' Download 'TWDB' Historical Bay and Estuary Freshwater Inflow Data
#'
#' @param geoid character, required.
#' @param resample character, optional. By default, data is returned in daily
#'   interval. Specify one of \code{c("month", "year")} to get monthly or yearly
#'   summed values.
#'
#' @return
#' @export
#'
#' @examples
download_coastal_hydrology <- function(geoid, resample = NULL) {

  url <- sprintf("https://waterdatafortexas.org/coastal/api/hydrology/%s/timeseries",
                 geoid)
  path = NULL
  if(is.null(resample)) args = list()
  else args = list(resample = resample)

  ## download
  content <- get_download(url, path, args = args, accept = "json")

  ## parse the returned json
  content <- jsonlite::fromJSON(content)

  ## return as tibble (need to specify column types)
  content <- tibble::as_tibble(content)
}
