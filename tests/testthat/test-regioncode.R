test_that("multiplication works", {
  expect_equal(is.na(regioncode(data_input = corruption$prefecture_id,
                          convert_to = "name",
                          year_from = 2019,
                          year_to = 1989)), )
})

region_table[which(is.na(regioncode(data_input = corruption$prefecture_id,
                 convert_to = "name",
                 year_from = 2019,
                 year_to = 1989))),]
