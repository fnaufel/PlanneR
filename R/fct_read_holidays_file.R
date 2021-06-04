read_holidays_file <- function() {
  
  readr::read_file(
    system.file('extdata', 'holidays.csv', package = 'PlanneR', mustWork = TRUE)
  )

}
