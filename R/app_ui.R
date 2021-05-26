
# Default values ----------------------------------------------------------

chosen_theme <- 'journal'
version_no <- '2.0'
default_start <- lubridate::dmy('14/06/2021')
default_end <- lubridate::dmy('25/09/2021')
default_days <- c(3, 5)


# UI ----------------------------------------------------------------------

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

    fluidPage(
      
      # Theme
      theme = shinythemes::shinytheme(chosen_theme),
      
      # Title and version no
      titlePanel(paste0("planneR   v", version_no)),
      
      sidebarLayout(
        
        sidebarPanel(
          
          # Start and end dates for semester
          h3('Duração'),
          
          dateRangeInput(
            'begin_end_date', 
            label = NULL,
            start = default_start,
            end = default_end,
            format = 'dd/mm/yyyy',
            language = 'pt-BR',
            separator = '  até  '
          ),
          
          # Weekdays of classes
          h3('Dias'),
          
          div(
            checkboxGroupInput(
              'days', 
              label = NULL,
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
            class = 'centerDiv'
          ),
          
          # Holidays
          tags$label(
            h3('Feriados e recessos'),
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
          
          div(
            actionButton(
              'holidays',
              'Ver / alterar feriados',
            ),
            class = 'centerDiv'
          ),
          
          # List of class topics
          tags$label(
            h3('Tópicos'),
            class = 'control-label',
            'for' = 'topics'
          ),
          
          div(
            actionButton(
              'fill_in_topics',
              'Ver / alterar tópicos',
            ),
            class = 'centerDiv'
          ),
          
          # Generate course plan
          tags$label(
            h3('Plano'),
            class = 'control-label',
            'for' = 'build'
          ),
          
          # Buttons to generate and download plan
          div(
            actionButton(
              'build',
              label = 'Gerar',
              icon = icon('calendar-alt')
            ),
            actionButton(
              'dl',
              label = 'Baixar',
              icon = icon('download')
            ),
            class = 'buttonPanel'
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


