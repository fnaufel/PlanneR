handle_save_holidays <- function(rv, input) {
  
  new_contents <- input$holidays_area
  if (stringr::str_sub(new_contents, -1, -1) != '\n') {
    # Add final new line (in case user deleted it)
    # This new line will also make load_holidays handle
    # the contents of the text area as a vector, not as
    # a file name.
    new_contents <- paste0(new_contents, '\n')
  }
  rv$holidays_csv <- new_contents
  rv$holidays_df <- load_holidays(rv$holidays_csv) %>% 
    expand_holidays()
  shiny::removeModal()
  
}
