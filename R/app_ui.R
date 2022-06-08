#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinyjs
#' @importFrom shinyWidgets setBackgroundImage
#' @noRd
#'


alignCenter <- function(el) {
  htmltools::tagAppendAttributes(el,
                                 style="margin-left:auto;margin-right:auto;"
  )
}

app_ui <- function(request) {

  tagList(
fluidPage(
  golem_add_external_resources(),

  useShinyjs(),
  div(
    id = "accueil",
      mod_accueil_ui("accueil_1")
    ),
  hidden(
    div(
      id = "game",
      mod_quizz_ui("quizz_1")
    )
  )

    # Leave this function for adding external resources



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
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "appflagquizz"
    ),
    tags$link(href = "www/custom2.css", rel = "stylesheet", type = "text/css"),
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
