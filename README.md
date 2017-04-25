
<!-- README.md is generated from README.Rmd. Please edit that file -->
twidlr: data.frame-first formula-second modelling <img src="man/figures/logo.png" align="right" />
==================================================================================================

Overview
--------

twidlr is an R package that exposes **data.frame-first formula-second** versions of modelling functions. All modelling functions exposed by twidlr are of the following format:

> model\_function(data = data.frame, formula = y ~ x's, ...)

twidlr gets its name from the "tilde", often called a "twiddle", used in R formulas.

Installation
------------

twidlr is available to install from github by running:

``` r
# install.packages("devtools")
devtools::install_github("drsimonj/twidlr")
```

Usage
-----

`library(twidlr)` will expose modelling functions that you're already familiar with, but such that they accept a data frame, formula, and additional arguments!

For example, a typical linear model would be `lm(hp ~ mpg * wt, mtcars, ...)`. Once `twidlr` is loaded, the same model would be run via `lm(mtcars, hp ~ mpg * wt, ...)`.

Motivation
----------

-   **Consistent API** for modelling functions (helping to improve the generality of tidy modelling packages like [piplearner](https://github.com/drsimonj/pipelearner))
-   **[Tidyverse](http://tidyverse.org/) philosophy** by working with data frames and being pipeable such as `mtcars %>% lm(hp ~ wt)`
-   **Leverage formula operators** where they may be valid but not originally available. For example, to specify select variables or include additional terms like interactions and dummy-coded variables with syntax such as `glmnet(iris, Sepal.Width ~ Petal.Width * Petal.Length + Species)`.

twidlr models
-------------

data.frame-first formula-second model functions exposed by twidlr:

| Package      | Function     |
|:-------------|:-------------|
| glmnet       | glmnet       |
| lme4         | glmer        |
| lme4         | lmer         |
| quantreg     | crq          |
| quantreg     | nlrq         |
| quantreg     | rq           |
| quantreg     | rqss         |
| randomForest | randomForest |
| rpart        | rpart        |
| stats        | glm          |
| stats        | kmeans       |
| stats        | lm           |
| xgboost      | xgboost      |

Contributing
------------

For conventions and best-practices when contributing to twidlr, please see [CONTRIBUTING.md](https://github.com/drsimonj/twidlr/blob/master/CONTRIBUTING.md)
