
# Functions ---------------------------------------------------------------

#' Read csv file containing holiday info. The data should be in `extdata/holidays.csv`
#'
#' @return A string with the file's contents
#' @export
read_holidays_file <- function() {

  readr::read_file(
    system.file('extdata', 'holidays.csv', package = 'PlanneR', mustWork = TRUE)
  )

}


#' Create holidays data frame from multiline string
#'
#' @param text String
#' @return A tibble with columns `name` (chr), `from` (date), `to` (date)
#' @author Fernando Naufel
#' @export
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
    error_modal('Um ou mais feriados não tem data. Verifique.')
    shiny::req(FALSE)
    return(NULL)
  }
  
  df

}


#' Transform holidays df: expand multiple-day holidays to several rows
#'
#' @param df Tibble produced by `load_holidays`
#' @return Tibble with columns `name` and `date`
#' @author Fernando Naufel
#' @export
#'
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


#' Build tibble containing the plan
#'
#' @param default_start
#' @param default_end
#' @param default_days
#' @param wday_names
#' @param default_holidays
#' @param default_topics
#' @return
#' @author Fernando Naufel
#' @export
build_plan <- function(default_start, default_end, default_days, wday_names,
                       default_holidays, default_topics) {

  NULL

}


#' Render plan as a GT table
#'
#' @param initial_plan
#' @return
#' @author Fernando Naufel
#' @export
build_gt_table <- function(initial_plan) {

  NULL

}


# Initial values ----------------------------------------------------------

default_holidays_csv <- read_holidays_file()

default_holidays <- default_holidays_csv %>% 
  load_holidays() %>% 
  expand_holidays()

default_topics <- NULL

# Weekday abbrs in pt
wday_names <- c(
  'DOM',
  'SEG',
  'TER',
  'QUA',
  'QUI',
  'SEX',
  'SAB'
)

initial_plan <- build_plan(
  default_start, # from ui
  default_end,   # from ui
  default_days,  # from ui
  wday_names,
  default_holidays,
  default_topics
)

initial_table <- build_gt_table(initial_plan)


# Server ------------------------------------------------------------------

#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {

  # Reactive values
  rv <- reactiveValues(
    holidays_csv = default_holidays_csv,  # holidays as a csv string
    holidays_df = default_holidays,  # holidays dataframe
    plan = initial_plan,  # initial course plan, built on default values
    topics_txt = '',  # initial list of topics (empty)
    topics_col = NULL,  # topics vector
    gt_table = initial_table  # GT table containing initial course plan
  )
  
  
}
