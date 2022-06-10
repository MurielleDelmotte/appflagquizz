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

    observeEvent(rv_global$flag_question,{
      #tirage aleatoire de 2 country sans recup url flag
      rv_global$flag_other <- sample_country(rv_global$world %>%
        filter(country != rv_global$flag_question$name), 2, url_flag = FALSE)
      #concatenation du flag a questionner avec les other flag
      rv_global$flag <- mapply(c, rv_global$flag_question, rv_global$flag_other)
    })


    observeEvent(rv_global$compteur,{
      
#---- update ProgressBar 
      
      shinyWidgets::updateProgressBar(session = session, id = "pb", value = 100*rv_global$compteur/rv_global$serie)
      
      if (rv_global$compteur >= rv_global$serie) {

        showm(title = glue::glue("Vous avez {rv_global$good_answer} bonnes reponses sur {rv_global$serie}"))
        
        #if(rv_global$good_answer == rv_global$serie) {rv_global$confetti = TRUE}
        
        #Reinit globalvariable
        rv_global$compteur = 0
        rv_global$good_answer = 0
        rv_global$fin = TRUE
        rv_global$flag_memory = tibble(name = NULL)
      }
    })
    
#---- flag image
    output$flag<-renderText({ 
      url <- unlist(rv_global$flag_question$url_flag)
      c('<img src="',url,'">')
    })

#---- Propose reponse
    output$reponse <- renderUI({
      choix <- sample(unlist(rv_global$flag[["name"]]),3)
      radioButtons(
        ns("reponse_select"), "",
        choices = choix,
        inline = TRUE,
        selected = 1)
    })

#---- Event / reponse
    # open modal on card click
    observeEvent(input$reponse_select,{
      if (input$reponse_select == unlist(rv_global$flag_question[["name"]])) {
        
        showm(title = "Bonne reponse")

        rv_global$good_answer = rv_global$good_answer +1
      } else {
        
        showm(title = "Mauvaise reponse")
        
      }
      # on conserve en memoire les drapeaux qui ont deja ete propose
      rv_global$flag_memory = dplyr::bind_rows(rv_global$flag_memory, rv_global$flag_question[1])
      rv_global$flag_question = sample_country(
        #on repropose un drapeau parmi ceux qui non pas ete propose
        dplyr::anti_join(rv_global$world, rv_global$flag_memory, by = c("country"="name")),
        1, url_flag = TRUE)
      rv_global$compteur = rv_global$compteur +1
    }
    )


  })
}

## To be copied in the UI
# mod_quizz_ui("quizz_1")

## To be copied in the server
# mod_quizz_server("quizz_1")
