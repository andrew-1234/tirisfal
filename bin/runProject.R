args <- commandArgs(trailingOnly = TRUE)

fullAnalysis <- FALSE

if (length(args) > 0) {
  if ("--fullAnalysis=TRUE" %in% args) {
    cat("Performing full analysis...\n")
    fullAnalysis <- TRUE
  } else if ("--fullAnalysis=FALSE" %in% args) {
    cat("Using cached data...\n")
  } else {
    cat("\nUnknown or incorrectly specified arguments: \n\n", args, "\n\n")
    cat("-  Use --fullAnalysis=TRUE to perform a full analysis", "\n")
    cat(
      "-  Use --fullAnalysis=FALSE, or run without args, to use cached data",
      "\n\n"
    )
    stop()
  }
} else {
  cat("Using cached data...\n")
}

rmarkdown::render("reports/report.rmd", params = list(
  fullAnalysis = fullAnalysis
))

# render_report <- function(region, year) {
#   rmarkdown::render(
#     "MyDocument.Rmd",
#     params = list(
#       region = region,
#       year = year
#     ),
#     output_file = paste0("Report-", region, "-", year, ".pdf")
#   )
# }
