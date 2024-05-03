#' Project options S3 object
#'
#' @export
project_options <- function(raw = "./data/raw",
                            interim = "./data/interim",
                            processed = "./outputs/processed",
                            setup = FALSE) {
  stopifnot(
    is.character(raw),
    is.character(interim),
    is.character(processed)
  )

  options <- list(
    raw_base_dir = raw,
    interim_base_dir = interim,
    processed_base_dir = processed,
    collection = list()
  )

  options <- structure(options, class = "glades")

  if (setup) {
    setup(options)
  }

  stopifnot(
    dir.exists(options$raw_base_dir),
    dir.exists(options$interim_base_dir),
    dir.exists(options$processed_base_dir)
  )

  return(options)
}

#' @export
setup <- function(x, ...) {
  UseMethod("setup")
}

#' Set up a default project structure
#' @keywords internal
#' @export
setup.glades <- function(options) {
  # Create directories
  fs::dir_create(options$raw_base_dir)
  fs::dir_create(options$interim_base_dir)
  fs::dir_create(options$processed_base_dir)
}

#' Print method for project_options
#'
#' @export
print.glades <- function(x, ...) {
  simple_H2("Project options:\n")
  items <- c(
    "> Raw data base dir",
    "> Interim base dir", "> Processed base dir"
  )
  definitions <- c(x$raw_base_dir, x$interim_base_dir, x$processed_base_dir)
  create_aligned_prompt(items, definitions)
  cat("\n")
  cat("---------------\n")
  str(x)
}

#' @export
create_items <- function(name, path, ...) {
  stopifnot(is.character(name))
  stopifnot(is.character(path))
  stopifnot(length(name) == length(path))
  additional_items <- list(...)
  if (length(additional_items) > 0) {
    stopifnot(!is.null(names(additional_items)))
    stopifnot(all(nchar(names(additional_items)) > 0))
  }

  named_list <- lapply(seq_along(name), function(i) {
    sublist <- c(
      list(path = path[i]),
      lapply(additional_items, function(x) x[i])
    )
    setNames(list(sublist), name[i])
  })
  unlisted <- unlist(named_list, recursive = FALSE)
  return(structure(unlisted, class = "items"))
}

#' @export
collect <- function(x, ...) {
  UseMethod("collect")
}

#' @export
collect.glades <- function(x, items) {
  stopifnot(inherits(items, "items"))
  for (item_name in names(items)) {
    # if item name already exists
    if (item_name %in% names(x$collection)) {
      cat("item name already exists in collection; skipping\n")
      next
    }
    x$collection[[item_name]] <- items[[item_name]]
  }
  # return(structure(x, class = "glades"))
  return(x)
}
