# function to make the http request for csv downloads
get_download <- function(url,
                    path,
                    args = list(),
                    accept = "csv",
                    ...) {

  if(accept == "csv") {
    headers = list(Accept = "text/csv")
  } else {
    if(accept == "json") {
      headers = list(Accept = "application/json")
    }
  }

  cli <- crul::HttpClient$new(url = url,
                              headers = headers)

  res <- cli$get(path)

  errs(res)

  content <- res$parse("UTF-8")

  return(content)
}



# return http errors gracefully
errs <- function(x) {
  if (x$status_code > 201) {

    fun <- fauxpas::find_error_class(x$status_code)$new()
    fun$do_verbose(x)
  }
}
