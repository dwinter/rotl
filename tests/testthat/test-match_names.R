context("match names")

############################################################################
## check_args_match_names                                                 ##
############################################################################

context("check_args_match_names")

 if (identical(Sys.getenv("NOT_CRAN"), "true")) {
     rsp <- tnrs_match_names(names = c("holothuria", "diadema", "fromia"))
 }


test_that("error generated if object provided isn't created by tnrs_match_names",
          expect_error(rotl:::check_args_match_names(letters),
                       "was not created using"))

test_that("error generated if no argument is provided", {
    skip_on_cran()
    expect_error(rotl:::check_args_match_names(rsp),
                 "You must specify")
})

test_that("error generated if row_number and taxon_name are provided", {
    skip_on_cran()
    expect_error(rotl:::check_args_match_names(rsp, row_number = 1,
                                               taxon_name = "holothuria"),
                 "must use only one of ")
})

test_that("error generated if row_number and ott_id are provided", {
    skip_on_cran()
    expect_error(rotl:::check_args_match_names(rsp, row_number = 1,
                                               ott_id = 924443),
                 "must use only one of")
})

test_that("error generated if ott_id and taxon_name are provided", {
    skip_on_cran()
    expect_error(rotl:::check_args_match_names(rsp, taxon_name = "holothuria",
                                               ott_id = 924443),
                 "must use only one of")
})

test_that("error generated if row_number is not numeric", {
    skip_on_cran()
    expect_error(rotl:::check_args_match_names(rsp, row_number = TRUE),
                 "must be a numeric")
})

test_that("error generated if ott_id is not numeric", {
    skip_on_cran()
    expect_error(rotl:::check_args_match_names(rsp, ott_id = TRUE),
                 "must look like a number")
})

test_that("error generated if taxon_name is not character", {
    skip_on_cran()
    expect_error(rotl:::check_args_match_names(rsp, taxon_name = TRUE),
                 "must be a character")
})

test_that("error generated if row_number if not one of the row", {
    skip_on_cran()
    expect_error(rotl:::check_args_match_names(rsp, row_number = 10),
                 "is not a valid row number")
    expect_error(rotl:::check_args_match_names(rsp, row_number = 1.5),
                 "is not a valid row number")
    expect_error(rotl:::check_args_match_names(rsp, row_number = 0),
                 "is not a valid row number")
})

test_that("error generated if invalid taxon_name", {
    skip_on_cran()
    expect_error(rotl:::check_args_match_names(rsp, taxon_name = "echinodermata"),
                 "Can't find")
    expect_error(rotl:::check_args_match_names(rsp, taxon_name = NA_character_),
                 "Can't find")
})

test_that("error generated if invalid ott id", {
    skip_on_cran()
    expect_error(rotl:::check_args_match_names(rsp, ott_id = 66666),
                 "Can't find")
})

test_that("error generated if more than 1 value for row_number is provided", {
    skip_on_cran()
    expect_error(rotl:::check_args_match_names(rsp, row_number = c(1, 2, 3, 4)),
                 "You must supply a single element")
})

test_that("error generated if more than 1 value for taxon_name is provided", {
    skip_on_cran()
    expect_error(rotl:::check_args_match_names(rsp, taxon_name = c("holothuria", "diadema")),
                 "You must supply a single element")
})


test_that("error generated if more than 1 value for ott_id is provided", {
    skip_on_cran()
    expect_error(rotl:::check_args_match_names(rsp, ott_id = c(924443, 4930522, 240396)),
                 "only 1 element should be provided")
})

############################################################################
## inspect.match_names                                                    ##
############################################################################

context("inspect.match_names")

 if (identical(Sys.getenv("NOT_CRAN"), "true")) {
     rsp <- tnrs_match_names(names = c("holothuria", "diadema", "fromia"))
 }


test_that("correct data is being returned when asked to lookup by taxon name", {
    skip_on_cran()
    tt <- inspect(rsp, taxon_name = "holothuria")[["ott_id"]]
    tt <- all(tt %in% c(924443, 3652285, 497201, 443193))
    expect_true(tt)
})

test_that("correct data is being returned when asked to lookup by ott_id", {
    skip_on_cran()
    tt <- inspect(rsp, ott_id = 924443)[["ott_id"]]
    tt <- all(tt %in% c(924443, 3652285, 497201, 443193))
    expect_true(tt)
})

