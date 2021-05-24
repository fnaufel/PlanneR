
# Warning and error modals
feedback_modal <- function(msg, type) {
  
  showModal(
    modalDialog(
      icon('exclamation-triangle'),
      HTML('&nbsp;'),
      strong(em(msg)),
      title = type,
      size = 'm',
      easyClose = TRUE,
      footer = modalButton('Fechar')
    )
  )
  
}

error_modal <- function(msg) {
  
  feedback_modal(msg, 'ERRO')
  
}

warning_modal <- function(msg) {
  
  feedback_modal(msg, 'AVISO')
  
}

