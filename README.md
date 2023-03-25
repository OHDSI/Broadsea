# OHDSI Broadsea 3.0

## Introduction

Broadsea runs the core OHDSI technology stack using cross-platform Docker container technology.

[Information on Observational Health Data Sciences and Informatics (OHDSI)](http://www.ohdsi.org/ "OHSDI Web Site")

This repository contains the Docker Compose file used to launch the OHDSI Broadsea Docker containers:

* OHDSI R HADES - in RStudio Server
  * [OHDSI Broadsea R HADES GitHub repository](https://github.com/OHDSI/Broadsea-Hades/ "OHDSI Broadsea R HADES GitHub Repository")
  * [OHDSI Broadsea R HADES Docker Hub container image](https://hub.docker.com/r/ohdsi/broadsea-hades "OHDSI Broadsea HADES Docker Image Repository")  

* OHDSI Atlas - including WebAPI REST services
  * [Atlas GitHub repository](https://github.com/OHDSI/Atlas "OHDSI Atlas GitHub Repository")
  * [Atlas Docker Hub container image](https://hub.docker.com/r/ohdsi/atlas "OHDSI Atlas Docker Image Repository")
  * [WebAPI GitHub repository](https://github.com/OHDSI/WebAPI "OHDSI WebAPI GitHub Repository")
  * [WebAPI Docker Hub container image](https://hub.docker.com/r/ohdsi/webapi "OHDSI WebAPI Docker Image Repository")
  * [Atlas application PostgreSQL database GitHub repository](https://github.com/OHDSI/Broadsea-Atlasdb "OHDSI Broadsea Atlas application PostgreSQL database GitHub Repository")
  * [Atlas application PostgreSQL databbase Docker Hub container image](https://hub.docker.com/repository/docker/ohdsi/broadsea-atlasdb "OHDSI Broadsea Atlas application PostgreSQL database Docker Image Repository")
  * SOLR based OMOP Vocab search

* OHDSI Ares
  * [Ares GitHub repository](https://github.com/OHDSI/Ares "OHDSI Ares GitHub Repository")

### Broadsea Dependencies

* Docker
* Git
* Chromium-based web browser (Chrome, Edge, etc.)

### Mac Silicon

If using Mac Silicon (M1, M2), set the DOCKER_ARCH variable in Section 1 of the .env file to "linux/arm64"

## Broadsea - Quick start

* Download and install Docker. See the installation instructions at the [Docker Web Site](https://docs.docker.com/engine/installation/ "Install Docker")
* git clone this GitHub repo:
```
git clone https://github.com/OHDSI/Broadsea.git
```
* In a command line / terminal window - navigate to the directory where this README.md file is located and start the Broadsea Docker Containers using the below command. On Linux you may need to use 'sudo' to run this command. Wait up to one minute for the Docker containers to start. The docker compose pull command ensures that the latest released versions of the OHDSI ATLAS and OHDSI WebAPI docker containers are downloaded.
```
docker compose pull && docker-compose --profile default up -d
```
* In your web browser open the URL: ```"http://127.0.0.1/broadsea"```
* Click on the Atlas link to open Atlas in a new browser window
* Click on the Hades link to open HADES (RStudio) in a new browser window.
  * The RStudio userid is 'ohdsi' and the password is 'mypass'  

## Broadsea - Advanced Usage

### .env file

The .env file that comes with Broadsea has default and sample values. For advanced use, modify the values as appropriate, as covered below.

#### Run Broadsea on a remote server

In Section 1 of the .env file, set BROADSEA_HOST as the IP address or host name (without http/https) of the remote server.

### Docker profiles

This docker compose file makes use of [Docker profiles](https://docs.docker.com/compose/profiles/ "Docker Profiles") to allow for either a full default deployment ("default"), or a more a-la-carte approach in which you can pick and choose which services you'd like to deploy.

You can use this syntax for this approach, substituting profile names in:

```
docker compose pull && docker-compose --profile profile1 --profile profile2 .... up -d
```

Here are the profiles available:

- default
  - atlas ("/atlas")
  - WebAPI ("/WebAPI")
  - AtlasDB (a Postgres instance for Atlas/WebAPI)
  - HADES ("/")
  - A splash page for Broadsea ("/broadsea")

- atlas-from-image
  - Pulls the standard Atlas image from Docker Hub

- atlas-from-git
  - Builds Atlas from a Git repo
  - Useful for testing new versions of Atlas that aren't in Docker Hub

- webapi-from-image:
  - Pulls the standard WebAPI image from Docker Hub

- webapi-from-git
  - Builds WebAPI from a Git repo
  - Useful for testing new versions of WebAPI that aren't in Docker Hub

- atlasdb
  - Pulls the standard Atlas DB image, a Postgres instance for Atlas/WebAPI
  - Useful if you do not have an existing Postgres instance for Atlas/WebAPI

- solr-vocab-no-import
  - Pulls the standard SOLR image from Docker Hub
  - Initializes a core for the OMOP Vocabulary specified in the .env file
  - No data is imported into the core, left to you to run through the SOLR Admin GUI at "/solr"

- solr-vocab-with-import
  - Pulls the standard SOLR image from Docker Hub
  - Initializes a core for the OMOP Vocabulary specified in the .env file
  - Runs the data import for that core
  - Once complete, the solr-run-import container will finish with an exit status; you can remove this container

- ares
  - Builds Ares web app from Ares GitHub repo
  - Exposes a volume mount point for adding Ares files (see [Ares GitHub IO page](https://ohdsi.github.io/Ares/ "Ares GitHub IO"))

- content
  - A splash page for Broadsea ("/broadsea")

- omop-vocab-pg-load
  - Using OMOP Vocab files downloaded from Athena, this can load them into a Postgres instance (can be Broadsea's atlasdb or an external one)
  - Rebuilds the CPTs using the CPT jar file from Athena, with UMLS API Key (see .env file Section 9)
  - Creates the schema if necessary
  - Runs copy command for each vocabulary CSV file
  - Creates all necessary Postgres indices
  - Once complete, the omop-vocab-load container will finish with an exit status; you can remove this container

- phoebe-pg-load
  - For Atlas 2.12+, which offers Concept Recommendation options based on the [Phoebe project](https://forums.ohdsi.org/t/phoebe-2-0/17410 "Phoebe Project")
  - Loads Phoebe files into an existing OMOP Vocabulary hosted in a Postgres instance (can be Broadsea's atlasdb or an external one)
  - Note: your Atlas instance must use this OMOP Vocabulary as its default vocabulary source in order to use this feature
  - Once complete, the phoebe-load container will finish with an exit status; you can remove this container

### SSL

Broadsea uses Traefik as a proxy for all containers within. Traefik can be set up with SSL to enable HTTPS:

1. Obtain a crt and key file. Rename them to "broadsea.crt" and "broadsea.key", respectively.
2. Add these files to a ./certs folder
3. In Section 1 of the .env file, change the HTTP_TYPE to "https"

### Atlas/WebAPI Security

To enable a security provider for authentication and identity management in Atlas/WebAPI, review and fill out Sections 4 and 5 in the .env file.

#### LDAPS (LDAP over SSL or secure LDAP)

To use a secure LDAP instance, add your cacerts file to ./cacerts within the Broadsea directory. WebAPI can then leverage it for LDAPS.

### Atlas/WebAPI from Git repo

To build either Atlas or WebAPI from a git repo instead of from Docker Hub, use Section 6 to specify the Git repo paths. Branches and commits can be in the URL after a "#".

### SOLR Vocab

To enable the use of SOLR for fast OMOP Vocab search in Atlas, review and fill out Section 7 of the .env file. You can either point to an existing SOLR instance, or have Broadsea build one.

### OMOP Vocab loading

To load a new OMOP Vocabulary into a Postgres schema, review and fill out Section 9 of the .env file. Please note: this service will attempt to run the CPT4 import process for the CONCEPT table, so you will need a UMLS API Key in order to fulfull the UMLS_API_KEY variable (from https://uts.nlm.nih.gov/uts/profile).

The Broadsea atlasdb Postgres instance is listed by default, but you can use an external Postgres instance. You need to copy your Athena downloaded files into ./omop_vocab/files.

### Phoebe Integration for Atlas

With Atlas 2.12.0 and above, a new concept recommendation feature is available, based upon the [Phoebe project](https://forums.ohdsi.org/t/phoebe-2-0/17410 "Phoebe Project"). Review and fill out Section 10 of the .env file to load the concept_recommended table needed for this feature into a Postgres hosted OMOP Vocabulary.

### HADES RStudio default login

The credentials for the RStudio user can be established in Section 8 of the .env file.

## Shutdown Broadsea
You can stop the running Docker containers & remove them (new container instances can be started again later) with this command:
```
docker compose down
```


## Broadsea Intended Uses

Broadsea can deploy the OHDSI stack on any of the following infrastructure alternatives:

* laptop / desktop - Note: The Broadsea-Hades Docker container (RStudio server with OHDSI HADES R packages) is not currently supported on Non-Intel Mac computers (M1 or M2)
* internally hosted server
* cloud provider hosted server
* cluster of servers (internally or cloud provider hosted)

It supports any database management system that the OHDSI stack supports. The examples provided in this repository are for connecting to PostgreSQL, Oracle or Microsoft SQL Server databases.

It supports any OS where Docker containers can run, including Windows, Mac OS X and Linux (including Ubuntu, CentOS & CoreOS)

### Usage Scenarios:

Broadsea deploys the OHDSI technology stack at your local site so you can use it with your own data in an OMOP CDM Version 5 database.

it can be used for the following scenarios:

* Try-out / demo the OHDSI R packages & web applications - Broadsea-Atlasdb contains the following artifacts for demos:
 * a tiny simulated patient demo dataset called 'Eunomia'
 * a simple concept set
 * a simple cohort definition   
* Run observational studies on your data (including OHDSI Network studies)
* Run the OHDSI Achilles R package for database profiling, database characterization, data quality assessment on your data & view the reports as tables/charts in the Atlas web application
* Query OMOP vocabularies using the Atlas web application
* Define and generate patient cohorts
* Determine study feasibility based on defined criteria

---------------

## Troubleshooting

### View the status of the running Docker containers:
```
docker-compose ps
```

### Viewing Atlas/WebAPI and RStudio HADES Log Files

```
docker logs ohdsi-atlas
docker logs ohdsi-webapi
docker logs broadsea-hades
```

## Hardware/OS Requirements for Installing Docker

### Mac OS X

Follow the instructions here - [Install Docker for Mac](https://www.docker.com/products/docker#/mac)  
*Docker for Mac* includes both Docker Engine & Docker Compose

For Mac Silicon, you may need to enable "Use Rosetta for x86/amd64 emulation on Apple Silicon" in the "Features in Development" Settings menu.

### Mac OS X Requirements

Mac must be a 2010 or newer model, with Intel’s hardware support for memory management unit (MMU) virtualization; i.e., Extended Page Tables (EPT)
OS X 10.10.3 Yosemite or newer
At least 4GB of RAM
VirtualBox prior to version 4.3.30 must NOT be installed (it is incompatible with Docker for Mac). Docker for Mac will error out on install in this case. Uninstall the older version of VirtualBox and re-try the install.

### Windows

Follow the instructions here - [Install Docker for Windows](https://www.docker.com/products/docker#/windows)  
*Docker for Windows* includes both Docker Engine & Docker Compose

### Docker for Windows Requirements

64bit Windows 10 Pro, Enterprise and Education (1511 November update, Build 10586 or later). In the future Docker will support more versions of Windows 10.
The Hyper-V package must be enabled. The Docker for Windows installer will enable it for you, if needed. (This requires a reboot).

Note. *Docker for Windows* is the preferred Docker environment for Broadsea, but *Docker-Toolbox* may be used instead if your machine doesn't meet the above requirements. (See info below.)

### Docker Toolbox Windows Requirements

Follow the instructions here - [Install Docker Toolbox on Windows](https://docs.docker.com/toolbox/toolbox_install_windows/)  

64bit Windows 7 or higher.  The Hyper-V package must be enabled. The Docker for Windows installer will enable it for you, if needed. (This requires a reboot).

### Linux

Follow the instructions here:  
[Install Docker for Linux](https://www.docker.com/products/docker#/linux)  
[Install Docker Compose for Linux](https://docs.docker.com/compose/install/)

### Linux Requirements

Docker requires a 64-bit installation. Additionally, your kernel must be 3.10 at minimum. The latest 3.10 minor version or a newer maintained version are also acceptable.

Kernels older than 3.10 lack some of the features required to run Docker containers.

## Broadsea Web Tools Customization Options

### Deploy Proprietary Database Drivers

The PostgreSQL jdbc database driver is open source and may be freely distributed. A PostgreSQL jdbc database driver is already included within the OHDSI Broadsea webapi-web-apps container.

If you are using a proprietary database server (e.g. Oracle or Microsoft SQL Server) download your own copy of the database jdbc driver jar file and copy it to the same host directory where the docker-compose.yml file is located.

When the OHDSI Web Tools container runs it will automatically load the jdbc database driver, if it exists in the host directory.

## Broadsea Methods Library Configuration Options

### Sharing/Saving files between RStudio and Docker host machine

To permanently retain the "rstudio" user files in the "rstudio" user home directory, and make local R packages available to RStudio in the Broadsea Methods container the following steps are required:

* In the same directory where the docker-compose.yml is stored create a sub-directory tree called "home/rstudio" and a sub-directory called "site-library"
* **Set the file permissions for the "home/rstudio" sub-directory tree and the "site-library" sub-directory to public read, write and execute.**
* Add the below volume mapping statements to the end of the broadsea-methods-library section of the docker-compose.yml file.
```
volumes:
      - ./home/rstudio:/home/rstudio
      - ./site-library:/usr/local/lib/R/site-library
```

Any files added to the home/rstudio or site-library sub-directories on the Docker host can be accessed by RStudio in the container.  

The Broadsea Methods container RStudio /usr/lib/R/site-library originally contains the "littler" and "rgl" R packages. Volume mapping masks the original files in the directory so you will need to add those 2 packages to your Docker host site-library sub-directory if you need them.

## Other Information

### Licensing

Licensed under the Apache License, Version 2.0 (the "License");
you may not use the Broadsea software except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
