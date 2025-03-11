# Manual Steps
# exec into webapi and create
# /tmp/SSLProperties.config

#cat << EOFE > /tmp/SSLConfig.properties
#trustStore=/tmp/keystore.jks
#trustStorePassword=changeit
#EOFE

# and
# /tmp/certificateSQLaaS.pem

wget https://repo1.maven.org/maven2/com/intersystems/intersystems-jdbc/3.10.2/intersystems-jdbc-3.10.2.jar
cp intersystems-jdbc-3.10.2.jar jdbc/none.jar

### NOW provision!

#docker-compose --env-file .env --profile webapi-from-git --profile content --profile hades --profile atlasdb --profile atlas-from-image up -d
#docker-compose --env-file .env --profile webapi-from-git --profile content --profile hades --profile atlasdb --profile atlas-from-image down


### Post Configuration
export IRIS_USER="SQLAdmin"
export IRIS_PASS="REDACTED"
export IRIS_JDBC="jdbc:IRIS://k8s-0a6bc2ca-a2668ebb-2be01ed66b-df29055c4af0630d.elb.us-east-2.amazonaws.com:443/USER/:::true"
export IRIS_DESCRIPTION="InterSystems OMOP Stage"


## POST CONFIGURATION
cat << 'EOF' > certificateSQLaaS.pem
-----BEGIN CERTIFICATE-----
HBLABLAHBLAHBLA
-----END CERTIFICATE-----
EOF


docker-compose --env-file .env --profile webapi-from-git --profile content --profile hades --profile atlasdb --profile atlas-from-image up -d

cat << EOF > 200_populate_iris_source_daimon.sql
INSERT INTO webapi.source( source_id, source_name, source_key, source_connection, source_dialect, username, password)
VALUES (2, '$IRIS_DESCRIPTION', 'IRIS', '$IRIS_JDBC', 'iris', '$IRIS_USER', '$IRIS_PASS');
INSERT INTO webapi.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (4, 2, 0, 'OMOPCDM54', 0);
INSERT INTO webapi.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (5, 2, 1, 'OMOPCDM54', 10);
INSERT INTO webapi.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (6, 2, 2, 'OMOPCDM54_RESULTS', 0);
EOF

docker cp 200_populate_iris_source_daimon.sql broadsea-atlasdb:/docker-entrypoint-initdb.d/200_populate_iris_source_daimon.sql
docker-compose exec broadsea-atlasdb psql -U postgres -f "/docker-entrypoint-initdb.d/200_populate_iris_source_daimon.sql"
# 
cat << EOFD > SSLConfigHades.properties
trustStore=/home/ohdsi/keystore.jks
trustStorePassword=changeit
EOFD

docker cp certificateSQLaaS.pem broadsea-hades:/home/ohdsi/
docker cp SSLConfigHades.properties broadsea-hades:/home/ohdsi/SSLConfig.properties

docker-compose exec broadsea-hades bash -c "/usr/bin/keytool -importcert -file /home/ohdsi/certificateSQLaaS.pem -keystore /home/ohdsi/keystore.jks -alias IRIScert -storepass changeit -noprompt"

#docker cp certificateSQLaaS.pem ohdsi-webapi:/tmp/
#docker cp SSLConfig.properties ohdsi-webapi:/tmp/
docker exec ohdsi-webapi bash -c "keytool -importcert -file /tmp/certificateSQLaaS.pem -alias IRIScert2 -keystore /tmp/keystore.jks -storepass changeit -noprompt"

wget http://127.0.0.1/WebAPI/source/refresh/

# update.packages(ask = FALSE)
# downloadJdbcDrivers( "iris", pathToDriver = Sys.getenv("DATABASECONNECTOR_JAR_FOLDER"), method = "auto" )

#downloadJdbcDrivers( postgres, pathToDriver = Sys.getenv("DATABASECONNECTOR_JAR_FOLDER"), method = "auto" )
#wget https://repo1.maven.org/maven2/com/intersystems/intersystems-jdbc/3.10.2/intersystems-jdbc-3.10.2.jar
docker cp intersystems-jdbc-3.10.2.jar broadsea-hades:/opt/hades/jdbc_drivers/
#cp intersystems-jdbc-3.10.2.jar jdbc/none.jar