handle_download_plan <- function() {
  
  shiny::showModal(
    shiny::modalDialog(
      title = shiny::strong('Baixar plano de curso'),
      size = 'm',
      shiny::helpText(
        'Escolha um dos formatos abaixo.'
      ),
      footer = shiny::tagList(
        shiny::modalButton('Cancelar'),
        shiny::downloadButton('save_html', 'HTML (página web)'),
        shiny::downloadButton('save_latex', 'LaTeX')
      )
    )
  )
  
}
