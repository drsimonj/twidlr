#' Default parameters used by twidlr functions
#'
#' @name twidlr_defaults
#'
#' @param data Data frame containing the variables in the model
#' @param formula \code{\link[stats]{formula}} describing the model to be fitted
#' @param object Fitted model
#' @param ... Additional arguments to pass to model function
NULL

#' Default parameters used by twidlr functions that do not specify an outcome
#' variable (typically an unsupervised model)
#'
#' @name unsupervised_twidlr_defaults
#'
#' @param data Data frame containing the variables in the model
#' @param formula A \code{\link[stats]{formula}} with no response variable.
#'   (optional). If omitted, all variables in "data" will be included.
#' @param object Fitted model
#' @param ... Additional arguments to pass to model function
NULL
