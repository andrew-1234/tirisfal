#' Create a list of raster files in the format required
#'
#' @param files named character vector; Raster file paths with names
#'  corresponding to the type of raster ("categorical" or "continuous"
#' @return A list with two elements: 'files' containing the file paths and
#' 'types' containing the names of the files.
#' @examples
#' files <- c("categorical" = "path/to/file1.tif")
#' rasters <- raster_make_list(files)
raster_make_list <- function(files) {
  list(files = unname(files), types = names(files))
}

#' Read a list of raster files

#' @param raster_list list;  list of raster files created by
#' \code{\link{raster_make_list}}
#' @return A list of spatRaster objects
#' @export
raster_read <- function(raster_list) {
  rasters <- lapply(raster_list$files, terra::rast)
  rasters
}
