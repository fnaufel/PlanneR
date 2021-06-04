#' Shows modal window of specified type
#'
#' @param msg 
#' @param type 
#' @return None
#' @author Fernando Naufel
feedback_modal <- function(msg, type, session = getDefaultReactiveDomain()) {
  
  shiny::showModal(
    shiny::modalDialog(
      shiny::icon('exclamation-triangle'),
      shiny::HTML('&nbsp;'),
      shiny::strong(shiny::em(msg)),
      title = type,
      size = 'm',
      easyClose = TRUE,
      footer = shiny::modalButton('Fechar')
    ),
    session
  )
  
}

#' Shows modal window with error message
#'
#' @param msg 
#' @return None
#' @author Fernando Naufel
error_modal <- function(msg) {
  
  feedback_modal(msg, 'ERRO')
  
}

#' Shows modal window with warning message
#'
#' @param msg 
#' @return None
#' @author Fernando Naufel
warning_modal <- function(msg) {
  
  feedback_modal(msg, 'AVISO')
  
}


