# OHDSI Broadsea 3.1

[![default profile](https://github.com/OHDSI/Broadsea/actions/workflows/default.yml/badge.svg?branch=develop)](https://github.com/OHDSI/Broadsea/actions/workflows/default.yml) [![perseus profile](https://github.com/OHDSI/Broadsea/actions/workflows/perseus.yml/badge.svg?branch=develop)](https://github.com/OHDSI/Broadsea/actions/workflows/perseus.yml) [![openldap profile](https://github.com/OHDSI/Broadsea/actions/workflows/openldap.yml/badge.svg?branch=develop)](https://github.com/OHDSI/Broadsea/actions/workflows/openldap.yml) [![solr-vocab Profile](https://github.com/OHDSI/Broadsea/actions/workflows/solr-vocab.yml/badge.svg?branch=develop)](https://github.com/OHDSI/Broadsea/actions/workflows/solr-vocab.yml) [![achilles Profile](https://github.com/OHDSI/Broadsea/actions/workflows/achilles.yml/badge.svg?branch=develop)](https://github.com/OHDSI/Broadsea/actions/workflows/achilles.yml)

## Introduction

Broadsea runs the core OHDSI technology stack using cross-platform Docker container technology.

[Information on Observational Health Data Sciences and Informatics (OHDSI)](http://www.ohdsi.org/ "OHDSI Website")

This repository contains the Docker Compose file used to launch the OHDSI Broadsea Docker containers:

-   OHDSI R HADES - in RStudio Server
    -   [OHDSI Broadsea R HADES GitHub repository](https://github.com/OHDSI/Broadsea-Hades/ "OHDSI Broadsea R HADES GitHub Repository")
    -   [OHDSI Broadsea R HADES Docker Hub container image](https://hub.docker.com/r/ohdsi/broadsea-hades "OHDSI Broadsea HADES Docker Image Repository")
-   OHDSI Atlas - including WebAPI REST services
    -   [Atlas GitHub repository](https://github.com/OHDSI/Atlas "OHDSI Atlas GitHub Repository")
    -   [Atlas Docker Hub container image](https://hub.docker.com/r/ohdsi/atlas "OHDSI Atlas Docker Image Repository")
    -   [WebAPI GitHub repository](https://github.com/OHDSI/WebAPI "OHDSI WebAPI GitHub Repository")
    -   [WebAPI Docker Hub container image](https://hub.docker.com/r/ohdsi/webapi "OHDSI WebAPI Docker Image Repository")
    -   [Atlas application PostgreSQL database GitHub repository](https://github.com/OHDSI/Broadsea-Atlasdb "OHDSI Broadsea Atlas application PostgreSQL database GitHub Repository")cac
    -   [Atlas application PostgreSQL databbase Docker Hub container image](https://hub.docker.com/repository/docker/ohdsi/broadsea-atlasdb "OHDSI Broadsea Atlas application PostgreSQL database Docker Image Repository")
    -   SOLR based OMOP Vocab search
-   OHDSI Ares
    -   [Ares GitHub repository](https://github.com/OHDSI/Ares "OHDSI Ares GitHub Repository")
-   OHDSI Perseus (Experimental)
    -   [Perseus GitHub repository](https://github.com/OHDSI/Perseus "OHDSI Perseus GitHub Repository")

Additionally, Broadsea offers limited support for services not specifically needed for OHDSI applications that often are useful:

-   OpenLDAP for testing security in Atlas
-   Open Shiny Server for deploying Shiny apps without a commercial license
-   Posit Connect for sites with commercial Posit licenses, for deploying Shiny apps
-   DBT for ETL design

### Broadsea Dependencies

-   Linux, Mac, or Windows with WSL
-   Docker
-   Git
-   Chromium-based web browser (Chrome, Edge, etc.)

### Mac Silicon

If using Mac Silicon (M1, M2), you **may** need to set the DOCKER_ARCH variable in Section 1 of the .env file to "linux/arm64". Some Broadsea services still need to run via emulation of linux/amd64 and are hard-coded as such.

## Broadsea - Quick start

-   Download and install Docker. See the installation instructions at the [Docker Web Site](https://docs.docker.com/engine/installation/ "Install Docker")
-   git clone this GitHub repo:

```         
git clone https://github.com/OHDSI/Broadsea.git
```

-   In a command line / terminal window - navigate to the directory where this README.md file is located and start the Broadsea Docker Containers using the below command. On Linux you may need to use 'sudo' to run this command. Wait up to one minute for the Docker containers to start. The docker compose pull command ensures that the latest released versions of the OHDSI ATLAS and OHDSI WebAPI docker containers are downloaded.

```         
docker-compose --profile default up -d
```

-   In your web browser open the URL: `"http://127.0.0.1"`
-   Click on the Atlas link to open Atlas in a new browser window
-   Click on the Hades link to open HADES (RStudio) in a new browser window.
    -   The default RStudio userid is 'ohdsi' and the default password is located in the `./secrets/hades/HADES_PASSWORD` file.

## Broadsea - Advanced Usage

### .env file

The .env file that comes with Broadsea has default and sample values. For advanced use, modify the values as appropriate, as covered below.

### Docker Secrets

Broadsea now leverages [Docker Secrets](https://docs.docker.com/engine/swarm/secrets/ "Docker Secrets") to handle sensitive passwords and secret keys.

*(In Broadsea 3.0, these were handled via plain-text environment variables, which is not best security practice)*

Now in Broadsea 3.1, each sensitive password or secret key is to be stored in a file; the paths to these files is then set in the .env file per Section. Please refer to the default `./secrets` folder for examples on how to set up these files for your site.

#### Run Broadsea on a remote server

In Section 1 of the .env file, set BROADSEA_HOST as the IP address or host name **(without http/https)** of the remote server.

### Docker profiles

This docker compose file makes use of [Docker profiles](https://docs.docker.com/compose/profiles/ "Docker Profiles") to allow for either a full default deployment ("default"), or a more a-la-carte approach in which you can pick and choose which services you'd like to deploy.

You can use this syntax for this approach, substituting profile names in:

```         
docker-compose --profile profile1 --profile profile2 .... up -d
```

Here are the profiles available:

-   default
    -   atlas ("/atlas")
    -   WebAPI ("/WebAPI")
    -   AtlasDB (a Postgres instance for Atlas/WebAPI)
    -   HADES ("/hades")
    -   A splash page for Broadsea ("/")
-   atlas-from-image
    -   Pulls the standard Atlas image from Docker Hub
-   atlas-from-git
    -   Builds Atlas from a Git repo
    -   Useful for testing new versions of Atlas that aren't in Docker Hub
-   webapi-from-image:
    -   Pulls the standard WebAPI image from Docker Hub
    -   Mac Silicon users, see "Mac Silicon" section above
-   webapi-from-git
    -   Builds WebAPI from a Git repo
    -   Useful for testing new versions of WebAPI that aren't in Docker Hub
    -   Mac Silicon users, see "Mac Silicon" section above
-   atlasdb
    -   Pulls the standard Atlas DB image, a Postgres instance for Atlas/WebAPI
    -   Useful if you do not have an existing Postgres instance for Atlas/WebAPI
-   solr-vocab-no-import
    -   Pulls the standard SOLR image from Docker Hub
    -   Initializes a core for the OMOP Vocabulary specified in the .env file
    -   No data is imported into the core, left to you to run through the SOLR Admin GUI at "/solr"
-   solr-vocab-with-import
    -   Pulls the standard SOLR image from Docker Hub
    -   Initializes a core for the OMOP Vocabulary specified in the .env file
    -   Runs the data import for that core
    -   Once complete, the solr-run-import container will finish with an exit status; you can remove this container
-   ares
    -   Builds Ares web app from Ares GitHub repo
    -   Exposes a volume mount point for adding Ares files (see [Ares GitHub IO page](https://ohdsi.github.io/Ares/ "Ares GitHub IO"))
-   content
    -   A splash page for Broadsea ("/broadsea")
-   omop-vocab-pg-load
    -   Using OMOP Vocab files downloaded from Athena, this can load them into a Postgres instance (can be Broadsea's atlasdb or an external one)
    -   Rebuilds the CPTs using the CPT jar file from Athena, with UMLS API Key (see .env file Section 9)
    -   Creates the schema if necessary
    -   Runs copy command for each vocabulary CSV file
    -   Creates all necessary Postgres indices
    -   Once complete, the omop-vocab-load container will finish with an exit status; you can remove this container
-   phoebe-pg-load
    -   For Atlas 2.12+, which offers Concept Recommendation options based on the [Phoebe project](https://forums.ohdsi.org/t/phoebe-2-0/17410 "Phoebe Project")
    -   Loads Phoebe files into an existing OMOP Vocabulary hosted in a Postgres instance (can be Broadsea's atlasdb or an external one)
    -   Note: your Atlas instance must use this OMOP Vocabulary as its default vocabulary source in order to use this feature
    -   Once complete, the phoebe-load container will finish with an exit status; you can remove this container
-   openldap
    -   For testing security in Atlas, this Open LDAP container can be used to assess security needs
    -   You can specify a comma separated list of user ids and passwords
    -   This is not recommended for any production level setup
-   open-shiny-server
    -   An open source version of Shiny Server, where you can drop shiny apps into a mounted folder.
    -   Recommended if your organization does not have a Posit Connect license.
-   posit-connect
    -   For sites with commercial Posit Connect licenses, this can be useful for convenient publication of Shiny apps
-   cdm-postprocessing
    -   For a specified CDM database, executes Achilles and DataQualityDashboard, then AresIndexer
    -   Useful for Atlas Data Sources reports and populating the files needed for the Ares application
-   achilles
    -   Executes only Achilles for a specified CDM database
-   dqd
    -   Executes only DataQualityDashboard for a specified CDM database
-   aresindexer
    -   Executes only AresIndexer for a specified CDM database
    -   Only run this if Achilles and DataQualityDashboard have been executed
-   dbt
    -   Sets up the dbt command-line tool for ETL design
-   perseus
    -   Experimental in this version
    -   Deploys the entire Perseus stack of services, but in the Broadsea network
    -   Services include:
    -   Currently, does have overlapping capabilities (e.g. Solr, OMOP Vocab on Postgres)
-   perseus-shareddb
    -   Deploys only the shareddb Postgres backend for Perseus
-   perseus-files-manager
    -   Deploys only the files-manager backend for Perseus
-   perseus-web
    -   Deploys only the web server for Perseus
-   perseus-user
    -   Deploys only the user management system for Perseus
-   perseus-backend
    -   Deploys only the API backend for Perseus
-   perseus-frontend
    -   Deploys only the Perseus web application
-   perseus-vocabularydb
    -   Deploys only the Vocabulary Postgres for Perseus
-   perseus-cdm-builder
    -   Deploys only the CDM Builder tool for Perseus
-   perseus-solr
    -   Deploys only the Solr instance for Perseus
-   perseus-athena
    -   Deploys only the Athena instance for Perseus
-   perseus-usagi
    -   Deploys only the Usagi instance for Perseus
-   perseus-r-serve
    -   Deploys the R Server instance for Perseus
-   perseus-dqd
    -   Deploys the DataQualityDashboard instance for Perseus
-   perseus-swagger
    -   Deploys the Swagger instance for Perseus
-   perseus-white-rabbit
    -   Deploys the White Rabbit instance for Perseus

### Traefik Dashboard

Broadsea uses Traefik as a proxy for all containers within. The traefik dashboard is enabled by default at `/dashboard`, and can be useful for debugging the proxy network.

### SSL

Traefik can be set up with SSL to enable HTTPS:

1.  Obtain a crt and key file. Rename them to "broadsea.crt" and "broadsea.key", respectively.
2.  In Section 1 of the .env file:

-   Update the BROADSEA_CERTS_FOLDER to the folder that holds these cert files.
-   Update the HTTP_TYPE to "https"

### Broadsea Content Page

To adjust which app links to display on the Broadsea content page ("/"), refer to Section 12 of the .env file. Use "show" to display the div or "none" to hide it.

### Vocabulary Loading

#### OMOP Vocabulary in Postgres

To load a new OMOP Vocabulary into a Postgres schema, review and fill out Section 9 of the .env file. Please note: this service will attempt to run the CPT4 import process for the CONCEPT table, so you will need a UMLS API Key from https://uts.nlm.nih.gov/uts/profile; store this in a file and set the path to the file as UMLS_API_KEY_FILE.

The Broadsea atlasdb Postgres instance is listed by default, but you can use an external Postgres instance. You need to copy your Athena downloaded files into ./omop_vocab/files.

#### Build SOLR Vocab for Atlas

To enable the use of SOLR for fast OMOP Vocab search in Atlas, review and fill out Section 7 of the .env file. You can either point to an existing SOLR instance, or have Broadsea build one. The JDBC jar file is needed in the Broadsea root folder in order for Solr to perform the dataimport step.

### OHDSI Web Applications

#### Atlas/WebAPI Security

To enable a security provider for authentication and identity management in Atlas/WebAPI, review and fill out Sections 4 and 5 in the .env file.

#### Bring Your Own Cacerts (Java Keystore) for LDAP and Snowflake connections

Some deployments require a Java Keystore (cacerts) file that establishes trust with Root Certificate Authorities for LDAP or Snowflake connections.

To allow this, overwrite the blank ./cacerts within the Broadsea directory with your own cacerts file. WebAPI can then leverage it for these external Java SSL connections.

For Snowflake, you will need to also set the CDM_SNOWFLAKE_PRIVATE_KEY_FILE env variable in Section 3.

#### Open LDAP

OpenLDAP is provided for testing purposes, and is not recommended for any production deployment. Refer to Section 13 of the .env file to establish user accounts (using secrets files) for this LDAP instance. A GUI-based LDAP explorer, such as [Apache Directory Studio](https://directory.apache.org/studio/ "Apache Directory Studio") is recommended for managing this instance.

#### Atlas/WebAPI from Git repo

To build either Atlas or WebAPI from a git repo instead of from Docker Hub, use Section 6 to specify the Git repo paths. Branches and commits can be in the URL after a "\#".

#### Phoebe Integration for Atlas

With Atlas 2.12.0 and above, a new concept recommendation feature is available, based upon the [Phoebe project](https://forums.ohdsi.org/t/phoebe-2-0/17410 "Phoebe Project"). Review and fill out Section 10 of the .env file to load the concept_recommended table needed for this feature into a Postgres hosted OMOP Vocabulary.

#### Ares Web Application

To mount files prepared for Ares (see [CDM Post Processing](#CDM-Post-Processing)), add your Ares data folder path to ARES_DATA_FOLDER in Section 11. By default, it will use the Broadsea shared volume `cdm-postprocessing-data/ares` used by the aresindexer service.

### CDM ETL Design and Execution

#### DBT

DBT provides a command-line tool for ETL design. See Section 16 for configuring DBT.

#### Perseus (Experimental)

Perseus offers a full suite of services for data profiling, vocabulary mapping, ETL design, and ETL execution. See Section 16 for configuring Perseus.

### CDM Post Processing {#cdm-post-processing}

Once you have a CDM database available, it is important to run summary level statistics and data quality analyses prior to publishing the source to users. Broadsea provides services for running Achilles, DataQualityDashboard, and AresIndexer. See Section 17 for setting up the CDM connection details and the various application settings needed.

### Evidence Generation

#### HADES in RStudio

The credentials for the RStudio user can be established in Section 8 of the .env file (with a password stored in a secrets file).

#### Sharing/Saving files between RStudio and Docker host machine

To permanently retain the "rstudio" user files in the "rstudio" user home directory, and make local R packages available to RStudio in the Broadsea Methods container the following steps are required:

-   In the same directory where the docker-compose.yml is stored create a sub-directory tree called "home/rstudio" and a sub-directory called "site-library"
-   **Set the file permissions for the "home/rstudio" sub-directory tree and the "site-library" sub-directory to public read, write and execute.**
-   Add the below volume mapping statements to the end of the broadsea-methods-library section of the docker-compose.yml file.

```         
volumes:
      - ./home/rstudio:/home/rstudio
      - ./site-library:/usr/local/lib/R/site-library
```

Any files added to the home/rstudio or site-library sub-directories on the Docker host can be accessed by RStudio in the container.

The Broadsea Methods container RStudio /usr/lib/R/site-library originally contains the "littler" and "rgl" R packages. Volume mapping masks the original files in the directory so you will need to add those 2 packages to your Docker host site-library sub-directory if you need them.

### Evidence Dissemination

#### Open Shiny Server

To configure an open-source Shiny Server, refer to Section 14 of the .env file. Use the OPEN_SHINY_SERVER_APP_ROOT variable to point to a folder that will host Shiny apps.

#### Posit Connect

The pattern for using Posit Connect deviates from the rest of Broadsea due to the many configuration options available. A sample .gcfg file is included, but you likely will need to make modifications to it. See [Posit Connect configuration guide](https://docs.posit.co/connect/admin/appendix/configuration "Posit Connect Configuration") for more information.

## Shutdown Broadsea

You can stop the running Docker containers & remove them (new container instances can be started again later) with this command:

```         
docker compose down
```

You can stop a profile specifically by using:

```         
docker compose --profile profilename down
```

## Broadsea Intended Uses

Broadsea can deploy the OHDSI stack on any of the following infrastructure alternatives:

-   laptop / desktop - Note: The Broadsea-Hades Docker container (RStudio server with OHDSI HADES R packages)
-   internally hosted server
-   cloud provider hosted server
-   cluster of servers (internally or cloud provider hosted)

It supports any database management system that the OHDSI stack supports, though some services are specific to Postgresql.

It supports any OS where Docker containers can run, including Windows, Mac OS X, and Linux (including Ubuntu, CentOS & CoreOS)

### Usage Scenarios:

Broadsea deploys the OHDSI technology stack at your local site so you can use it with your own data in an OMOP CDM Version 5 database.

it can be used for the following scenarios:

-   Try-out / demo the OHDSI R packages & web applications - Broadsea-Atlasdb contains the following artifacts for demos:
-   a tiny simulated patient demo dataset called 'Eunomia'
-   a simple concept set
-   a simple cohort definition\
-   Run observational studies on your data (including OHDSI Network studies)
-   Run the OHDSI Achilles R package for database profiling, database characterization, data quality assessment on your data & view the reports as tables/charts in the Atlas web application
-   Query OMOP vocabularies using the Atlas web application
-   Define and generate patient cohorts
-   Determine study feasibility based on defined criteria

------------------------------------------------------------------------

## Troubleshooting

### View the status of the running Docker containers:

```         
docker-compose ps
```

### Viewing Log Files

Logs per container are available using this syntax:

```         
docker logs containername
```

## Hardware/OS Requirements for Installing Docker

### Mac OS X

Follow the instructions here - [Install Docker for Mac](https://www.docker.com/products/docker#/mac)\
*Docker for Mac* includes both Docker Engine & Docker Compose

For Mac Silicon, you may need to enable "Use Rosetta for x86/amd64 emulation on Apple Silicon" in the "Features in Development" Settings menu.

### Mac OS X Requirements

Mac must be a 2010 or newer model, with Intel's hardware support for memory management unit (MMU) virtualization; i.e., Extended Page Tables (EPT) OS X 10.10.3 Yosemite or newer At least 4GB of RAM VirtualBox prior to version 4.3.30 must NOT be installed (it is incompatible with Docker for Mac). Docker for Mac will error out on install in this case. Uninstall the older version of VirtualBox and re-try the install.

### Windows

Follow the instructions here - [Install Docker for Windows](https://www.docker.com/products/docker#/windows)\
*Docker for Windows* includes both Docker Engine & Docker Compose

### Docker for Windows Requirements

64bit Windows 10 Pro, Enterprise and Education (1511 November update, Build 10586 or later). In the future Docker will support more versions of Windows 10. The Hyper-V package must be enabled. The Docker for Windows installer will enable it for you, if needed. (This requires a reboot).

Note. *Docker for Windows* is the preferred Docker environment for Broadsea, but *Docker-Toolbox* may be used instead if your machine doesn't meet the above requirements. (See info below.)

### Docker Toolbox Windows Requirements

Follow the instructions here - [Install Docker Toolbox on Windows](https://docs.docker.com/toolbox/toolbox_install_windows/)

64bit Windows 7 or higher. The Hyper-V package must be enabled. The Docker for Windows installer will enable it for you, if needed. (This requires a reboot).

### Linux

Follow the instructions here:\
[Install Docker for Linux](https://www.docker.com/products/docker#/linux)\
[Install Docker Compose for Linux](https://docs.docker.com/compose/install/)

### Linux Requirements

Docker requires a 64-bit installation. Additionally, your kernel must be 3.10 at minimum. The latest 3.10 minor version or a newer maintained version are also acceptable.

Kernels older than 3.10 lack some of the features required to run Docker containers.

## Other Information

### Licensing

Licensed under the Apache License, Version 2.0 (the "License"); you may not use the Broadsea software except in compliance with the License. You may obtain a copy of the License at

```         
http://www.apache.org/licenses/LICENSE-2.0
```

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.