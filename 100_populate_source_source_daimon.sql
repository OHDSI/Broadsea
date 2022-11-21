-- remove any previously added database connection configuration data
truncate webapi.source;
truncate webapi.source_daimon;

-- OHDSI CDM source
INSERT INTO webapi.source( source_id, source_name, source_key, source_connection, source_dialect)
VALUES (1, 'OHDSI Eunomia Demo Database', 'EUNOMIA',
  'jdbc:postgresql://broadsea-atlasdb:5432/postgres?user=postgres&password=mypass', 'postgresql');

-- CDM daimon
INSERT INTO webapi.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (1, 1, 0, 'demo_cdm', 0);

-- VOCABULARY daimon
INSERT INTO webapi.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (2, 1, 1, 'demo_cdm', 10);

-- RESULTS daimon
INSERT INTO webapi.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (3, 1, 2, 'demo_cdm_results', 0);

-- EVIDENCE daimon - no evidence data to load in demo dataset
-- INSERT INTO webapi.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (4, 1, 3, 'demo_cdm_results', 0);
