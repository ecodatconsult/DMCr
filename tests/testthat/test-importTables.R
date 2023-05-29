test_that("multiplication works", {
  expect_s4_class(importTables(file_path = ("inst/test_data/"), data = c("daten", "ereignis")), "data.frame")
})
