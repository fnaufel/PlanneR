handle_edit_holidays <- function(rv) {
  
  shiny::showModal(
    shiny::modalDialog(
      title = htmltools::strong('Lista de feriados e recessos'),
      size = 'l',
      shiny::helpText(
        htmltools::HTML(
          '<ul>
             <li>Cada linha corresponde a um feriado ou recesso no formato NOME ; DATA INICIAL ; DATA FINAL</li>
             <li>DATA FINAL é opcional.</li>
             <li>O caracter ";" funciona como separador.</li>
             <li>Se houver mais de 2 datas na mesma linha, somente as 2 primeiras datas serão usadas.</li>
          </ul>'
        )
      ),
      shiny::textAreaInput(
        'holidays_area',
        label = NULL,
        cols = 90,
        rows = 12,
        width = 'auto',
        height = 'auto',
        resize = 'none',
        value = rv$holidays_csv
      ),
      footer = htmltools::tagList(
        shiny::modalButton('Cancelar'),
        shiny::actionButton('save_holidays', 'Salvar'),
        shiny::actionButton(
          'reset_holidays', 
          'Lista oficial',
          icon = shiny::icon('redo-alt')
        )
      )
    )
  )
  
}
