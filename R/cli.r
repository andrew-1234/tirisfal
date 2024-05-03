#' Print a title bar for cli
#' @noRd
#' @keywords internal
print_title_bar <- function(title) {
  cat(cli::bg_black(cli::col_green(
    paste(rep(" ", 80), collapse = "")
  )), "\n", sep = "")
  cat(cli::bg_black(cli::col_green(
    sprintf(" %-78s ", title)
  )), "\n", sep = "")
  cat(cli::bg_black(cli::col_green(
    paste(rep(" ", 80), collapse = "")
  )), "\n\n", sep = "")
}

#' Simple level one header
#' @noRd
#' @keywords internal
simple_H1 <- function(...) {
  tail <- 80 - nchar(paste(...))
  cat(cli::col_blue(
    "──", paste(...),
    paste(rep("─", tail), collapse = "")
  ), "\n", sep = "")
}
#' Simple level two header
#' @noRd
#' @keywords internal
simple_H2 <- function(...) {
  cat(cli::col_blue("── ", paste(...), "\n", sep = ""))
}

#' Create aligned prompt
#' @noRd
#' @keywords internal
create_aligned_prompt <- function(instruction, definition) {
  instruction <- as.character(instruction)
  definition <- as.character(definition)

  combined <- mapply(function(instr, def) {
    paste(instr, "::", def)
  }, instruction, definition, SIMPLIFY = FALSE)

  max_length <- max(nchar(sub(" ::.*", "", combined)))

  aligned_instruction <- sapply(combined, function(instr) {
    parts <- strsplit(instr, " ::")[[1]]
    sprintf("%-*s :: %s", max_length, parts[1], parts[2])
  }, USE.NAMES = FALSE)

  border_length <- max(nchar(aligned_instruction))
  border <- paste(rep("─", border_length), collapse = "")

  cat(
    "", border, "\n",
    paste0("", aligned_instruction, collapse = "\n "), "\n",
    border, "\n"
  )
}
