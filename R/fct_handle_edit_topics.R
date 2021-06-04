handle_edit_topics <- function(rv) {
  
  shiny::showModal(
    shiny::modalDialog(
      title = shiny::strong('Lista de tópicos'),
      size = 'l',
      shiny::helpText(
        'Entre o conteúdo de cada aula, uma linha por aula.'
      ),
      shiny::textAreaInput(
        'topics_area',
        label = NULL,
        cols = 90,
        rows = 10,
        width = 'auto',
        height = 'auto',
        resize = 'none',
        value = rv$topics_txt
      ),
      footer = shiny::tagList(
        shiny::modalButton('Cancelar'),
        shiny::actionButton('save_topics', 'Salvar')
      )
    )
  )
  
}
