source("dhis2_api_utils.R")

username <- "admin"
password <- "district"
base_url <- "https://play.dhis2.org/dev"

orgUnit_qparam_0 <- "?paging=false"
orgUnit_qparam_1 <- ".json?paging=false"
orgUnit_qparam_2 <- "/O6uvpzGd5pu?includeChildren=true"
orgUnit_qparam_3 <- "/O6uvpzGd5pu"

indicators_qparams_1 <- "/api/indicators.json"
indicators_qparams_2 <- "?order=shortName:desc&paging=false"

analytics_qparams <- paste0(
    "?dimension=dx:fbfJHSPpUQD&dimension=pe:LAST_12_MONTHS&dimension=ou:O6uvpzGd5pu;lc3eMKXaEfw",
    "&aggregationType=SUM&measureCriteria=GE:0",
    "&outputOrgUnitIdScheme=NAME&outputDataElementIdScheme=NAME&outputIdScheme=NAME"
)

dataElements_ <- get_dataElements(
    base_url = base_url,
    username = username,
    password = password
)

dataElements_ <- get_dataElements(
    base_url = base_url,
    qparams = "?paging=false",
    username = username,
    password = password
)
write_csv(dataElements_, "data/play/dataElements.csv")

dataSets_ <- get_dataSets(
    base_url = base_url,
    username = username,
    password = password
)

dataSets_ <- get_dataSets(
    base_url = base_url,
    qparams = "?paging=false",
    username = username,
    password = password
)
write_csv(dataSets_, "data/play/dataSets.csv")

orgUnits_ <- get_orgUnits(
    base_url = base_url,
    qparams = orgUnit_qparam_0,
    username = username,
    password = password
)
write_csv(orgUnits_, "data/play/orgUnits.csv")

orgUnits_ <- get_orgUnits(
    base_url = base_url,
    qparams = "/O6uvpzGd5pu?includeChildren=true",
    username = username,
    password = password
)

indicators_ <- get_indicators(
    base_url = base_url,
    qparams = indicators_qparams_2,
    username = username,
    password = password
)
write_csv(indicators_, "/data/play/indicators.csv")

analytics_ <- get_analytics(
    base_url = base_url,
    qparams = analytics_qparams,
    username = username,
    password = password
)
write_csv(analytics_, "data/play/someAnalytics.csv")

analytics_ <- analytics_ |>
    mutate(Period = as.Date(paste0(gsub(" ", "-", Period), "-", "01"), format="%B-%Y-%d")) |>
    mutate(Value = as.numeric(Value)) |>
    rename_with(tolower) |>  # rename_with(~ gsub('[[:punct:]]', '', .x))
    arrange(organisation_unit, period)

analytics_ |>
    ggplot()+
    geom_col(mapping = aes(period, value, color=organisation_unit))+
    labs(title = "ANC 1st Visits", subtitle = "Bo and Bonthe")+
    xlab("Period")+
    ylab("Visits")

analytics_wider <- analytics_ |>
    pivot_wider(
        names_from = organisation_unit,
        values_from = value
    )

analytics_longer <- analytics_wider |>
    pivot_longer(
        cols = c(Bo, Bonthe),
        names_to="organisation_unit",
        values_to = "value",
        values_drop_na = TRUE
    )