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
    dir = testthat::test_path("test-project"),
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
    vector <- terra::readVector(test_vector)
  }
  withr::defer(fs::file_delete(test_vector),
    envir = env
  )

  if (!file.exists(test_points)) {
    points <- make_points(test_points)
  } else {
    points <- terra::readVector(test_points)
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
