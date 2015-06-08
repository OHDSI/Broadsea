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

## Install Rserve
RUN install2.r \
	Rserve \
&& rm -rf /tmp/download_packages/ /tmp/*.rds

ADD Rserv.conf /etc/Rserv.conf
ADD startRserve.R /usr/local/bin/startRserve.R

EXPOSE 6311

