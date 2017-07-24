# Additional Notes for Running Impala

## Creating missing tables

Some extra and otherwise missing tables need to be created in Impala, as discussed [here](https://github.com/OHDSI/Atlas/issues/418#issuecomment-313421472).

```bash
impala-shell omop_cdm -f multiple_datasets.sql
```

## Using PostgreSQL for OHDSI tables

The OHDSI tables are stored in PostgreSQL, not Impala, since the latter doesn't support JPA, Flyway etc.

You can create a suitable PostgreSQL database using Docker as follows:

```bash
docker pull postgres
docker run --name postgresql -itd -p 5432:5432 postgres
docker cp create_postgres_db.sql postgresql:/create_postgres_db.sql
docker exec -it postgresql /bin/sh -c "su - -c 'psql -f /create_postgres_db.sql' postgres"
```

To run _source_source_daimon.sql_ (after the step in the main documentation where you stop the Broadsea containers) do the following:

```bash
docker cp source_source_daimon.sql postgresql:/source_source_daimon.sql
docker exec -it postgresql /bin/sh -c "su - -c 'psql -f /source_source_daimon.sql -d ohdsi' postgres"
```

