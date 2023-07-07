source("/postprocessing/init.R")

envVarNames <- list(
    "ARES_CONNECTIONDETAILS_DBMS",
    "ARES_CONNECTIONDETAILS_USER",
    "ARES_CONNECTIONDETAILS_PASSWORD",
    "ARES_CONNECTIONDETAILS_SERVER",
    "ARES_CONNECTIONDETAILS_PORT",
    "ARES_CONNECTIONDETAILS_EXTRA_SETTINGS",
    "ARES_CDM_DATABASE_SCHEMA",
    "ARES_RESULTS_DATABASE_SCHEMA",
    "ARES_VOCAB_DATABASE_SCHEMA",
    "ARES_SQL_DIALECT",
    "ARES_RUN_NETWORK"
)

jobConfig <- as.list(Sys.getenv(envVarNames, unset = NA))

aresDataRoot <- "/postprocessing/ares"
releaseKey <- AresIndexer::getSourceReleaseKey(connectionDetails = connectionDetails,
                                               cdmDatabaseSchema = cdmConfig$CDM_DATABASE_SCHEMA)
datasourceReleaseOutputFolder <- file.path(aresDataRoot, releaseKey)

if (!dir.exists(datasourceReleaseOutputFolder)) {
    dir.create(path = datasourceReleaseOutputFolder, recursive = TRUE)
}

# copy DQD results JSON file to this folder ------------

dqdFilePath <- file.path("/postprocessing",
    "dqd",
    "data",
    cdmConfig$CDM_DATABASE_SCHEMA,
    "dq-result.json"
)
file.copy(from = dqdFilePath, to = file.path(datasourceReleaseOutputFolder, "dq-result.json"), overwrite = TRUE)

Achilles::exportToAres(connectionDetails = connectionDetails,
                       cdmDatabaseSchema = cdmConfig$CDM_DATABASE_SCHEMA,
                       resultsDatabaseSchema = cdmConfig$RESULTS_DATABASE_SCHEMA,
                       vocabDatabaseSchema = cdmConfig$VOCAB_DATABASE_SCHEMA,
                       outputPath = aresDataRoot,
                       reports = c())


# perform temporal characterization ------------

outputFile <- file.path(datasourceReleaseOutputFolder, "temporal-characterization.csv")
Achilles::performTemporalCharacterization(connectionDetails = connectionDetails,
                                          cdmDatabaseSchema = cdmConfig$CDM_DATABASE_SCHEMA,
                                          resultsDatabaseSchema = cdmConfig$RESULTS_DATABASE_SCHEMA,
                                          outputFile = outputFile)

# augment concept files with temporal characterization data ---------------

AresIndexer::augmentConceptFiles(releaseFolder = file.path(aresDataRoot, releaseKey))


if (as.logical(jobConfig$ARES_RUN_NETWORK)) {
    sourceFolders <- list.dirs(aresDataRoot, recursive = FALSE)
    AresIndexer::buildNetworkIndex(sourceFolders = sourceFolders, outputFolder = aresDataRoot)
    AresIndexer::buildDataQualityIndex(sourceFolders = sourceFolders, outputFolder = aresDataRoot)
    AresIndexer::buildNetworkUnmappedSourceCodeIndex(sourceFolders = sourceFolders, outputFolder = aresDataRoot)
}