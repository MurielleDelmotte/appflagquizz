# WARNING - Generated by {fusen} from /dev/flat_flag.Rmd: do not edit by hand

#' country
#' 
#' a function that retrieves the list of countries available at the url "https://www.monsieur-des-drapeaux.com/drapeaux-du-monde.html"
#'
#' @importFrom rvest html_elements html_text html_attr
#' @importFrom xml2 read_html
#' @importFrom stringr str_detect
#' @importFrom dplyr %>% mutate filter
#' @importFrom glue glue
#' @importFrom tibble tibble
#' @return a dataframe with name country and url
#' @export
#'
#' @examples
#' world <- country()
#' head(world)
country <- function() {
  url <- read_html("https://www.monsieur-des-drapeaux.com/drapeaux-du-monde.html") %>%
    html_elements('li[class="clear_float"]') %>%
    html_elements("ul") %>%
    html_elements("li")

  # url %>%
  #   html_elements("img") %>%
  #   html_attr("src")

  t1 <- url %>%
    html_elements("a") %>%
    html_attr("href") %>%
    unique()

  t2 <- url %>%
    html_text()

  tab <- tibble(url = t1, country = t2) %>%
    filter(str_detect(url, pattern = "^/")) %>%
    filter(str_detect(url, pattern = "html$")) %>%
    filter(country != "") %>%
    mutate(url = glue::glue("https://www.monsieur-des-drapeaux.com/{url}"))

  return(tab)
}
