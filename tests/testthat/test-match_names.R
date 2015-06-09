context("match names")

rsp <- tnrs_match_names(names = c("holothuria", "diadema", "fromia"))

############################################################################
## check_args_match_names                                                 ##
############################################################################

context("check_args_match_names")

test_that("error generated if no argument is provided",
          expect_error(rotl:::check_args_match_names(rsp),
                       "You must specify"))

test_that("error generated if row_number and taxon_name are provided",
          expect_error(rotl:::check_args_match_names(rsp, row_number = 1,
                                                     taxon_name = "holothuria"),
                       "must use only one of "))

test_that("error generated if row_number and ott_id are provided",
          expect_error(rotl:::check_args_match_names(rsp, row_number = 1,
                                                    ott_id = 924443),
                      "must use only one of"))

test_that("error generated if ott_id and taxon_name are provided",
          expect_error(rotl:::check_args_match_names(rsp, taxon_name = "holothuria",
                                                     ott_id = 924443),
                       "must use only one of"))

test_that("error generated if row_number is not numeric",
          expect_error(rotl:::check_args_match_names(rsp, row_number = TRUE),
                       "must be a numeric"))

test_that("error generated if ott_id is not numeric",
          expect_error(rotl:::check_args_match_names(rsp, ott_id = TRUE),
                       "must be a numeric"))

test_that("error generated if taxon_name is not character",
          expect_error(rotl:::check_args_match_names(rsp, taxon_name = TRUE),
                       "must be a character"))

test_that("error generated if row_number if not one of the row", {
    expect_error(rotl:::check_args_match_names(rsp, row_number = 10),
                 "is not a valid row number")
    expect_error(rotl:::check_args_match_names(rsp, row_number = 1.5),
                 "is not a valid row number")
    expect_error(rotl:::check_args_match_names(rsp, row_number = 0),
                 "is not a valid row number")
})

test_that("error generated if invalid taxon_name", {
    expect_error(rotl:::check_args_match_names(rsp, taxon_name = "echinodermata"),
                 "Can't find")
    expect_error(rotl:::check_args_match_names(rsp, taxon_name = NA_character_),
                 "Can't find")
})

test_that("error generated if invalid ott id", {
    expect_error(rotl::check_args_match_names(rsp, ott_id = 66666),
                 "Can't find")
})

test_that("error generated if more than 1 value for row_number is provided",
          expect_error(rotl::check_args_match_names(rsp, row_number = c(1, 2, 3, 4)),
                       "You must supply a single element"))

test_that("error generated if more than 1 value for taxon_name is provided",
          expect_error(rotl::check_args_match_names(rsp, taxon_name = c("holothuria", "diadema")),
                       "You must supply a single element"))


test_that("error generated if more than 1 value for ott_id is provided",
          expect_error(rotl::check_args_match_names(rsp, ott_id = c(924443, 4930522, 240396)),
                       "You must supply a single element"))

############################################################################
## inspect_match_names                                                    ##
############################################################################

context("inspect_match_names")

test_that("correct data is being returned when asked to lookup by taxon name", {
    tt <- inspect_match_names(rsp, taxon_name = "holothuria")[["ott_id"]]
    tt <- all(tt %in% c(924443, 3652285, 497201, 443193))
    expect_true(tt)
})

test_that("correct data is being returned when asked to lookup by ott_id", {
    tt <- inspect_match_names(rsp, ott_id = 924443)[["ott_id"]]
    tt <- all(tt %in% c(924443, 3652285, 497201, 443193))
    expect_true(tt)
})

test_that("correct data is being returned when asked to lookup by row number", {
    tt <- inspect_match_names(rsp, row_number = 1)[["ott_id"]]
    tt <- all(tt %in% c(924443, 3652285, 497201, 443193))
    expect_true(tt)
})

############################################################################
## list_synonyms_match_names                                              ##
############################################################################

context("list_synonym_match_names")

test_that("correct synonyms are being returned when asked to look up by taxon name", {
    tt <- list_synonyms_match_names(rsp, taxon_name = "holothuria")
    expect_true(any(grepl("^Holothuria", names(tt))))
    expect_true(any(grepl("^Vaneyothuria", names(tt))))
    expect_true(any(grepl("^Physalia", names(tt))))
    expect_true(any(grepl("^Priapulus", names(tt))))
})

test_that("correct synonyms are being returned when asked to look up by row number", {
    tt <- list_synonyms_match_names(rsp, row_number = 1)
    expect_true(any(grepl("^Holothuria", names(tt))))
    expect_true(any(grepl("^Vaneyothuria", names(tt))))
    expect_true(any(grepl("^Physalia", names(tt))))
    expect_true(any(grepl("^Priapulus", names(tt))))
})


test_that("correct synonyms are being returned when asked to look up by ott id", {
    tt <- list_synonyms_match_names(rsp, ott_id =  924443)
    expect_true(any(grepl("^Holothuria", names(tt))))
    expect_true(any(grepl("^Vaneyothuria", names(tt))))
    expect_true(any(grepl("^Physalia", names(tt))))
    expect_true(any(grepl("^Priapulus", names(tt))))
})

############################################################################
## update_match_names                                                     ##
############################################################################

context("update_match_names")

test_that("error message if missing both new arguments",
          expect_error(update_match_names(rsp, row_number = 1),
                       "You must specify either"))

test_that("error message if both new arguments are provided",
          expect_error(update_match_names(rsp, row_number = 1,
                                          new_row_number = 1,
                                          new_ott_id = 6666),
                       "You must use only"))

test_that("error message if wrong new row number provided", {
    expect_error(update_match_names(rsp, row_number = 1,
                                    new_row_number = 10),
                 "is not a valid row number")
    expect_error(update_match_names(rsp, row_number = 1,
                                    new_row_number = 1.5),
                 "is not a valid row number")
})

test_that("error message if wrong new ott id provided", {
    expect_error(update_match_names(rsp, row_number = 1,
                                    new_ott_id = 66666),
                 "Can't find")
})

test_that("it works correctly when providing a new row number", {
    new_rsp <- update_match_names(rsp, row_number = 2,
                                  new_row_number = 2)
    expect_equal(new_rsp[new_rsp$search_string == "diadema", "ott_id"],
                 "631176")
})


test_that("it works correctly when providing a new ott id", {
    new_rsp <- update_match_names(rsp, row_number = 2,
                                  new_ott_id = 631176)
    expect_equal(new_rsp[new_rsp$search_string == "diadema", "ott_id"],
                 "631176")
})