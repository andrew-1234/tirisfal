describe("utils", {
  dir <- create_local_project()
  it("make_raster creates a raster", {
    r <- make_raster(file.path(dir, "test-raster.tif"))
    expect_s4_class(r, "SpatRaster")
    expect_true(file.exists(file.path(dir, "test-raster.tif")))
  })
  it("make_data_frame creates a data frame", {
    df <- make_data_frame(file.path(dir, "test-df.csv"))
    expect_true(file.exists(file.path(dir, "test-df.csv")))
    expect_true(is.data.frame(df))
    print(df)
  })
})
