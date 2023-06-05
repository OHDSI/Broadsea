source("/achilles/scripts/set_vars.R")

outputFolder <- file.path("/achilles",
    "data",
    envVars$ACHILLES_CDM_DATABASE_SCHEMA
)

if (!file.exists(outputFolder)) {
    dir.create(path = outputFolder, recursive = TRUE)
}

result <- achillesWrapper(
    connectionDetails = connectionDetails,
    sourceName = envVars$ACHILLES_SOURCE_NAME,
    cdmDatabaseSchema = envVars$ACHILLES_CDM_DATABASE_SCHEMA,
    scratchDatabaseSchema = envVars$ACHILLES_SCRATCH_DATABASE_SCHEMA,
    resultsDatabaseSchema = envVars$ACHILLES_RESULTS_DATABASE_SCHEMA,
    vocabDatabaseSchema = envVars$ACHILLES_VOCAB_DATABASE_SCHEMA,
    tempEmulationSchema = envVars$ACHILLES_TEMP_EMULATION_SCHEMA,
    analysisIds = envVars$ACHILLES_ANALYSIS_IDS,
    createTable = envVars$ACHILLES_CREATE_TABLE,
    smallCellCount = envVars$ACHILLES_SMALL_CELL_COUNT,
    cdmVersion = envVars$ACHILLES_CDM_VERSION,
    createIndices = envVars$ACHILLES_CREATE_INDICES,
    numThreads = envVars$ACHILLES_NUM_THREADS,
    tempAchillesPrefix = envVars$ACHILLES_TEMP_ACHILLES_PREFIX,
    dropScratchTables = envVars$ACHILLES_DROP_SCRATCH_TABLES,
    verboseMode = envVars$ACHILLES_VERBOSE_MODE,
    optimizeAtlasCache = envVars$ACHILLES_OPTIMIZE_ATLAS_CACHE,
    defaultAnalysesOnly = envVars$ACHILLES_DEFAULT_ANALYSES_ONLY,
    updateGivenAnalysesOnly = envVars$ACHILLES_UPDATE_GIVEN_ANALYSES_ONLY,
    excludeAnalysisIds = envVars$ACHILLES_EXCLUDE_ANALYSIS_IDS,
    sqlOnly = envVars$ACHILLES_SQL_ONLY,
    sqlDialect = connectionDetails$dbms,
    outputFolder = outputFolder
)