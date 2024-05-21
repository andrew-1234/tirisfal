initialise_items <- function(config) {
  stopifnot(inherits(config, "glades"))
  config$collection <- lapply(config$collection, function(x) {
    x[["object"]] <- read_switch(x$path)
    return(x)
  })
  return(config)
}

read_switch <- function(path) {
  stopifnot(file.exists(path))
  ext <- tools::file_ext(path)
  object <- switch(ext,
    "tif" = terra::rast(path),
    "json" = terra::vect(path),
    "csv" = readr::read_csv(path),
    stop("file extension not supported")
  )
  return(object)
}
