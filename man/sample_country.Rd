% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sample_country.R
\name{sample_country}
\alias{sample_country}
\title{sample_country}
\usage{
sample_country(list_country, n = 1, url_flag = TRUE)
}
\arguments{
\item{list_country}{a dataframe of country /url}

\item{n}{a positive number, the number of items to choose from.}

\item{url_flag}{boolean TRUE if function must return the url of country}
}
\value{
list of name of a country and url of flag
}
\description{
A sample of country
}
\examples{
world <- country()
sample_country(world, n=3)
sample_country(world, n=3, url_flag = FALSE)
}
