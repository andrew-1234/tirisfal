describe("initialise-items", {
  # hello <- set_test_project(dir = testthat::test_path("test-project"))
  test_dir <- getwd()
  setwd(testthat::test_path("test-project"))
  withr::defer(setwd(test_dir), envir = parent.frame())

  it("initialises the data.frame into the slot frog_data$object", {
    config <- import_options("config.json", setup = FALSE)
    objects <- create_test_files(".")
    config <- initialise_items(config)
    expect_true(is.data.frame(config$collection$frog_data$object))
    expect_equal(nrow(config$collection$frog_data$object), 10)
  })
})
