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
  # options <- normalise_dir_paths(options)
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

#' Import complete project options config from a json file
#' @export
import_options <- function(file, setup = FALSE) {
  stopifnot(is.character(file))
  stopifnot(file.exists(file))

  options <- jsonlite::fromJSON(file)

  stopifnot(
    "raw_base_dir" %in% names(options),
    "interim_base_dir" %in% names(options),
    "processed_base_dir" %in% names(options)
  )
  if (setup) {
    setup(options)
  }
  validate_paths(options)

  stopifnot("collection" %in% names(options))
  if (length(options$collection) > 0) {
    stopifnot(
      all(
        sapply(options$collection, function(x) "path" %in% names(x))
      )
    )
  }
  options <- structure(options, class = "glades")
  # options <- normalise_dir_paths(options)
  # options <- normalise_collection_paths(options)
  return(options)
}

validate_paths <- function(x) {
  stopifnot(
    dir.exists(x$raw_base_dir),
    dir.exists(x$interim_base_dir),
    dir.exists(x$processed_base_dir)
  )
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

#' Create a collection of items manually
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

#' Import *only* the collection options from a  json config file
#' @export
import_items <- function(file) {
  stopifnot(is.character(file))
  stopifnot(file.exists(file))
  items <- jsonlite::fromJSON(file)
  return(structure(items, class = "json_items"))
}

#' Collect items into a glades object
#' @export
collect <- function(x, ...) {
  UseMethod("collect")
}

#' @export
collect.json_items <- function(items, glades) {
  stopifnot(inherits(glades, "glades"))
  items <- structure(items$collection, class = "items")
  collect(items, glades)
}

#' @export
collect.items <- function(items, glades) {
  stopifnot(inherits(glades, "glades"))
  for (item_name in names(items)) {
    # if item name already exists
    if (item_name %in% names(glades$collection)) {
      cat("item name already exists in collection; skipping\n")
      next
    }
    glades$collection[[item_name]] <- items[[item_name]]
  }
  # return(structure(x, class = "glades"))
  return(glades)
}

#' Validate item paths
#' @export
validate_items <- function(x) {
  stopifnot(inherits(x, "glades"))
  stopifnot(all(
    sapply(x$collection, function(item) {
      file.exists(item$path)
    })
  ))
  return(x)
}

normalise_dir_paths <- function(x) {
  stopifnot(inherits(x, "glades"))
  x$raw_base_dir <- here::here(x$raw_base_dir)
  x$interim_base_dir <- here::here(x$interim_base_dir)
  x$processed_base_dir <- here::here(x$processed_base_dir)
  return(x)
}

normalise_collection_paths <- function(x) {
  stopifnot(inherits(x, "glades"))
  for (i in seq_along(x$collection)) {
    x$collection[[i]]$path <- here::here(x$collection[[i]]$path)
  }
  return(x)
}
