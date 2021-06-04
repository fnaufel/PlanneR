build_gt_table <- function(plan) {

  plan %>% 
    dplyr::mutate(
      class_date = strftime(class_date, format = '%d/%m/%y')
    ) %>% 
    gt::gt() %>% 
    gt::fmt_missing(
      columns = tidyselect::everything(),
      missing_text = ''
    ) %>% 
    gt::cols_label(
      class_date = 'Data',
      weekday = 'Dia',
      class_no = 'Aula',
      contents = 'Conteúdo'
    ) %>% 
    gt::cols_align(
      'right',
      columns = c('class_no', 'class_date')
    ) %>% 
    gt::tab_style(
      style = list(
        gt::cell_text(weight = 'bold'),
        gt::cell_fill()
      ),
      locations = gt::cells_column_labels(
        columns = tidyselect::everything()
      )
    ) %>% 
    gt::tab_style(
      style = gt::cell_text(size = 'large'),
      locations = list(
        gt::cells_column_labels(
          columns = tidyselect::everything()
        ),
        gt::cells_body()
      )
    ) %>% 
    gt::tab_style(
      style = gt::cell_text(indent = gt::px(15)),
      locations = list(
        gt::cells_column_labels(columns = c(weekday, contents)),
        gt::cells_body(columns = c(weekday, contents))
      )
    ) %>% 
    gt::tab_style(
      style = gt::cell_text(indent = gt::px(5)),
      locations = list(
        gt::cells_column_labels(columns = c(class_no)),
        gt::cells_body(columns = c(class_no))
      )
    ) %>% 
    gt::tab_style(
      style = gt::cell_text(
        style = 'italic',
        color = '#777777'
      ),
      locations = gt::cells_body(
        columns = 'contents',
        rows = is.na(class_no)
      )
    ) %>% 
    gt::tab_source_note(
      gt::md(
        paste0(
          'Gerado por [planneR](https://fnaufel.shinyapps.io/planner/): ',
          'https://fnaufel.shinyapps.io/planner/.  ',
          '\n',
          'Desenvolvido por [fnaufel](https://fnaufel.github.io/site), ',
          'com [R](https://cran.r-project.org/), ',
          '[Shiny](https://shiny.rstudio.com/), ',
          'e o pacote [gt.](https://gt.rstudio.com/)  ',
          '\n',
          '[Licença Creative Commons BY-NC-SA.]',
          '(https://creativecommons.org/licenses/by-nc-sa/4.0/deed.pt_BR)  ',
          '\n',
          '[![](https://licensebuttons.net/l/by-nc-sa/4.0/80x15.png)]',
          '(https://creativecommons.org/licenses/by-nc-sa/4.0/deed.pt_BR)'
        )
      )
    )
  
}
