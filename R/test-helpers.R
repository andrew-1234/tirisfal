# Or use test_path()
create_local_project <- function(dir = tempdir(), env = parent.frame()) {
  test_dir <- getwd()
  # create new folder and package
  if (!dir.exists(dir)) fs::dir_create(dir)
  withr::defer(fs::dir_delete(dir), envir = env) # -A

  # change working directory
  setwd(dir) # B
  withr::defer(setwd(test_dir), envir = env) # -B

  dir
}

set_test_project <- function(
    dir,
    env = parent.frame()) {
  test_dir <- getwd()

  setwd(dir)
  withr::defer(setwd(test_dir), envir = env)
  dir
}

# Create test files for spatial data
create_test_files <- function(
    dir = ".",
    env = parent.frame()) {
  raw_path <- file.path(dir, "data/raw")
  test_raster <- file.path(raw_path, "test-raster.tif")
  test_vector <- file.path(raw_path, "test-vector.json")
  test_points <- file.path(raw_path, "test-points.json")
  test_data_frame <- file.path(raw_path, "test-df.csv")

  if (!file.exists(test_raster)) {
    raster <- make_raster(test_raster)
  } else {
    raster <- terra::rast(test_raster)
  }
  withr::defer(fs::file_delete(test_raster),
    envir = env
  )

  if (!file.exists(test_vector)) {
    vector <- make_vector(test_vector)
  } else {
    vector <- terra::vect(test_vector)
  }
  withr::defer(fs::file_delete(test_vector),
    envir = env
  )

  if (!file.exists(test_points)) {
    points <- make_points(test_points)
  } else {
    points <- terra::vect(test_points)
  }
  withr::defer(fs::file_delete(test_points),
    envir = env
  )

  if (!file.exists(test_data_frame)) {
    frog_data <- make_data_frame(test_data_frame)
  } else {
    frog_data <- readr::read_csv(test_data_frame)
  }
  withr::defer(fs::file_delete(test_data_frame),
    envir = env
  )
  return(list(raster, vector, points, frog_data))
}

#' Make a small raster with epsg 4326
make_raster <- function(path) {
  r <- terra::rast(nrow = 10, ncol = 10)
  terra::values(r) <- runif(terra::ncell(r))
  terra::crs(r) <- "epsg:4326"

  if (!missing(path)) {
    terra::writeRaster(r, path, overwrite = TRUE)
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
    terra::writeVector(v, path, overwrite = TRUE)
  }
  return(v)
}

# Make a five points
make_points <- function(path) {
  v <- terra::vect(cbind(runif(5), runif(5)), crs = "epsg:4326")
  if (!missing(path)) {
    terra::writeVector(v, path, overwrite = TRUE)
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
    write.csv(df, path, row.names = FALSE)
  }
  return(df)
}
