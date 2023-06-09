envVarNames <- list(
    "ACHILLES_JDBC_URL",
    "ACHILLES_CDM_USERNAME",
    "ACHILLES_CDM_PASSWORD",
    "ACHILLES_SOURCE_NAME",
    "ACHILLES_CDM_DATABASE_SCHEMA",
    "ACHILLES_SCRATCH_DATABASE_SCHEMA",
    "ACHILLES_RESULTS_DATABASE_SCHEMA",
    "ACHILLES_VOCAB_DATABASE_SCHEMA",
    "ACHILLES_TEMP_EMULATION_SCHEMA",
    "ACHILLES_ANALYSIS_IDS",
    "ACHILLES_CREATE_TABLE",
    "ACHILLES_SMALL_CELL_COUNT",
    "ACHILLES_CDM_VERSION",
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

envVars <- as.list(Sys.getenv(envVarNames, unset = NA))

envVars$ACHILLES_NUM_THREADS <- as.numeric(envVars$ACHILLES_NUM_THREADS)
envVars$ACHILLES_SQL_ONLY <- as.logical(envVars$ACHILLES_SQL_ONLY)
envVars$ACHILLES_CREATE_INDICES <- as.logical(envVars$ACHILLES_CREATE_INDICES)
envVars$ACHILLES_CREATE_TABLE <- as.logical(envVars$ACHILLES_CREATE_TABLE)
envVars$ACHILLES_DROP_SCRATCH_TABLES <- as.logical(envVars$ACHILLES_DROP_SCRATCH_TABLES)

connectionDetails <- DatabaseConnector::createConnectionDetails(
    dbms = Sys.getenv("ACHILLES_SQL_DIALECT"),
    user = Sys.getenv("ACHILLES_CDM_USERNAME"),
    password = Sys.getenv("ACHILLES_CDM_PASSWORD"),
    connectionString = Sys.getenv("ACHILLES_JDBC_URL"),
    pathToDriver = "/jdbc"
)

achillesWrapper <- function(connectionDetails,
                            sourceName,
                            cdmDatabaseSchema,
                            scratchDatabaseSchema,
                            resultsDatabaseSchema,
                            vocabDatabaseSchema,
                            tempEmulationSchema,
                            analysisIds,
                            createTable,
                            smallCellCount,
                            cdmVersion,
                            createIndices,
                            numThreads,
                            tempAchillesPrefix,
                            dropScratchTables,
                            verboseMode,
                            optimizeAtlasCache,
                            defaultAnalysesOnly,
                            updateGivenAnalysesOnly,
                            excludeAnalysisIds,
                            sqlOnly,
                            sqlDialect,
                            outputFolder) {
    Achilles::achilles(
        connectionDetails = connectionDetails,
        sourceName = sourceName,
        cdmDatabaseSchema = cdmDatabaseSchema,
        scratchDatabaseSchema = scratchDatabaseSchema,
        resultsDatabaseSchema = resultsDatabaseSchema,
        vocabDatabaseSchema = vocabDatabaseSchema,
        tempEmulationSchema = tempEmulationSchema,
        analysisIds = analysisIds,
        createTable = createTable,
        smallCellCount = smallCellCount,
        cdmVersion = cdmVersion,
        createIndices = createIndices,
        numThreads = numThreads,
        tempAchillesPrefix = tempAchillesPrefix,
        dropScratchTables = dropScratchTables,
        verboseMode = verboseMode,
        optimizeAtlasCache = optimizeAtlasCache,
        defaultAnalysesOnly = defaultAnalysesOnly,
        updateGivenAnalysesOnly = updateGivenAnalysesOnly,
        excludeAnalysisIds = excludeAnalysisIds,
        sqlOnly = sqlOnly,
        sqlDialect = sqlDialect,
        outputFolder = outputFolder)
}