test_that("correct data is being returned when asked to lookup by row number", {
    skip_on_cran()
    tt <- inspect(rsp, row_number = 1)[["ott_id"]]
    tt <- all(tt %in% c(924443, 3652285, 497201, 443193))
    expect_true(tt)
})

############################################################################
## synonyms.match_names                                                   ##
############################################################################

context("list_synonym_match_names")

if (identical(Sys.getenv("NOT_CRAN"), "true")) {
    tax_rsp <- c("Holothuria", "Diadema", "Fromia")
    rsp <- tnrs_match_names(names = tax_rsp)
}


test_that("synonyms with only_current = FALSE", {
    skip_on_cran()
    tt <- synonyms(rsp, only_current = FALSE)
    expect_true(inherits(tt, "list"))
    expect_equal(names(tt), tax_rsp)
})

test_that("synonyms with only_current = TRUE", {
    skip_on_cran()
    tt <- synonyms(rsp, only_current = TRUE)
    expect_true(inherits(tt, "list"))
    expect_equal(names(tt), rsp$unique_name)
})


test_that("correct synonyms are being returned when asked to look up by taxon name", {
    skip_on_cran()
    tt <- synonyms(rsp, taxon_name = "holothuria")
    expect_true(any(grepl("^Holothuria", names(tt))))
    expect_true(any(grepl("^Vaneyothuria", names(tt))))
    expect_true(any(grepl("^Physalia", names(tt))))
    expect_true(any(grepl("^Priapulus", names(tt))))
})

test_that("holothuria is present in each element of the list", {
    skip_on_cran()
    tt <- synonyms(rsp, taxon_name = "holothuria")
    expect_true(all(sapply(tt, function(x) any(grepl("holothuria", x, ignore.case = TRUE)))))
})

test_that("correct synonyms are being returned when asked to look up by row number", {
    skip_on_cran()
    tt <- synonyms(rsp, row_number = 1)
    expect_true(any(grepl("^Holothuria", names(tt))))
    expect_true(any(grepl("^Vaneyothuria", names(tt))))
    expect_true(any(grepl("^Physalia", names(tt))))
    expect_true(any(grepl("^Priapulus", names(tt))))
})


test_that("correct synonyms are being returned when asked to look up by ott id", {
    skip_on_cran()
    tt <- synonyms(rsp, ott_id =  924443)
    expect_true(any(grepl("^Holothuria", names(tt))))
    expect_true(any(grepl("^Vaneyothuria", names(tt))))
    expect_true(any(grepl("^Physalia", names(tt))))
    expect_true(any(grepl("^Priapulus", names(tt))))
})

############################################################################
## update.match_names                                                     ##
############################################################################

context("update.match_names")

 if (identical(Sys.getenv("NOT_CRAN"), "true")) {
     rsp <- tnrs_match_names(names = c("holothuria", "diadema", "fromia"))
 }

test_that("error message if missing both new arguments", {
    skip_on_cran()
    expect_error(update(rsp, row_number = 1),
                 "You must specify either")
})

test_that("error message if both new arguments are provided", {
    skip_on_cran()
    expect_error(update(rsp, row_number = 1,
                        new_row_number = 1,
                        new_ott_id = 6666),
                 "You must use only")
})

test_that("error message if wrong new row number provided", {
    skip_on_cran()
    expect_error(update(rsp, row_number = 1,
                        new_row_number = 10),
                 "is not a valid row number")
    expect_error(update(rsp, row_number = 1,
                        new_row_number = 1.5),
                 "is not a valid row number")
})

test_that("error message if wrong new ott id provided", {
    skip_on_cran()
    expect_error(update(rsp, row_number = 1,
                        new_ott_id = 66666),
                 "Can't find")
})

test_that("it works correctly when providing a new row number", {
    skip_on_cran()
    new_rsp <- update(rsp, row_number = 2,
                      new_row_number = 2)
    expect_equal(new_rsp[new_rsp$search_string == "diadema", "ott_id"],
                 "631176")
})


test_that("it works correctly when providing a new ott id", {
    skip_on_cran()
    new_rsp <- update(rsp, row_number = 2,
                      new_ott_id = 631176)
    expect_equal(new_rsp[new_rsp$search_string == "diadema", "ott_id"],
                 "631176")
})


