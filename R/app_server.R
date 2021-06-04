
# Functions ---------------------------------------------------------------

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION

#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @author fnaufel
#' @export 
#' @importFrom readr read_file
read_holidays_file <- function() {

  readr::read_file(
    '/home/fnaufel/Development/00-Present/PlanneR/inst/extdata/holidays.csv'
  )
  # readr::read_file(
  #   system.file('extdata', 'holidays.csv', package = 'PlanneR', mustWork = TRUE)
  # )

}


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param text PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @author fnaufel
#' @export 
#' @importFrom stringr str_trim str_squish
#' @importFrom readr read_csv2 locale
#' @importFrom dplyr mutate
#' @importFrom lubridate as_date
#' @importFrom shiny req
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


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param df PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @author fnaufel
#' @export 
#' @importFrom dplyr filter select rename mutate arrange
#' @importFrom purrr pmap
#' @importFrom lubridate as_date
#' @importFrom tidyr unnest
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


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param default_start PARAM_DESCRIPTION
#' @param default_end PARAM_DESCRIPTION
#' @param default_days PARAM_DESCRIPTION
#' @param wday_names PARAM_DESCRIPTION
#' @param default_holidays PARAM_DESCRIPTION
#' @param default_topics PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @author fnaufel
#' @export 
build_plan <- function(default_start, default_end, default_days, wday_names,
                       default_holidays, default_topics) {

  NULL

}


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param initial_plan PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @author fnaufel
#' @export 
build_gt_table <- function(plan) {

  NULL

}


# Initial values ----------------------------------------------------------


# Server ------------------------------------------------------------------

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param input PARAM_DESCRIPTION
#' @param output PARAM_DESCRIPTION
#' @param session PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @author fnaufel
#' @export 
#' @importFrom shiny reactiveValues
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

  # ...  
  
}
