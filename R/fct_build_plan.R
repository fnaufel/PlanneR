build_plan <- function(start, end, days, wday_names, holidays, topics) {
  
  # Generate ALL dates between start and end
  all_dates <- lubridate::as_date(start:end)
  
  # Create data frame (date, weekday name) and filter for class days
  df <- dplyr::tibble(class_date = all_dates) %>% 
    dplyr::mutate(weekday = lubridate::wday(class_date)) %>% 
    dplyr::filter(weekday %in% days) %>% 
    dplyr::mutate(weekday = wday_names[weekday])  
  
  if (!is.null(holidays)) {
    # If holidays df is not empty, join with holidays df to fill in holiday
    # names on the right dates. I use distinct(class_date) because one date
    # may be associated with more than one holiday, and I want such a date to
    # appear only once.
    df <- df %>%
      dplyr::left_join(holidays, by = c('class_date' = 'date')) %>%
      dplyr::rename(contents = name) %>% 
      dplyr::distinct(class_date, .keep_all = TRUE)
  } else {
    # If holidays df is empty, just add an empty contents column
    df <- df %>% 
      dplyr::mutate(contents = NA_character_)
  }
  
  # Fill in class numbers
  
  # Number of available class days
  n_classes <- nrow(
    df %>% 
      dplyr::filter(is.na(contents))
  )
  
  # Class numbers
  numbers <- 1:n_classes
  
  # Add class numbers only to non holidays (contents is NA)
  df <- df %>% 
    dplyr::filter(is.na(contents)) %>% 
    dplyr::mutate(class_no = numbers) %>% 
    rbind(
      df %>% 
        dplyr::filter(!is.na(contents)) %>% 
        dplyr::mutate(class_no = NA_integer_)
    ) %>% 
    dplyr::arrange(class_date) %>% 
    dplyr::select(class_date, weekday, class_no, contents)

  # If no topics yet, return
  if (is.null(topics)) {
    return(df)
  }
  
  # n_classes is number of available class days
  # n_topics is number of topics
  n_topics <- length(topics)
  
  if (n_classes > n_topics) {
    # Add empty topics
    difference <- n_classes - n_topics
    topics <- c(topics, rep(NA, difference))
  } else if (n_classes < n_topics) {
    # truncate topics and emit warning
    topics <- topics[1:n_classes]
    difference <- n_topics - n_classes
    warning_modal(
      paste0(
        'Aulas (',
        n_classes,
        ') < Tópicos (',
        n_topics,
        '). ',
        difference,
        ' tópicos não foram incluídos.'
      )
    )
  }

  # Fill in topics
  df <- df %>% 
    dplyr::filter(is.na(contents)) %>% 
    dplyr::mutate(contents = topics) %>% 
    rbind(
      df %>% 
        dplyr::filter(!is.na(contents))
    ) %>% 
    dplyr::arrange(class_date)
  
  # Return
  df
  
}
