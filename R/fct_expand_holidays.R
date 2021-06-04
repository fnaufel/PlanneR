expand_holidays <- function(df) {
  
  # Return NULL if df is empty
  if (is.null(df)) {
    return(NULL)
  }

  # Save rows that represent single-day holidays (minus `to` column)
  df1 <- df %>%
    dplyr::filter(is.na(to)) %>%
    dplyr::select(-to) %>%
    dplyr::rename(date = from)

  # Save rows that represent multiple-day holidays
  df2 <- df %>%
    dplyr::filter(!is.na(to))

  # If there are no multiple-day holidays, return original df
  if (nrow(df2) == 0) {
    return(df1)
  }

  # Create list column with vector of dates for each holiday
  # and unnest this list column
  expanded_df <- df2 %>%
    dplyr::mutate(
      expanded = purrr::pmap(., ~ lubridate::as_date(..2:..3))
    ) %>%
    dplyr::select(-from, -to) %>%
    tidyr::unnest(cols = expanded) %>%
    dplyr::rename(date = expanded)

  # Eliminate rows whose date already appear in df1
  expanded_df <- expanded_df %>%
    dplyr::filter(!(date %in% df1$date))

  # Returned merged df
  df1 %>%
    rbind(expanded_df) %>%
    dplyr::arrange(date)

}
