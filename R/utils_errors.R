#' Shows modal window of specified type
#'
#' @param msg 
#' @param type 
#' @return None
#' @author Fernando Naufel
feedback_modal <- function(msg, type, session) {
  
  showModal(
    modalDialog(
      icon('exclamation-triangle'),
      HTML('&nbsp;'),
      strong(em(msg)),
      title = type,
      size = 'm',
      easyClose = TRUE,
      footer = modalButton('Fechar')
    ),
    session
  )
  
}

#' Shows modal window with error message
#'
#' @param msg 
#' @return None
#' @author Fernando Naufel
error_modal <- function(msg, session) {
  
  feedback_modal(msg, 'ERRO', session)
  
}

#' Shows modal window with warning message
#'
#' @param msg 
#' @return None
#' @author Fernando Naufel
warning_modal <- function(msg, session) {
  
  feedback_modal(msg, 'AVISO', session)
  
}


