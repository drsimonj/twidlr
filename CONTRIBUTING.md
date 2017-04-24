# Contributing to twidlr

This doc should help guide you should you wish to contribute to twidlr

## Adding a new model function

Contributing to twidlr will often involve adding a new model function. To ensure, consistency, be sure to follow these steps:

#### The quick version

- Add package to Suggests
- Add code in "R/model_name.R"
- Add function to README and NEWS

#### The long version

- If the model function comes from a non-base package, add the package to the "Suggests" list in the DESCRIPTION file. This is easily done by running `devtools::use_package("package", "Suggests")`. For example, to include the randomForest package, run `devtools::use_package("randomForest", "Suggests")`
- Create a new file in "R/" named "model_function.R". For example, the code for converting `lm()` to a twidlr function resides in "R/lm.R"
- Add necessary code in this file. For best-practice, please read carefully through the existing files. Some conventions:
    - Document title for function should be "data.frame-first formula-second method for \code{\link[package]{function}}"
    - The function should specify three arguments: `data`, `formula`, `...`
    - Three versions of the function should be present:
        1. The function itself (named exactly as the original). E.g., `lm`
        2. function.default that attempts to coerce `data` to a data.frame
        3. function.data.frame that appropriately uses `data`, `formula`, and `...` to run the original function
- Add the package and function to the data frame (converted to a table) under "twidlr models" in the README.rmd file, and knit this file.
- Add the package and function to a list in the NEWS.md file followed by "(thanks to YOUR NAME)", and link "YOUR NAME" to your GitHub profile.
- If possible, add tests to ensure that your function(s) work. twidlr makes use of testthat for testing, which you can familiarise yourself with [here](http://r-pkgs.had.co.nz/tests.html).
