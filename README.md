
<!-- README.md is generated from README.Rmd. Please edit that file -->
twidlr: consistent data.frame and formula API for models <img src="man/figures/logo.png" align="right" />
=========================================================================================================

Overview
--------

twidlr is an R package that exposes a consistent API for model functions and their corresponding predict methods such that they are specified as:

``` r
fit <- model(data, formula, ...)
predict(fit, data, ...)
```

Where "data" is a **required** data.frame (or able to be coerced to one) and "formula" describes the model to be fitted.

twidlr gets its name from the "twiddle" used in R formulas.

Installation
------------

twidlr is available to install from github by running:

``` r
# install.packages("devtools")
devtools::install_github("drsimonj/twidlr")
```

Usage
-----

`library(twidlr)` exposes model functions that you're already familiar with, but such that they accept a data.frame first, formula second, and then additional arguments. A robust method to `predict` data is also exposed.

For example, a typical linear model would be `lm(hp ~ mpg * wt, mtcars, ...)`. Once `twidlr` is loaded, the same model would be run via `lm(mtcars, hp ~ mpg * wt, ...)`.

Motivation
----------

Modelling in R is messy! Some models take formulas and data frames while others require matrices and vectors. The same can be said of corresponding `predict()` methods, which can also be impure, returning unexpected or inconsistent results.

twidlr seeks to overcome these problems be providing:

-   **Consistent API** for model functions and their corresponding `predict` methods (helping to improve the generality of tidy modelling packages like [piplearner](https://github.com/drsimonj/pipelearner))
-   **Pure and available predictions** by way of `predict` being made available for all methods (including unsupervised algorithms like kmeans) and making "data" a required argument
-   **[Tidyverse](http://tidyverse.org/) philosophy** by working with data frames and being pipeable such as `mtcars %>% lm(hp ~ wt)`
-   **Leverage formula operators** where they may be valid but not originally available. For example, to specify select variables or include additional terms like interactions and dummy-coded variables with syntax such as `glmnet(iris, Sepal.Width ~ Petal.Width * Petal.Length + Species)`.

twidlr models
-------------

Model functions exposed by twidlr:

| Package      | Functions                            |
|:-------------|:-------------------------------------|
| glmnet       | glmnet                               |
| lme4         | glmer, lmer                          |
| quantreg     | crq, nlrq, rq, rqss                  |
| randomForest | randomForest                         |
| rpart        | rpart                                |
| stats        | aov, glm, kmeans, lm, prcomp, t.test |
| xgboost      | xgboost                              |

Contributing
------------

For conventions and best-practices when contributing to twidlr, please see [CONTRIBUTING.md](https://github.com/drsimonj/twidlr/blob/master/CONTRIBUTING.md)
