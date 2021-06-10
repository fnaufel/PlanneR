
# Server ------------------------------------------------------------------

app_server <- function( input, output, session ) {
  
  # Initial values --------------------------------------------------------

  default_holidays_csv <- read_holidays_file()

  default_holidays <- default_holidays_csv %>% 
    load_holidays() %>% 
    expand_holidays()
  
  default_topics <- NULL
  
  initial_plan <- build_plan(
    default_start, 
    default_end,   
    default_days,  
    wday_names,
    default_holidays,
    default_topics
  )
  
  initial_table <- build_gt_table(initial_plan)
  
  # Reactive values -------------------------------------------------------

  rv <- shiny::reactiveValues(
    holidays_csv = default_holidays_csv,  # holidays as a csv string
    holidays_df = default_holidays,  # holidays dataframe
    plan = initial_plan,  # initial course plan, built on default values
    topics_txt = '',  # initial list of topics (empty)
    topics_col = NULL,  # topics vector
    gt_table = initial_table  # GT table containing initial course plan
  )

  # Show plan as gt table -------------------------------------------------

  output$plan <- gt::render_gt(
    rv$gt_table,
    width = gt::pct(100)
  )
  
  # Handle button to edit / reset / save holidays ----------------------------
  # Edit
  observeEvent(
    input$holidays,
    handle_edit_holidays(rv)
  )
  
  # Save
  observeEvent(
    input$save_holidays,
    handle_save_holidays(rv, input)
  )
  
  # Reset
  observeEvent(
    input$reset_holidays,
    handle_reset_holidays(default_holidays_csv)
  )
  
  # Handle buttons to edit / save topics ---------------------------------------
  # Edit
  shiny::observeEvent(
    input$fill_in_topics,
    handle_edit_topics(rv)
  )
  
  # Save
  shiny::observeEvent(
    input$save_topics,
    handle_save_topics(rv, input)
  )
  

  # Handle button to build plan -------------------------------------------

  observeEvent(
    input$build,
    handle_build_plan(rv, input)
  )


  # Handle download button ------------------------------------------------

  observeEvent(
    input$dl,
    handle_download_plan()
  )
  
  # Download HTML
  output$save_html <- download_plan(rv, '.html')
  
  # Download LaTeX
  output$save_latex <- download_plan(rv, '.tex')
  
  # Stop the app when user closes the browser window
  session$onSessionEnded(stopApp)  

}
