# Not a test just visual inspection during autotest
test_that("cli functions look ok", {
  cat(print_title_bar("Esse trem é bão demais!"))
  cat(simple_H1("Coisa"))
  cat(simple_H2("Coisinha"))
  cat(create_aligned_prompt(
    c("Aligned", "Item"),
    c("This is a test", "Item definition")
  ))
})
