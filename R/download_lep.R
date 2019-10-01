
#' Download 'TWDB' Lake Evaporation and Precipitation Data
#'
#' @param quad required character. TWDB quad number.
#' @param start_date required character. Start date of data. Specified as 4-digit year and 2-digit month. YYYY-MM
#' @param end_date required character. End date of data. Specified as 4-digit year and 2-digit month. YYYY-MM
#' @param opts list of curl options passed to crul::HttpClient()
#'
#' @return tibble
#' @export

download_lep <- function(quad = "710",
                         start_date = "2010-01",
                         end_date = "2018-12",
                         opts = list()) {

  # check for valid arguments
  if(!is.character(quad)) {
    stop("`quad` must be a character object type")
  }
  if(!is.character(start_date)) {
    stop("`start_date` must be a character object type formatted as Y-M")
  }
  if(!is.character(end_date)) {
    stop("`end_date` must be a character object type formatted as Y-M")
  }

  url <- "https://www.waterdatafortexas.org"
  path <- paste0("lake-evaporation-rainfall/api/quads/",
                 quad,
                 "/all?data_format=csv&start_date=",
                 start_date,
                 "&end_date=",
                 end_date)

  content <- get_download(url = url,
                          path = path,
                          accept = "csv",
                          opts = opts)
  attr.url <- attr(content, 'url')

  content <- readr::read_csv(content,
                        comment = "#")
  attr(content, 'url') <- attr.url

  return(content)
}


