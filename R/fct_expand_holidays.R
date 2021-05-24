#' expand_holidays 
#'
#' @description Transform holidays df: expand multiple-day holidays to several rows
#'
#' @return Tibble with columns ???
#'
#' @noRd
# 
expand_holidays <- function(df) {
  
  # # Return NULL if df is empty
  # if (is.null(df)) {
  #   return(NULL)
  # }
  # 
  # # Save rows that represent single-day holidays (minus `to`` column)
  # df1 <- df %>%
  #   filter(is.na(to)) %>%
  #   select(-to) %>%
  #   rename(date = from)
  # 
  # # Save rows that represent multiple-day holidays
  # df2 <- df %>%
  #   filter(!is.na(to))
  # 
  # # If there are no multiple-day holidays, return original df
  # if (nrow(df2) == 0) {
  #   return(df1)
  # }
  # 
  # # Create list column with vector of dates for each holiday
  # # and unnest this list column
  # expanded_df <- df2 %>%
  #   mutate(expanded = pmap(., ~ as_date(..2:..3))) %>%
  #   select(-from, -to) %>%
  #   unnest(cols = expanded) %>%
  #   rename(date = expanded)
  # 
  # # Eliminate rows whose date already appear in df1
  # expanded_df <- expanded_df %>%
  #   filter(!(date %in% df1$date))
  # 
  # # Returned merged df
  # df1 %>%
  #   rbind(expanded_df) %>%
  #   arrange(date)

  NULL
  
}
