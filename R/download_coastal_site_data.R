
#' Download 'TWDB' Coastal Measurement Data
#'
#' @param station character, required.
#' @param parameter character, required.
#' @param start_date character, required. Format must be \code{yyyy-mm-dd}.
#' @param end_date character, required. Format must be \code{yyyy-mm-dd}.
#' @param binning character. One of \code{"mon", "day", "hour"}. Default is
#'   \code{"day"}
#' @param opts list of curl options passed to crul::HttpClient()
#'
#' @return tibble
#' @export
#'
#' @examples download_coastal_site_data(station = "MIDG", parameter =
#'   "seawater_salinity", start_date = "2010-01-01", end_date = "2010-12-31",
#'   bin = "hour")
download_coastal_site_data <- function(station,
                                       parameter,
                                       start_date,
                                       end_date,
                                       binning = "day",
                                       opts = list()) {


  url <- sprintf("https://waterdatafortexas.org/coastal/api/stations/%s/data/%s",
                 station, parameter)
  path = NULL
  args = list(start_date = start_date,
              end_date = end_date,
              binning = binning)

  ## download
  content <- get_download(url,
                          path,
                          args = args,
                          accept = "json",
                          opts = opts)
  attr.url <- attr(content, 'url')

  ## parse the returned json
  content <- jsonlite::fromJSON(content)

  ## return as tibble
  content <- tibble::as_tibble(content)
  attr(content, 'url') <- attr.url

  return(content)
}
