# function to make the http request

get_reservoirs_temp <- function(url,
                           path,
                           args = list(),
                           ...) {
  cli <- crul::HttpClient$new(
    url = url,
    headers = list(Accept = "text/csv")
  )

  res <- cli$get(path)
  print(res$url)

  if(res$status_code != 200) {
    stop(paste0("Server returned: "), res$response_headers$status)
  }

  content <- res$parse("UTF-8")

  return(content)
}

downloaded <- get_reservoirs_temp(url = "https://www.waterdatafortexas.org",
                                  path = "reservoirs/municipal/austin-30day.csv")







df <- readr::read_csv(content)
content
writeLines(content)

c <- strsplit(content, "\n")

df <- download_reservoir(aggregate_by = "basin", region_name = "brazos", period = "30-day")

df <- download_well("5862208")

df <- download_well_meta()
 sf::st_as_sfc(df, GeoJSON = TRUE)

writeLines(df)
sf::read_sf(df)
