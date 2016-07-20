-- remove any previously added database connection configuration data
truncate ohdsi.source;
truncate ohdsi.source_daimon;

-- OHDSI CDM source
INSERT INTO ohdsi.source( source_id, source_name, source_key, source_connection, source_dialect)
VALUES (1, 'OHDSI CDM V5 Database', 'OHDSI-CDMV5',
  'jdbc:oracle:thin:secret-user-name/secret-user-password@192.168.99.100:1521:secret-database-name', 'oracle');

-- CDM daimon
INSERT INTO ohdsi.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (1, 1, 0, 'CDM', 2);

-- VOCABULARY daimon
INSERT INTO ohdsi.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (2, 1, 1, 'CDM', 2);

-- RESULTS daimon
INSERT INTO ohdsi.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (3, 1, 2, 'OHDSI', 2);

-- EVIDENCE daimon
INSERT INTO ohdsi.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (4, 1, 3, 'OHDSI', 2);