############################################################################
## flags method                                                           ##
############################################################################

context("flags method for class match_names")

if (identical(Sys.getenv("NOT_CRAN"), "true")) {
    tax_rsp <- c("Tyrannosaurus", "Helicoplacus", "Ctenocystis",
                 "Holothuria", "Echinoidea")
    rsp <- tnrs_match_names(tax_rsp)
}

test_that("flags with no arguments and only_current = FALSE", {
    skip_on_cran()
    flags_rsp <- flags(rsp, only_current = FALSE)
    expect_equal(length(flags_rsp), 5)
    expect_equivalent(sapply(flags_rsp, length),  c(1, 1, 1, 4, 1))
})

test_that("flags with no arguments and only_current = TRUE", {
    skip_on_cran()
    flags_rsp <- flags(rsp, only_current = TRUE)
    expect_equal(length(flags_rsp), 5)
    expect_equivalent(sapply(flags_rsp, length),  c(2, 2, 2, 0, 0))
})

test_that("flags with row number", {
    skip_on_cran()
    flags_rsp <- flags(rsp, 1)
    expect_true(inherits(flags_rsp, "list"))
    expect_equal(length(flags_rsp), 1)
    expect_equal(length(flags_rsp[[1]]), 2)
    expect_true(inherits(flags_rsp[[1]], "character"))
    expect_equal(names(flags_rsp), tax_rsp[1])
})

test_that("flags with taxon name", {
    skip_on_cran()
    flags_rsp <- flags(rsp, taxon_name = "Tyrannosaurus")
    expect_true(inherits(flags_rsp, "list"))
    expect_equal(length(flags_rsp), 1)
    expect_equal(length(flags_rsp[[1]]), 2)
    expect_true(inherits(flags_rsp[[1]], "character"))
    expect_equal(names(flags_rsp), tax_rsp[1])
})

test_that("flags with ott id", {
    skip_on_cran()
    flags_rsp <- flags(rsp, ott_id = 664348)
    expect_true(inherits(flags_rsp, "list"))
    expect_equal(length(flags_rsp), 1)
    expect_equal(length(flags_rsp[[1]]), 2)
    expect_true(inherits(flags_rsp[[1]], "character"))
    expect_equal(names(flags_rsp), tax_rsp[1])
})


############################################################################
## ott_id method                                                          ##
############################################################################

context("ott_id method for class match_names")

if (identical(Sys.getenv("NOT_CRAN"), "true")) {
    tax_rsp <- c("Tyrannosaurus", "Helicoplacus", "Ctenocystis",
                 "Holothuria", "Echinoidea")
    rsp <- tnrs_match_names(tax_rsp)
}

test_that("ott_id with no arguments and only_current=FALSE", {
    skip_on_cran()
    expect_true(inherits(ott_id(rsp, only_current = FALSE), "list"))
    expect_equal(names(ott_id(rsp, only_current = FALSE)), tax_rsp)
    expect_equal(ott_id(rsp, only_current = FALSE)[["Holothuria"]][[1]], 924443)
})

test_that("ott_id with no arguments and only_current=TRUE", {
    skip_on_cran()
    expect_true(inherits(ott_id(rsp, only_current = TRUE), "integer"))
    expect_equal(names(ott_id(rsp, only_current = TRUE)), rsp$unique_name)
    expect_equal(unname(ott_id(rsp, only_current = TRUE)[4]), 924443)
})

test_that("ott_id with row number", {
    skip_on_cran()
    expect_equal(length(ott_id(rsp, 4)), 4)
    expect_true(inherits(ott_id(rsp, 4), "list"))
    expect_equivalent(ott_id(rsp, 4)[[1]], 924443)
})

test_that("ott_id with taxon name", {
    skip_on_cran()
    expect_equal(length(ott_id(rsp, taxon_name = "Holothuria")), 4)
    expect_true(inherits(ott_id(rsp, taxon_name = "Holothuria"), "list"))
    expect_equivalent(ott_id(rsp, taxon_name = "Holothuria")[[1]], 924443)
})

test_that("ott_id with ott id", {
    skip_on_cran()
    expect_equal(length(ott_id(rsp, ott_id=924443)), 4)
    expect_true(inherits(ott_id(rsp, ott_id=924443), "list"))
    expect_equivalent(ott_id(rsp, ott_id=924443)[[1]], 924443)
})
