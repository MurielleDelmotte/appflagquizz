#' Show Modal 
#'
#' @description a show modal to flag quizz.
#' @param title
#' @importFrom shiny modalDialog showModal
#' @return a modal dialog.
#'
#' @noRd

showm <- function(title) {
  showModal(modalDialog(
    title = title,
    easyClose = TRUE,
    footer = NULL
  ))
}