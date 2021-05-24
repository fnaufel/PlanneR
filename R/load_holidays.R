#' Create holidays data frame from multiline string
#'
#' @param text String
#' @return A tibble with columns `name` (chr), `from` (date), `to` (date)
#' @author Fernando Naufel
#' @export
load_holidays <- function(text) {

  # If text is empty, return NULL
  if (str_trim(text) == '') {
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
        mutate(
          name = stringr::str_squish(name),
          from = lubridate::as_date(from, format = '%d/%m/%y'),
          to = lubridate::as_date(to, format = '%d/%m/%y')
        )
    },
    error = function(e) {
      
      error_modal('Lista de feriados tem um problema. Verifique.')
      req(FALSE)
      return(NULL)
      
    }
  )
  
  # If a from date is missing, error
  if (any(is.na(df$from))) {
    error_modal('Um ou mais feriados não tem data. Verifique.')
    req(FALSE)
    return(NULL)
  }
  
  df

}
