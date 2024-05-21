describe("create_test_files", {
  set_test_project(dir = testthat::test_path("test-project"))
  dir <- "."
  test_files <- create_test_files(dir = dir)
  it("create_test_files creates test files", {
    expect_true(all(
      c(
        "test-raster.tif",
        "test-vector.json",
        "test-points.json",
        "test-df.csv"
      ) %in% fs::dir_tree(dir)
    ))
  })
  it("returns a list of the correct spatial objects", {
    expect_length(test_files, 4)
    expect_true(inherits(test_files, "list"))
    expect_s4_class(test_files[[1]], "SpatRaster")
    expect_s4_class(test_files[[2]], "SpatVector")
    expect_s4_class(test_files[[3]], "SpatVector")
  })
})
