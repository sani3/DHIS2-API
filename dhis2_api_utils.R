library(httr)
library(jsonlite)
library(tidyverse)


# Get data elements -------------------------------------------------------


get_dataElements <- function(base_url="", qparams="", username="", password=""){
    dataElements <- "/api/33/dataElements"
    url <- paste0(base_url, dataElements, qparams)
    response <- httr::GET(url, authenticate(username, password))
    contnt <- httr::content(response, as="text")
    data_list <- jsonlite::fromJSON(contnt)
    data <- data_list$dataElements
    data
}


# Get information on a single data element by id --------------------------


get_dataElement <- function(base_url="", qparams="", username="", password=""){
    dataElements <- "/api/33/dataElements"
    url <- paste0(base_url, dataElements, qparams)
    response <- httr::GET(url, authenticate(username, password))
    contnt <- httr::content(response, as="text")
    data_list <- jsonlite::fromJSON(contnt)
    data <- data.frame(data_list[c("id", "code", "name", "displayName")])
    data
}


# Get data sets -----------------------------------------------------------


get_dataSets <- function(base_url="", qparams="", username="", password=""){
    dataSets <- "/api/33/dataSets"
    url <- paste0(base_url, dataSets, qparams)
    response <- httr::GET(url, authenticate(username, password))
    contnt <- httr::content(response, as="text")
    data_list <- jsonlite::fromJSON(contnt)
    data <- data_list$dataSets
    data
}

# Get information on a single data set by id ------------------------------


get_dataSet <- function(base_url="", uid="", username="", password=""){
    dataSets <- "/api/33/dataSets"
    url <- paste0(base_url, dataSets, uid)
    response <- httr::GET(url, authenticate(username, password))
    contnt <- httr::content(response, as="text")
    data_list <- jsonlite::fromJSON(contnt)
    data <- data.frame(data_list[c("id", "code", "name", "displayName")])
    data
}


# Get organisation units --------------------------------------------------


get_orgUnits <- function(base_url="", qparams="", username="", password=""){
    organisationUnits <- "/api/33/organisationUnits"
    url <- paste0(base_url, organisationUnits, qparams)
    response <- httr::GET(url, authenticate(username, password))
    contnt <- httr::content(response, as="text")
    data_list <- jsonlite::fromJSON(contnt)
    data <- data_list$organisationUnits
    data
}


# Get information on a single organisation unit by id ---------------------


get_orgUnit <- function(base_url="", uid="", username="", password=""){
    organisationUnits <- "/api/33/organisationUnits"
    url <- paste0(base_url, organisationUnits, uid)
    response <- httr::GET(url, authenticate(username, password))
    contnt <- httr::content(response, as="text")
    data_list <- jsonlite::fromJSON(contnt)
    data <- data.frame(data_list[c("id", "code", "name", "displayName")])
    data
}


# Get indicators ----------------------------------------------------------


get_indicators <- function(base_url="", qparams="", username="", password=""){
    indicators <- "/api/33/indicators"
    url <- paste0(base_url, indicators, qparams)
    response <- httr::GET(url, authenticate(username, password))
    contnt <- httr::content(response, as="text")
    data_list <- jsonlite::fromJSON(contnt)
    data <- data_list$indicators
    data
}


# Get information on a single indicator by id -----------------------------


get_indicator <- function(base_url="", uid="", username="", password=""){
    indicators <- "/api/33/indicators"
    url <- paste0(base_url, indicators, uid)
    response <- httr::GET(url, authenticate(username, password))
    contnt <- httr::content(response, as="text")
    data_list <- jsonlite::fromJSON(contnt)
    data <- data.frame(data_list[c("id", "code", "name", "displayName")])
    data
}


# Get aggregated analytics ------------------------------------------------


get_analytics <- function(base_url="", qparams="", username="", password=""){
    analytics <- "/api/33/analytics"
    url <- paste0(base_url, analytics, qparams)
    response <- httr::GET(url, authenticate(username, password))
    contnt <- httr::content(response, as="text")
    data_list <- jsonlite::fromJSON(contnt)
    data <- setNames(data.frame(data_list$rows), gsub(" ", "_", data_list$headers$column))
    data
}
