
#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  
  tagList(
    
    # Leave this function for adding external resources
    golem_add_external_resources(),

        # Your application UI logic 
    fluidPage(
      theme = shinythemes::shinytheme('flatly'),
      
      titlePanel("planneR   v1.03"),
      
      sidebarLayout(
        
        sidebarPanel(
          
          # Start and end dates for semester
          dateRangeInput(
            'begin_end_date', 
            label = 'Duração do curso', 
            start = default_start,
            end = default_end,
            format = 'dd/mm/yyyy',
            language = 'pt-BR',
            separator = '  até  '
          ), 
          
          # Weekdays of classes
          checkboxGroupInput(
            'days', 
            label = 'Dias de aula',
            choices = list(
              'D' = 1,
              'S' = 2,
              'T' = 3,
              'Q' = 4,
              'Q' = 5,
              'S' = 6,
              'S' = 7
            ),
            selected = default_days,
            inline = TRUE
          ),
          
          hr(),
          
          # Holidays
          tags$label(
            'Feriados e recessos',
            class = 'control-label',
            'for' = 'holidays'
          ),
          
          helpText(
            'As datas padrão são as do',
            a(
              'calendário oficial da UFF.',
              href = 'http://www.uff.br/?q=calendarios',
              target = '_blank'
            ),
            br(),
            'Os feriados municipais são os de',
            a(
              'Rio das Ostras.',
              href = 'http://www.uff.br/?q=cidade/rio-das-ostras',
              target = '_blank'
            )
          ),
          
          actionButton(
            'holidays',
            'Ver / alterar feriados',
            style = center_css
          ),
          
          hr(),
          
          # List of class topics
          tags$label(
            'Tópicos das aulas',
            class = 'control-label',
            'for' = 'topics'
          ),
          
          actionButton(
            'fill_in_topics',
            'Ver / alterar tópicos',
            style = center_css
          ),
          
          hr(),
          
          # Generate course plan
          tags$label(
            'Plano de curso',
            class = 'control-label',
            'for' = 'build'
          ),
          
          # Buttons to generate and download plan
          div(
            actionButton(
              'build',
              label = 'Gerar',
              icon = icon('calendar-alt'),
              style = 'margin-right: 5px'
            ),
            actionButton(
              'dl',
              label = 'Baixar',
              icon = icon('download'),
              style = 'margin-left: 5px;'
            ),
            span(
              icon('spinner'),
              style = 'margin-right: 5px;',
              class = 'invisible'
            ),
            style = flex_justify
          )
        ),
        
        mainPanel(
          
          # GT table with plan
          gt::gt_output('plan'),
          
          p(HTML('&nbsp;'))
          
        )
        
      )
      
    )
    
  )
  
}


#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'PlanneR'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}


