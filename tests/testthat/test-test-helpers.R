describe("create_test_files_spatial works", {
  dir <- set_test_project(dir = testthat::test_path("test-project"))
  objects <- create_test_files(
    dir = "."
  )

  it("creates all specified test spatial files", {
    expect_true(file.exists(
      file.path("data/raw/test-raster.tif")
    ))
    expect_true(file.exists(
      file.path("data/raw/test-vector.json")
    ))
    expect_true(file.exists(
      file.path("data/raw/test-points.json")
    ))
  })

  it("returns a list of the correct spatial objects", {
    expect_length(objects, 4)
    expect_true(inherits(objects, "list"))
    expect_s4_class(objects[[1]], "SpatRaster")
    expect_s4_class(objects[[2]], "SpatVector")
    expect_s4_class(objects[[3]], "SpatVector")
  })
})

describe("set_test_project works", {
  it("sets the working dir  to 'test-project' within the current scope", {
    dir <- set_test_project(dir = testthat::test_path("test-project"))
    expect_equal(testthat::test_path("test-project"), dir)
  })
  it("resets the working directory to the original after scope", {
    expect_true(testthat::test_path() == ".")
  })
  it("allows imports and side effects with test project as root directory", {
    dir <- set_test_project(dir = testthat::test_path("test-project"))
    config <- import_options("./config.json", setup = FALSE)
    objects <- create_test_files(dir = ".")
    expect_length(objects, 4)
  })
})
