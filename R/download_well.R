
#' Download "TWDB" Individual Well Data
#'
#' @param state_well_nmbr required character. State well number.
#' @param opts list of curl options passed to crul::HttpClient()
#'
#' @return dataframe
#' @export
#'
download_well <- function(state_well_nmbr,
                          opts = list()) {

  # check for valid arguments
  if(!is.character(state_well_nmbr)) {
    stop("`state_well_nmbr` must be a character object type")
  }

  url <- "https://www.waterdatafortexas.org"
  path <- paste0("groundwater/well/", state_well_nmbr, ".csv")

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
