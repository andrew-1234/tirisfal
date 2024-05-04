describe("craft-items", {
  dir <- set_test_project(dir = testthat::test_path("test-project"))
  config <- import_options("./config.json", setup = FALSE)
  objects <- create_test_files(dir = ".")

  it("crafts the data.frame into the slot frog_data$object", {
    config <- craft_items(config)
    print(config)
    expect_true(is.data.frame(config$collection$frog_data$object))
    expect_equal(nrow(config$collection$frog_data$object), 10)
  })
})
