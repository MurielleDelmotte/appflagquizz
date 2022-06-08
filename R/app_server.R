#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @importFrom dplyr %>% filter
#' @importFrom glue glue
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic

  w = country()

  global <- reactiveValues(
    world = w,
    flag_question = sample_country(w,1, url_flag = TRUE),
    compteur = 0,
    good_answer = 0,
    serie = 5,
    fin = FALSE
  )


    observeEvent(global$start,{
    toggle("accueil")
    show("game")
  })

    observeEvent(global$fin,{
      if (global$fin) {
        toggle("game")
        show("accueil")
        global$fin = FALSE}
    })

mod_accueil_server("accueil_1", rv_global = global)

mod_quizz_server("quizz_1", rv_global = global)




}
