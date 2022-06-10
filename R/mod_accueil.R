#' accueil UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_accueil_ui <- function(id){
  ns <- NS(id)
  tagList(
      fluidPage(
        HTML('<div class="wrapper"><h1 data-heading="Flag Quizz">Flag Quizz</h1></div>'),
        tags$div(class = "accueil-texte","Venez tester votre connaissance...."),
        tags$div(class = "accueil-serie",alignCenter(numericInput(ns("num"), "Choisissez la longueur de votre serie", 5, width = '25%'))),
        tags$div(class = "accueil-start",actionButton(ns("start"),"C'est Parti !"))
      )
    )
}

#' accueil Server Functions
#'
#' @noRd
mod_accueil_server <- function(id, rv_global){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    observeEvent( input$start , {
      rv_global$start <- input$start
      rv_global$serie <- input$num
    })

  })
}

## To be copied in the UI
# mod_accueil_ui("accueil_1")

## To be copied in the server
# mod_accueil_server("accueil_1")
