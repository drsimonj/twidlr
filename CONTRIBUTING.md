# Contributing to twidlr

This doc should help guide you should you wish to contribute to twidlr

## Adding a new model function

Contributing to twidlr will mostly involve adding a new model function. The aim is to provide users with two functions:

- `model(data, formula, ...)` which fits a model based on a data.frame, formula, and additional arguments.
- `predict(fit, data, ...)` which produces predicted values (typically a vector) given a fitted model and a data.frame

To achieve this in a consistent manner, follow these steps:

#### The quick version

- Add package to Suggests
- Add code in "R/twidlr-package_name.R"
- Add tests in "tests/testthat/test-package_name.R"
- Add function to README and NEWS

#### The long version

To add the model function `mod()` from the package `pkg`:

1. If not already done, add `pkg` to "Suggests" in the DESCRIPTION file
    - Can be done manually or by running `devtools::use_package("pkg", "Suggests")`. For example, `devtools::use_package("randomForest", "Suggests")`
2. If it doesn't exist, create a new file in "R/" named "twidlr-pkg.R", in which you'll add your code
    - For example, code for `lm()` from the stats package resides in "R/twidlr-stats.R"
3. In this file, add three functions: `mod`, `mod.default`, `predict.class_of_fitted_mod`. See any ["R/twidlr_*.R"](https://github.com/drsimonj/twidlr/tree/master/R) file for examples.
    - all `mod*` functions are defined as `function(data, formula, ...)`
        - For unsupervised models (e.g., [kmeans](https://github.com/drsimonj/twidlr/blob/master/R/twidlr-stats.R)), formula may be set to `~.` by default.
    - `mod` checks for necessary package via `check_pkg("pkg")` and calls the appropriate S3 method.
        - Be sure to document this function appropriately. For example, the document title should be "data.frame-first formula-second method for \code{\link[pkg]{mod}}"
    - `mod.default` does necessary data processing and returns an appropriate call to `pkg::mod()`
        - This should always start by coercing `data` to a data.frame (thus allowing other square structures) and `formula` to a formula (thus allowing string-based formulas) by way of `coerce_args`.
        - Calling the proper model function can involve passing arguments "as is" (e.g., [`lm` and `glm`](https://github.com/drsimonj/twidlr/blob/master/R/twidlr-stats.R)), or data munging to be done first (e.g., [xgboost](https://github.com/drsimonj/twidlr/blob/master/R/twidlr-xgboost.R) and [glmnet](https://github.com/drsimonj/twidlr/blob/master/R/twidlr-glmnet.R)). When data munging is required (or `formula` cannot be passed), be sure to add `formula` as an attribute to the fitted object (again, see [xgboost](https://github.com/drsimonj/twidlr/blob/master/R/twidlr-xgboost.R) and [glmnet](https://github.com/drsimonj/twidlr/blob/master/R/twidlr-glmnet.R) for examples). This is important so that the same data munging can be done by `predict`.
    - `predict.class_of_fitted_mod` is defined as `function(object, data, ...)`, and returns an appropriate call to `pkg::predict.class_of_mod` (or valid alternative).
        - It must begin with `data <- predict_checks(data = data, ...)`, which runs generic checks and coerces `data` to a data.frame.
4. It if doesn't exist already, create a new file in "tests/testthat/" named "test-pkg.R", in which you'll add your tests.
    - Can be done manually or by running `devtools::use_test("pkg")`. For example, `devtools::use_test("stats")`.
5. In this test file, add a test laid out as `test_that("mod", {...})`
    - The test should compare the results of a twidlr-created model (named `twidlr_fit`) and a model fitted by the original package (named `origina_fit`). See any of the [test files](https://github.com/drsimonj/twidlr/tree/master/tests/testthat) for examples. See Hadley Wickham's [R Packages](http://r-pkgs.had.co.nz/tests.html) for advice about creating tests.
    - The test should evaluate at least three expectations:
        1. Do the models match (e.g., coefficients)?
        2. Does `predict(twidlr_fit)` throw an error because `data` is missing?
        3. Does `predict()` on each fitted object return the same results?
6. Let everyone know about you addition and credit yourself!
    - Add pkg and mod to the data frame (converted to a table) under "twidlr models" in the [README.Rmd file](https://github.com/drsimonj/twidlr/blob/master/README.Rmd), and knit this file.
    - Add the package and function to a list in the [NEWS.md file](https://github.com/drsimonj/twidlr/blob/master/NEWS.md) followed by "(thanks to YOUR NAME)", and link "YOUR NAME" to your GitHub profile.
