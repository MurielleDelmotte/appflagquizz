% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/recup_url_flag.R
\name{recup_url_flag}
\alias{recup_url_flag}
\title{Recuperation url flag}
\usage{
recup_url_flag(country)
}
\arguments{
\item{country}{the name of a country}
}
\value{
url
}
\description{
Recuperation of url flag for a country
}
\examples{
library(dplyr)
world <- country() \%>\%  
  sample_n(1) \%>\% 
  pull(url)

recup_url_flag(world)
}
