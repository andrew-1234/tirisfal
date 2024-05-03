resample_method <- function(raster_list) {
  resample_method_list <- lapply(raster_list$types, function(x) {
    if (x == "categorical") {
      return("near")
    } else {
      return("bilinear")
    }
  })
  return(resample_method_list)
}

raster_resample <- function(rasters, resample_method_list, base_layer) {
  future::plan("multicore", workers = 4)

  furrr::future_map2(
    rasters, resample_method_list, function(.x, .y) {
      rast_resampled <- terra::resample(.x, base_layer,
        method = .y,
        filename = paste0(basename(terra::sources(.x)), "_resampled.tif"),
        overwrite = TRUE
      )
    }
  )
  future::plan("sequential")
  rasters_resampled <- list.files(
    pattern = "_resampled.tif",
    full.names = TRUE
  )
}
