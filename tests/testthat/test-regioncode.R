<<<<<<< HEAD
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
=======
test_that("multiplication works", {
  expect_equal(is.na(regioncode(data_input = corruption$prefecture_id,
                          convert_to = "name",
                          year_from = 2019,
                          year_to = 1989)), )
})

region_data[which(is.na(regioncode(data_input = corruption$prefecture_id,
                 convert_to = "name",
                 year_from = 2019,
                 year_to = 1989))),]
>>>>>>> 5d365d016fdaf9f619a0ac22d311ef697e9adb5e
