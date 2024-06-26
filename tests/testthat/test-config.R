describe("project_options", {
  # dir <- create_local_project()
  dir <- set_test_project(dir = testthat::test_path("test-project"))
  # create new folder and package
  options <- project_options(setup = TRUE)
  it("creates a valid project_options object", {
    expect_s3_class(options, "glades")
  })
  it("setup=TRUE creates the directory structure", {
    expect_true(all(
      dir.exists(paths = c(
        options$raw_base_dir,
        options$interim_base_dir,
        options$processed_base_dir
      ))
    ))
  })
})
