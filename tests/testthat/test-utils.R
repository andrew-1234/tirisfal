describe("create_test_files", {
  set_test_project(dir = testthat::test_path("test-project"))
  dir <- "."
  it("create_test_files creates test files", {
    create_test_files(dir = dir)
    expect_true(all(
      c(
        "test-raster.tif",
        "test-vector.json",
        "test-points.json",
        "test-df.csv"
      ) %in% fs::dir_tree(dir)
    ))
  })
})
