create_local_project <- function(dir = tempdir(), env = parent.frame()) {
  test_dir <- getwd()
  # create new folder and package
  if (!dir.exists(dir)) fs::dir_create(dir)
  withr::defer(fs::dir_delete(dir), envir = env) # -A

  # change working directory
  setwd(dir) # B
  withr::defer(setwd(test_dir), envir = env) # -B

  dir
}
