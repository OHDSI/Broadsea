FROM rocker/hadleyverse
MAINTAINER Marc A. Suchard <msuchard@ucla.edu>

## Install OHDSI R packages
RUN installGithub.r \
	OHDSI/SqlRender \
	OHDSI/DatabaseConnector \
	OHDSI/Cyclops \
	OHDSI/CohortMethod \
	OHDSI/PublicOracle \
&& rm -rf /tmp/downloaded_packages/ /tmp/*.rds
