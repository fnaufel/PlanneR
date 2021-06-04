handle_build_plan <- function(rv, input) {
  
  # Validate everything here
  valid <- validate_all(
    input$begin_end_date,
    input$days
  )
  
  # Continue only if everything ok
  shiny::req(valid)
  
  # Disable build button for at least 1 sec to provide visual 
  # indication that something is happening
  # disable('build')
  
  # # Show spinner
  # methods::removeClass(
  #   id = 'build-feedback',
  #   class = 'invisible'
  # )
  # Sys.sleep(.5)
  
  # Generation
  tryCatch(
    {
      rv$plan <- build_plan(
        input$begin_end_date[1],
        input$begin_end_date[2],
        input$days,
        wday_names,
        rv$holidays_df,
        rv$topics_col
      )
      rv$gt_table <- build_gt_table(rv$plan)
    },
    error = function(e) {
      error_modal(paste(e, 'Contate o desenvolvedor. (código 1)'))
      shiny::req(FALSE)
    },
    finally = {
      # Reenable button
      # enable('build')
      # Hide spinner
      # shinyjs::addClass(
      #   id = 'build-feedback',
      #   class = 'invisible'
      # )
      rv$gt_table <- build_gt_table(rv$plan)
    },
    error = function(e) {
      error_modal(paste(e, 'Contate o desenvolvedor. (código 2)'))
      shiny::req(FALSE)
    }
  )
}
