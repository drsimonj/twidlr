
<!-- README.md is generated from README.Rmd. Please edit that file -->
<font size="64">~</font>

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

-   Introduce consistency to the API of modelling functions (helping to improve the generality of tidy modelling packages like [piplearner](https://github.com/drsimonj/pipelearner))
-   Make modelling functions conform to tidyverse principles by becoming pipeable. E.g., `mtcars %>% lm(hp ~ wt)`
-   Leverage formula operators where they may not originally be available. For example, `glmnet(mtcars, .*.)` to fit a generalized linear model with all variables and their two-way interaction terms.

twidlr models
-------------

data.frame-first formula-second model functions exposed by twidlr:

| Package | Function |
|:--------|:---------|
| glmnet  | glmnet   |
| stats   | lm       |
| xgboost | xgboost  |
