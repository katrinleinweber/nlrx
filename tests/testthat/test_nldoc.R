testthat::context("nldoc tests")
testthat::test_that("nldoc", {

  testthat::context("nldoc")

  modelfiles <- c("https://raw.githubusercontent.com/nldoc/nldoc_pg/master/WSP.nlogo",
                  "https://raw.githubusercontent.com/nldoc/nldoc_pg/master/WSP.nls")

  # Create html documentation:
  nldoc_dir <- tempdir()
  nldoc(modelfiles = modelfiles,
        infotab=TRUE,
        gui=TRUE,
        bs=TRUE,
        outpath = nldoc_dir,
        output_format = "html",
        number_sections = TRUE,
        theme = "cosmo",
        date = date(),
        toc = TRUE)

  nldoc_html <- file.path(nldoc_dir, "nldoc.html")
  testthat::expect_true(file.exists(nldoc_html))

  ## Read html back in:
  nldoc_readin <- XML::readHTMLList(nldoc_html)
  testthat::expect_equal(length(nldoc_readin), 8)

  # Create docx documentation:
  nldoc_dir <- tempdir()
  nldoc(modelfiles = modelfiles,
        infotab=TRUE,
        gui=TRUE,
        bs=TRUE,
        outpath = nldoc_dir,
        output_format = "docx",
        number_sections = TRUE,
        theme = "cosmo",
        date = date(),
        toc = TRUE)

  nldoc_docx <- file.path(nldoc_dir, "nldoc.docx")
  testthat::expect_true(file.exists(nldoc_docx))


  testthat::context("nldoc_network")

  nw <- nldoc_network(modelfiles)

  testthat::expect_match(class(nw), "igraph")
  testthat::expect_equal(length(nw), 10)


})
