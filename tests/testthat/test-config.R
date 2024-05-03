describe("project_options", {
  it("creates a project_options object", {
    dir <- create_local_project()
    print(dir)
    options <- project_options(setup = TRUE)
    expect_s3_class(options, "glades")
  })
  it("setup=TRUE creates the directory structure", {
    dir <- create_local_project()
    options <- project_options(setup = TRUE)
    expect_true(all(
      dir.exists(paths = c(
        dir,
        options$raw_base_dir,
        options$interim_base_dir,
        options$processed_base_dir
      ))
    ))
  })
})
