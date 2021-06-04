
handle_reset_holidays <- function(default_holidays_csv) {
  
  shiny::updateTextAreaInput(
    inputId = 'holidays_area',
    value = default_holidays_csv
  )
  
}
