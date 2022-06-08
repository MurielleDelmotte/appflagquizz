#' quizz UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_quizz_ui <- function(id){
  ns <- NS(id)
  tagList(
    tags$div(class = "center-reponse",uiOutput(ns("reponse"))),
    shinyWidgets::progressBar(id = ns("pb"), value = 0, display_pct = TRUE),#),
    tags$div(class = "center-flag",htmlOutput(ns("flag")))
  )
}

#' quizz Server Functions
#'
#' @noRd
mod_quizz_server <- function(id, rv_global ){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    loc <- reactiveValues()

    observeEvent(rv_global$flag_question,{
      rv_global$flag_other = sample_country(rv_global$world %>%
                                      filter(country != rv_global$flag_question$name),2, url_flag = FALSE)
      rv_global$flag = mapply(c, rv_global$flag_question, rv_global$flag_other)
    })


    observeEvent(rv_global$compteur,{
      shinyWidgets::updateProgressBar(session = session, id = "pb", value = 100*rv_global$compteur/rv_global$serie)
      if (rv_global$compteur >=rv_global$serie) {
        showModal(modalDialog(
          title = glue::glue("Vous avez {rv_global$good_answer} bonnes reponses sur {rv_global$serie}"),
          easyClose = TRUE,
          footer = NULL
        ))
        rv_global$compteur = 0
        rv_global$good_answer = 0
        rv_global$fin = TRUE
      }
    })

    output$flag<-renderText({
      url <- unlist(rv_global$flag_question$url_flag)
      c('<img src="',url,'">')
    })

    output$reponse <- renderUI({
      choix <- sample(unlist(rv_global$flag[["name"]]),3)
      radioButtons(
        ns("reponse_select"), "",
        choices = choix,
        inline = TRUE,
        selected = 1)
    })

    # open modal on card click
    observeEvent(input$reponse_select,{
      if (input$reponse_select == unlist(rv_global$flag_question[["name"]])) {
        showModal(modalDialog(
          title = "Bonne reponse",
          easyClose = TRUE,
          footer = NULL
        ))
        rv_global$good_answer = rv_global$good_answer +1
      } else {
        showModal(modalDialog(
          title = "Mauvaise reponse",
          easyClose = TRUE,
          footer = NULL
        ))
      }
      rv_global$flag_question = sample_country(rv_global$world,1, url_flag = TRUE)
      rv_global$compteur = rv_global$compteur +1
    }
    )


  })
}

## To be copied in the UI
# mod_quizz_ui("quizz_1")

## To be copied in the server
# mod_quizz_server("quizz_1")
