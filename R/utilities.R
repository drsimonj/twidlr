#' Convert data frame and model \code{\link[stats]{formula}} to input matrix and
#' output vector list
#'
#' Convert a data frame and model \code{\link[stats]{formula}} to a list
#' containing the input variables as a matrix \code{x} and the output variable
#' as a vector \code{y}. These structures are commonly used by various modelling
#' functions such as \code{\link[glmnet]{glmnet}}.
#'
#' All operators made available by \code{\link[stats]{formula}} are allowed.
#'
#' @param data A data frame
#' @param formula A \code{\link[stats]{formula}}
#'
#' @return Two-element list containing input variables as a matrix \code{x}, and
#'   output variable as a vector \code{y}
#'
#' @export
#'
#' @seealso \code{\link[stats]{formula}} \code{\link[stats]{model.matrix}}
#'
#' @examples
#' model_as_xy(mtcars, hp ~ mpg)
#' model_as_xy(mtcars, hp ~ .)
#' model_as_xy(mtcars, hp ~ mpg * hp)
#' model_as_xy(mtcars, ~ .)
model_as_xy <- function(data, formula) {

  if (!is(data, "data.frame") | !is(formula, "formula"))
    stop("Please provide a data frame and formula (see ?stats::formula)")

  # Convert data frame to input matrix and label vector
  x <- stats::model.matrix(object = formula, data = data)[,-1]
  y <- NULL
  if (length(formula) == 3) {
    y <- data[[as.character(formula[[2L]])]]
    y <- y[rownames(data) %in% rownames(x)]  # Handle removal of missing values
  }

  list(x = x, y = y)
}
