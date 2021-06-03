
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
  
  shiny::tagList(
    
    # Leave this function for adding external resources
    golem_add_external_resources(),

    shiny::fluidPage(
      
      # Theme
      theme = shinythemes::shinytheme(chosen_theme),
      
      # Title and version no
      shiny::titlePanel(paste0("planneR   v", version_no)),
      
      shiny::sidebarLayout(
        
        shiny::sidebarPanel(
          
          # Start and end dates for semester
          shiny::h3('Duração'),
          
          shiny::dateRangeInput(
            'begin_end_date', 
            label = NULL,
            start = default_start,
            end = default_end,
            format = 'dd/mm/yyyy',
            language = 'pt-BR',
            separator = '  até  '
          ),
          
          # Weekdays of classes
          shiny::h3('Dias'),
          
          shiny::div(
            shiny::checkboxGroupInput(
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
            shiny::h3('Feriados e recessos'),
            class = 'control-label',
            'for' = 'holidays'
          ),
          
          shiny::helpText(
            'As datas padrão são as do',
            shiny::a(
              'calendário oficial da UFF.',
              href = 'http://www.uff.br/?q=calendarios',
              target = '_blank'
            ),
            shiny::br(),
            'Os feriados municipais são os de',
            shiny::a(
              'Rio das Ostras.',
              href = 'http://www.uff.br/?q=cidade/rio-das-ostras',
              target = '_blank'
            )
          ),
          
          shiny::div(
            shiny::actionButton(
              'holidays',
              'Ver / alterar feriados',
            ),
            class = 'centerDiv'
          ),
          
          # List of class topics
          tags$label(
            shiny::h3('Tópicos'),
            class = 'control-label',
            'for' = 'topics'
          ),
          
          shiny::div(
            shiny::actionButton(
              'fill_in_topics',
              'Ver / alterar tópicos',
            ),
            class = 'centerDiv'
          ),
          
          # Generate course plan
          tags$label(
            shiny::h3('Plano'),
            class = 'control-label',
            'for' = 'build'
          ),
          
          # Buttons to generate and download plan
          shiny::div(
            shiny::actionButton(
              'build',
              label = 'Gerar',
              icon = shiny::icon('calendar-alt')
            ),
            shiny::actionButton(
              'dl',
              label = 'Baixar',
              icon = shiny::icon('download')
            ),
            class = 'buttonPanel'
          )
        ),
        
        shiny::mainPanel(
          
          # GT table with plan
          gt::gt_output('plan'),
          
          shiny::p(shiny::HTML('&nbsp;'))
          
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
  
  golem::add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    golem::favicon(),
    golem::bundle_resources(
      path = app_sys('app/www'),
      app_title = 'PlanneR'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}


