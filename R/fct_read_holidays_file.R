#' read_holidays_file 
#'
#' @description Read csv file containing holiday info. The data should be in `extdata/holidays.csv`
#'
#' @return A string with the file's contents
#'
#' @noRd
read_holidays_file <- function() {

  readr::read_file(
    system.file('extdata', 'holidays.csv', package = 'PlanneR', mustWork = TRUE)
  )

}
