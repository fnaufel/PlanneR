handle_save_topics <- function(rv, input) {
  
  # Get text from text area
  new_contents <- input$topics_area
  
  # Split the big string into lines and delete empty lines
  topics_vector <- stringr::str_split(new_contents, '\n')[[1]] %>% 
    stringr::str_squish() %>% 
    subset(. != '')
  
  # This is the new text list of topics
  rv$topics_txt <- stringr::str_c(topics_vector, collapse = '\n')
  
  # This is the new vector of topics
  rv$topics_col <- topics_vector
  
  shiny::removeModal()
  
}

