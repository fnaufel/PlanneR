# I KNOW this is bad practice, but could not make the pipe work without it
library(magrittr)

# Initial values ----------------------------------------------------------

default_holidays_csv <- read_holidays_file()

default_holidays <- 
  load_holidays(default_holidays_csv) %>% 
  expand_holidays()

default_topics <- NULL

# Weekday abbrs in pt
wday_names <- c(
  'DOM',
  'SEG',
  'TER',
  'QUA',
  'QUI',
  'SEX',
  'SAB'
)

initial_plan <- build_plan(
  default_start, # from ui
  default_end,   # from ui
  default_days,  # from ui
  wday_names,
  default_holidays,
  default_topics
)

initial_table <- build_gt_table(initial_plan)




#' #' Inverted versions of in, is.null and is.na
#' #' 
#' #' @noRd
#' #' 
#' #' @examples
#' #' 1 %not_in% 1:10
#' #' not_null(NULL)
#' `%not_in%` <- Negate(`%in%`)
#' 
#' not_null <- Negate(is.null)
#' 
#' not_na <- Negate(is.na)
#' 
#' #' Removes the null from a vector
#' #' 
#' #' @noRd
#' #' 
#' #' @example 
#' #' drop_nulls(list(1, NULL, 2))
#' drop_nulls <- function(x){
#'   x[!sapply(x, is.null)]
#' }
#' 
#' #' If x is `NULL`, return y, otherwise return x
#' #' 
#' #' @param x,y Two elements to test, one potentially `NULL`
#' #' 
#' #' @noRd
#' #' 
#' #' @examples
#' #' NULL %||% 1
#' "%||%" <- function(x, y){
#'   if (is.null(x)) {
#'     y
#'   } else {
#'     x
#'   }
#' }
#' 
#' #' If x is `NA`, return y, otherwise return x
#' #' 
#' #' @param x,y Two elements to test, one potentially `NA`
#' #' 
#' #' @noRd
#' #' 
#' #' @examples
#' #' NA %||% 1
#' "%|NA|%" <- function(x, y){
#'   if (is.na(x)) {
#'     y
#'   } else {
#'     x
#'   }
#' }
#' 
#' #' Typing reactiveValues is too long
#' #' 
#' #' @inheritParams reactiveValues
#' #' @inheritParams reactiveValuesToList
#' #' 
#' #' @noRd
#' rv <- shiny::reactiveValues
#' rvtl <- shiny::reactiveValuesToList
#' 
