INSERT INTO webapi.source( source_id, source_name, source_key, source_connection, source_dialect, username, password)
VALUES (2, 'InterSystems OMOP Stage', 'IRIS', 'jdbc:IRIS://k8s-0a6bc2ca-a2668ebb-2be01ed66b-df29055c4af0630d.elb.us-east-2.amazonaws.com:443/USER/:::true', 'iris', 'SQLAdmin', 'REDACTED');
INSERT INTO webapi.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (4, 2, 0, 'OMOPCDM54', 0);
INSERT INTO webapi.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (5, 2, 1, 'OMOPCDM54', 10);
INSERT INTO webapi.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (6, 2, 2, 'OMOPCDM54_RESULTS', 0);
