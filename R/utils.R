#' Make a small raster with epsg 4326
make_raster <- function(path) {
  r <- terra::rast(nrow = 10, ncol = 10)
  terra::values(r) <- runif(terra::ncell(r))
  terra::crs(r) <- "epsg:4326"

  if (!missing(path)) {
    terra::writeRaster(r, path)
  }
  return(r)
}

# Make a small polygon shape that will overlay the raster
make_vector <- function(path) {
  v <- terra::vect(
    "POLYGON ((0.2 0.1, 0.2 0.3 , 0.1 0.5, 0.5 0.6, 0.6 0.4, 0.2 0.1))",
    crs = "epsg:4326"
  )
  if (!missing(path)) {
    terra::writeVector(v, path)
  }
  return(v)
}

# Make a five points
make_points <- function(path) {
  v <- terra::vect(cbind(runif(5), runif(5)), crs = "epsg:4326")
  if (!missing(path)) {
    terra::writeVector(v, path)
  }
  return(v)
}

make_data_frame <- function(path) {
  df <- data.frame(
    svl = round(runif(10, min = 2, max = 7), 2),
    weight = round(runif(10, min = 15, max = 30), 2),
    species = sample(c("A", "B"), size = 10, replace = TRUE)
  )
  if (!missing(path)) {
    write.csv(df, path)
  }
  return(df)
}
