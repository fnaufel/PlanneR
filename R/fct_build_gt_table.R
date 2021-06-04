build_gt_table <- function(plan) {

  plan %>% 
    mutate(
      class_date = strftime(class_date, format = '%d/%m/%y')
    ) %>% 
    gt() %>% 
    fmt_missing(
      columns = everything(),
      missing_text = ''
    ) %>% 
    cols_label(
      class_date = 'Data',
      weekday = 'Dia',
      class_no = 'Aula',
      contents = 'Conteúdo'
    ) %>% 
    cols_align(
      'right',
      columns = c('class_no', 'class_date')
    ) %>% 
    tab_style(
      style = list(
        cell_text(weight = 'bold'),
        cell_fill()
      ),
      locations = cells_column_labels(
        columns = everything()
      )
    ) %>% 
    tab_style(
      style = cell_text(size = 'large'),
      locations = list(
        cells_column_labels(
          columns = everything()
        ),
        cells_body()
      )
    ) %>% 
    tab_style(
      style = cell_text(indent = px(15)),
      locations = list(
        cells_column_labels(columns = c(weekday, contents)),
        cells_body(columns = c(weekday, contents))
      )
    ) %>% 
    tab_style(
      style = cell_text(indent = px(5)),
      locations = list(
        cells_column_labels(columns = c(class_no)),
        cells_body(columns = c(class_no))
      )
    ) %>% 
    tab_style(
      style = cell_text(
        style = 'italic',
        color = '#777777'
      ),
      locations = cells_body(
        columns = 'contents',
        rows = is.na(class_no)
      )
    ) %>% 
    tab_source_note(
      md(
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
