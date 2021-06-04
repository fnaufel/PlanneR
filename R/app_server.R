
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
  
  # ...


}
