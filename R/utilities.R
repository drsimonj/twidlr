#' Convert formula into a character list
#'
#' Convert a formula of the form \code{y ~ x} into a two-element list containing
#' the lefthand and righthand sides of the formula as character vectors
#'
#' @param f A formula
#'
#' @seealso \code{\link[lazyeval]{f_lhs}}
#'
#' @return Two-element list of character vectors corresponding to the lefthand
#'   and righthand sides of the formula
#'
#' @export
#'
#' @examples
#' unpack_formula(y ~ x)
#' unpack_formula(y ~ x1 + x2)
#' unpack_formula(y ~ .)
#' unpack_formula(~ "x")
unpack_formula <- function(f) {
  lhs <- as.character(lazyeval::f_lhs(f))
  rhs <- as.character(lazyeval::f_rhs(f))
  list(lhs = lhs, rhs = rhs)
}
