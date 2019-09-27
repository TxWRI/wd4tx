
#' Download "TWDB" Reservoir Data
#'
#' @param aggregate_by optional character. One of \code{c("statewide", "planning
#'   region", "basin", "municipal", "climate region")}. Defaults to \code{NULL}.
#' @param region_name optional character. Documentation comming soon.
#' @param reservoir optional character. Documentation soon.
#' @param period optional character. Documentation soon
#'
#' @return dataframe
#' @import crul
#' @export
#'
download_reservoir <- function(aggregate_by = NULL,
                               region_name = NULL,
                               reservoir = NULL,
                               period = "historical") {
  ## allowable aggregate_by
  ab = c("statewide",
         "planning region",
         "basin",
         "municipal",
         "climate region",
         "NULL")

  ## allowable time
  t = c("historical", "1-yr", "30-day")

  ## check for argument error
  check_arguments_download_reservoir(aggregate_by, region_name, reservoir, period, ab, t)


  ## create the call for reservoirs
  if(!is.null(reservoir)) {
    call <- paste0("individual/", reservoir)
  }


  ## create the call for aggregated regions
  if(!is.null(aggregate_by)) {
    if(identical(aggregate_by, "statewide")) {
      call <- paste0("statewide/")
    }

    else {
      if(identical(aggregate_by, "planning region")) {
        call <- paste0("region/")
      }

      else {
        if(identical(aggregate_by, "basin")) {
          call <- paste0("basin/")
        }

        else {
          if(identical(aggregate_by, "municipal")) {
            call <- paste0("municipal/")
          }

          else {
            if(identical(aggregate_by, "climate region")) {
              call <- paste0("climate/")
            }
          }
        }
      }
    }
  }

  ## add the region name to the call
  if(!is.null(aggregate_by)) {
    if(is.null(region_name)) {
      stop("`region_name` must be a non-null character object if the `aggregate_by` argument is specified")
    }
    else {
      call <- paste0(call, region_name)
      }
  }

  ## add the time period to the call
  if(identical(period, "historical")) {
    call <- paste0(call, ".csv")
  }

  else {
    if(identical(period, "1-yr")) {
      call <- paste0(call, "-1year.csv")
    }

    else{
      call <- paste0(call, "-30day.csv")
    }
  }

  ## make the http request

  url <- "https://www.waterdatafortexas.org"
  path <- paste0("reservoirs/", call)

  content <- get_download(url = url,
                          path = path,
                          accept = "csv")

  df <- readr::read_csv(content,
                        comment = "#",
                        col_types = "Dddddddd")

  ## Note for future: I'd like to extract the commented metadata.
  ## However, it is only sometimes returned in the parsed csv.
  ## It might be worth attaching attrs to the tibble:
  ## url, date, and other pertainent data returned by crul

  return(df)

}




# Check for argument errors in `download_reservoir()`

check_arguments_download_reservoir <- function(aggregate_by,
                                                region_name,
                                                reservoir,
                                                period,
                                                ab,
                                                t) {
  # If aggregate_by = NULL, resevoir must be character object
  # If aggregate_by is a character object, resevoir should be NULL
  if (is.null(aggregate_by)) {
    if (is.null(reservoir)) {
      stop("aggregate_by and reservoir cannot both = NULL",
           call. = FALSE)
    }
    if (!is.character(reservoir)) {
      stop("reservoir must be a character object type",
           call. = FALSE)
    }
  }

  if(!is.null(aggregate_by)) {
    if(!is.null(reservoir)) {
      stop("one of 'aggregate_by' or 'reservoir' must be NULL",
           call. = FALSE)
    }
  }


  if (!is.null(aggregate_by)) {
    if (!(aggregate_by %in% ab)) {
      stop(paste(
        "aggregate_by must be one of the following character objects:",
        paste(sprintf("`%s`", ab), collapse = ", ")),
        call. = FALSE)
    }

    if (identical(aggregate_by, "statewide")) {
      if (identical(region_name, "statewide")) {
        stop("Use `region_name = NULL` when using `aggregate_by = 'statewide'`",
             call. = FALSE)
      }
    }
  }

  # Check if time is specified correctly
  if (!(period %in% t)) {
    stop(paste(
      "time must one of the following character objects:",
      paste(sprintf("`%s`", t), collapse = ", ")),
      call. = FALSE)
  }
}



