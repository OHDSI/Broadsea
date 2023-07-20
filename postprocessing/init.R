envVarNames <- list(
    "CDM_CONNECTIONDETAILS_DBMS",
    "CDM_CONNECTIONDETAILS_USER",
    "CDM_CONNECTIONDETAILS_SERVER",
    "CDM_CONNECTIONDETAILS_PORT",
    "CDM_CONNECTIONDETAILS_EXTRA_SETTINGS",
    "CDM_DATABASE_SCHEMA",
    "RESULTS_DATABASE_SCHEMA",
    "VOCAB_DATABASE_SCHEMA",
    "SCRATCH_DATABASE_SCHEMA",
    "TEMP_EMULATION_SCHEMA",
    "CDM_SOURCE_NAME",
    "CDM_VERSION"
)


Sys.setenv("CDM_CONNECTIONDETAILS_PASSWORD" =
    readChar("/run/secrets/CDM_CONNECTIONDETAILS_PASSWORD",
         file.info("/run/secrets/CDM_CONNECTIONDETAILS_PASSWORD")$size))

cdmConfig <- as.list(Sys.getenv(envVarNames, unset = NA))

DatabaseConnector::downloadJdbcDrivers(dbms = Sys.getenv("CDM_CONNECTIONDETAILS_DBMS"), pathToDriver = '/jdbc')
connectionDetails <- DatabaseConnector::createConnectionDetails(
    dbms = Sys.getenv("CDM_CONNECTIONDETAILS_DBMS"),
    user = Sys.getenv("CDM_CONNECTIONDETAILS_USER"),
    password = Sys.getenv("CDM_CONNECTIONDETAILS_PASSWORD"),
    server = Sys.getenv("CDM_CONNECTIONDETAILS_SERVER"),
    port = Sys.getenv("CDM_CONNECTIONDETAILS_PORT"),
    extraSettings = Sys.getenv("CDM_CONNECTIONDETAILS_EXTRA_SETTINGS"),
    pathToDriver = "/jdbc"
)