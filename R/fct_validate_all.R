validate_all <- function(
  dates,
  days
) {
  
  # Start or end dates must not be NA
  if (is.null(dates) || any(is.na(dates))) {
    error_modal('Preencha datas de início e de fim do curso.')
    return(FALSE)
  }
  
  # End must come before start
  if (dates[1] >= dates[2]) {
    error_modal('Data de início deve ser anterior à data de fim.')
    return(FALSE)
  }
  
  # At least one weekday must be chosen
  if (is.null(days)) {
    error_modal('Marque pelo menos um dia da semana.')
    return(FALSE)
  }
  
  TRUE
  
}
