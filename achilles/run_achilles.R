source("/postprocessing/init.R")

envVarNames <- list(
    "ACHILLES_ANALYSIS_IDS",
    "ACHILLES_CREATE_TABLE",
    "ACHILLES_SMALL_CELL_COUNT",
    "ACHILLES_CREATE_INDICES",
    "ACHILLES_NUM_THREADS",
    "ACHILLES_TEMP_ACHILLES_PREFIX",
    "ACHILLES_DROP_SCRATCH_TABLES",
    "ACHILLES_VERBOSE_MODE",
    "ACHILLES_OPTIMIZE_ATLAS_CACHE",
    "ACHILLES_DEFAULT_ANALYSES_ONLY",
    "ACHILLES_UPDATE_GIVEN_ANALYSES_ONLY",
    "ACHILLES_EXCLUDE_ANALYSIS_IDS",
    "ACHILLES_SQL_ONLY",
    "ACHILLES_SQL_DIALECT"
)

jobConfig <- as.list(Sys.getenv(envVarNames, unset = NA))

outputFolder <- file.path("/postprocessing",
    "achilles",
    "data",
    cdmConfig$CDM_DATABASE_SCHEMA
)

if (!file.exists(outputFolder)) {
    dir.create(path = outputFolder, recursive = TRUE)
}

# handle analysis ids ----------------------------------------------------
if (jobConfig$ACHILLES_ANALYSIS_IDS == "") {
  jobConfig$ACHILLES_ANALYSIS_IDS <- (Achilles::getAnalysisDetails())$ANALYSIS_ID
} else {
  jobConfig$ACHILLES_ANALYSIS_IDS <- as.numeric((strsplit(x = jobConfig$ACHILLES_ANALYSIS_IDS, split = ",", fixed = T))[[1]])
}

result <- Achilles::achilles(
    connectionDetails = connectionDetails,
    sourceName = cdmConfig$ACHILLES_SOURCE_NAME,
    cdmDatabaseSchema = cdmConfig$CDM_DATABASE_SCHEMA,
    scratchDatabaseSchema = cdmConfig$SCRATCH_DATABASE_SCHEMA,
    resultsDatabaseSchema = cdmConfig$RESULTS_DATABASE_SCHEMA,
    vocabDatabaseSchema = cdmConfig$VOCAB_DATABASE_SCHEMA,
    tempEmulationSchema = cdmConfig$TEMP_EMULATION_SCHEMA,
    analysisIds = jobConfig$ACHILLES_ANALYSIS_IDS,
    createTable = as.logical(jobConfig$ACHILLES_CREATE_TABLE),
    smallCellCount = as.numeric(jobConfig$ACHILLES_SMALL_CELL_COUNT),
    cdmVersion = cdmConfig$CDM_VERSION,
    createIndices = as.logical(jobConfig$ACHILLES_CREATE_INDICES),
    numThreads = as.numeric(jobConfig$ACHILLES_NUM_THREADS),
    tempAchillesPrefix = jobConfig$ACHILLES_TEMP_ACHILLES_PREFIX,
    dropScratchTables = as.logical(jobConfig$ACHILLES_DROP_SCRATCH_TABLES),
    verboseMode = jobConfig$ACHILLES_VERBOSE_MODE,
    optimizeAtlasCache = jobConfig$ACHILLES_OPTIMIZE_ATLAS_CACHE,
    defaultAnalysesOnly = jobConfig$ACHILLES_DEFAULT_ANALYSES_ONLY,
    updateGivenAnalysesOnly = jobConfig$ACHILLES_UPDATE_GIVEN_ANALYSES_ONLY,
    excludeAnalysisIds = jobConfig$ACHILLES_EXCLUDE_ANALYSIS_IDS,
    sqlOnly = as.logical(jobConfig$ACHILLES_SQL_ONLY),
    sqlDialect = connectionDetails$dbms,
    outputFolder = outputFolder
)