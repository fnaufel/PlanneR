load_holidays <- function(text) {

  # If text is empty, return NULL
  if (stringr::str_trim(text) == '') {
    return(NULL)
  }
  
  tryCatch(
    {
      df <- readr::read_csv2(
        text,
        col_names = c('name', 'from', 'to'),
        col_types = 'ccc',
        locale = readr::locale('pt'),
        quoted_na = FALSE,
        trim_ws = TRUE
      ) %>%
        dplyr::mutate(
          name = stringr::str_squish(name),
          from = lubridate::as_date(from, format = '%d/%m/%y'),
          to = lubridate::as_date(to, format = '%d/%m/%y')
        )
    },
    error = function(e) {
      
      error_modal('Lista de feriados tem um problema. Verifique.')
      shiny::req(FALSE)
      return(NULL)
      
    }
  )
  
  # If a from date is missing, error
  if (any(is.na(df$from))) {
    error_modal('Erro na data de algum feriado. Verifique.')
    shiny::req(FALSE)
    return(NULL)
  }
  
  df

}

