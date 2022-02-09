#' HTTP Request Function
#'
#' Internal function for making http requests.
#' @param url character. Base url.
#' @param path character
#' @param args query argument list
#' @param accept character. One of \code{c("csv", "json")}
#' @param opts curl options to crul::HttpClient. Must be a list.
#'
#' @return Parsed json content or csv
#' @importFrom crul HttpClient
#' @keywords internal
#' @noRd
get_download <- function(url,
                    path,
                    args = list(),
                    accept = "csv",
                    opts = list()) {

  if(accept == "csv") {
    headers = list(Accept = "text/csv")
  } else {
    if(accept == "json") {
      headers = list(Accept = "application/json")
    }
  }

  cli <- crul::HttpClient$new(url = url,
                              headers = headers,
                              opts = opts)

  res <- cli$get(path,
                 query = args)

  errs(res)

  content <- res$parse("UTF-8")
  attr(content, 'url') <- res$url

  return(content)
}



#' Gracefully return http errors
#'
#' Internal function for returning http error message when making http requests.
#' @param x http request
#'
#' @return error message or nothing
#' @keywords internal
#' @noRd
#' @importFrom fauxpas find_error_class
errs <- function(x) {
  if (x$status_code > 201) {

    fun <- fauxpas::find_error_class(x$status_code)$new()
    fun$do_verbose(x)
  }
}
