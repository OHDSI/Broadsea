source("/postprocessing/init.R")

envVarNames <- list(
    "DQD_NUM_THREADS",
    "DQD_SQL_ONLY",
    "DQD_SQL_ONLY_UNION_COUNT",
    "DQD_SQL_ONLY_INCREMENTAL_INSERT",
    "DQD_VERBOSE_MODE",
    "DQD_WRITE_TO_TABLE",
    "DQD_WRITE_TABLE_NAME",
    "DQD_WRITE_TO_CSV",
    "DQD_CSV_FILE",
    "DQD_CHECK_LEVELS",
    "DQD_CHECK_NAMES",
    "DQD_COHORT_DEFINITION_ID",
    "DQD_COHORT_DATABASE_SCHEMA",
    "DQD_COHORT_TABLE_NAME",
    "DQD_TABLES_TO_EXCLUDE",
    "DQD_TABLE_CHECK_THRESHOLD_LOC",
    "DQD_FIELD_CHECK_THRESHOLD_LOC",
    "DQD_CONCEPT_CHECK_THRESHOLD_LOC"
)

jobConfig <- as.list(Sys.getenv(envVarNames, unset = NA))

outputFolder <- file.path("/postprocessing",
    "dqd",
    "data",
    cdmConfig$CDM_DATABASE_SCHEMA
)

if (!file.exists(outputFolder)) {
    dir.create(path = outputFolder, recursive = TRUE)
}

if (jobConfig$DQD_COHORT_DEFINITION_ID == "") {
    jobConfig$DQD_COHORT_DEFINITION_ID <- c()
}

result <- DataQualityDashboard::executeDqChecks(connectionDetails = connectionDetails,
                                                cdmDatabaseSchema = cdmConfig$CDM_DATABASE_SCHEMA,
                                                resultsDatabaseSchema = cdmConfig$RESULTS_DATABASE_SCHEMA,
                                                vocabDatabaseSchema = cdmConfig$VOCAB_DATABASE_SCHEMA,
                                                cdmSourceName = cdmConfig$CDM_SOURCE_NAME,
                                                numThreads = as.numeric(jobConfig$DQD_NUM_THREADS),
                                                sqlOnly = as.logical(jobConfig$DQD_SQL_ONLY),
                                                sqlOnlyUnionCount = as.numeric(jobConfig$DQD_SQL_ONLY_UNION_COUNT),
                                                sqlOnlyIncrementalInsert = as.logical(jobConfig$DQD_SQL_ONLY_INCREMENTAL_INSERT),
                                                outputFolder = outputFolder,
                                                outputFile = "dq-result_camel.json",
                                                verboseMode = as.logical(jobConfig$DQD_VERBOSE_MODE),
                                                writeToTable = as.logical(jobConfig$DQD_WRITE_TO_TABLE),
                                                writeTableName = jobConfig$DQD_WRITE_TABLE_NAME,
                                                writeToCsv = as.logical(jobConfig$DQD_WRITE_TO_CSV),
                                                csvFile = jobConfig$DQD_CSV_FILE,
                                                checkLevels = (strsplit(x = jobConfig$DQD_CHECK_LEVELS, split = ",", fixed = TRUE))[[1]],
                                                checkNames = (strsplit(x = jobConfig$DQD_CHECK_NAMES, split = ",", fixed = TRUE))[[1]],
                                                cohortDefinitionId = jobConfig$DQD_COHORT_DEFINITION_ID,
                                                cohortDatabaseSchema = jobConfig$DQD_COHORT_DATABASE_SCHEMA,
                                                cohortTableName = jobConfig$DQD_COHORT_TABLE_NAME,
                                                tablesToExclude = (strsplit(x = jobConfig$DQD_TABLES_TO_EXCLUDE, split = ",", fixed = TRUE))[[1]],
                                                cdmVersion = cdmConfig$CDM_VERSION,
                                                tableCheckThresholdLoc = jobConfig$DQD_TABLE_CHECK_THRESHOLD_LOC,
                                                fieldCheckThresholdLoc = jobConfig$DQD_FIELD_CHECK_THRESHOLD_LOC,
                                                conceptCheckThresholdLoc = jobConfig$DQD_CONCEPT_CHECK_THRESHOLD_LOC)


DataQualityDashboard::convertJsonResultsFileCase(jsonFilePath = file.path(outputFolder, "dq-result_camel.json"),
                                                 writeToFile = TRUE,
                                                 outputFolder = outputFolder,
                                                 outputFile = "dq-result.json",
                                                 targetCase = "snake")