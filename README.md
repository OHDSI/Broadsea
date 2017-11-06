# OHDSI Broadsea [In development]

## Introduction

Broadsea deploys the full OHDSI technology stack (R methods library & web tools), using cross-platform Docker container technology.

[Information on Observational Health Data Sciences and Informatics (OHDSI)](http://www.ohdsi.org/ "OHSDI Web Site")

This repository contains the example Docker Compose files used to launch the Broadsea Docker containers:  

* OHDSI R Methods Library (in RStudio) - maintained by Marc Suchard
 * [Methods Library GitHub repository](https://github.com/OHDSI/Broadsea-MethodsLibrary "OHDSI Broadsea Methods Library GitHub Repository")
 * [Methods Library Docker Hub container image](https://hub.docker.com/r/ohdsi/broadsea-methodslibrary/ "OHDSI Broadsea Methods Library Docker Image Repository" )  

* OHDSI Web Applications e.g. Atlas & Calypso (in Apache Tomcat) - maintained by Lee Evans [LTS Computing LLC](http://www.ltscomputingllc.com)
  * [Web Applications GitHub repository](https://github.com/OHDSI/Broadsea-WebTools "OHDSI Broadsea Web Tools GitHub Repository")
  * [Web Applications Docker Hub container image](https://hub.docker.com/r/ohdsi/broadsea-webtools/ "OHDSI Broadsea Web Tools Docker Image Repository")

Broadsea can deploy the OHDSI stack on any of the following infrastructure alternatives:

* laptop / desktop
* internally hosted server
* cloud provider hosted server
* cluster of servers (internally or cloud provider hosted)

It supports any database management system that the OHDSI stack supports. The examples provided in this repository are for connecting to PostgreSQL, Oracle or Microsoft SQL Server databases.

It supports any OS where Docker containers can run, including Windows, Mac OS X and Linux (including Ubuntu, CentOS & CoreOS)

### Usage Scenarios:

Broadsea deploys the OHDSI technology stack at your local site so you can use it with your own data in an OMOP CDM Version 5 database.

it can be used for the following scenarios:

* Try-out / demo the OHDSI R packages & web applications
* Run observational studies on your data (including OHDSI Network studies)
* Run the OHDSI Achilles R package for database profiling, database characterization, data quality assessment on your data & view the reports as tables/charts in the Atlas web application
* Query OMOP vocabularies using the Atlas web application
* Create patient cohorts
* Determine study feasibility based on defined criteria

### Broadsea Dependencies

* Docker (Version 1.11 or higher) 
 * Docker Engine
 * Docker Compose
* OMOP Common Data Model Version 5 database populated with OMOP vocabulary & observational data

Docker Engine & Docker Compose are installed together as part of "Docker Toolbox" or "Docker for Windows" or "Docker for Mac". "Docker for Windows" or "Docker for Mac" are preferred over "Docker Toolbox" for improved performance but "Docker Toolbox" is also supported.

## Quick Start Broadsea Deployment

* Download and install Docker. See the installation instructions at the [Docker Web Site](https://docs.docker.com/engine/installation/ "Install Docker")
* Copy the example "docker-compose.yml" file for your database (PostgreSQL, Oracle, SQL Server) from this GitHub repository to a directory on your machine. (e.g. The postgresql version of the file is in the postgresql sub-directory of this repository).
* Copy the example "source_source_daimon.sql" file from this GitHub repository to a directory on your machine. (e.g. The postgresql version of the file is in the postgresql sub-directory of this repository).
* Edit the example "source_source_daimon.sql" file to specify the database connection strings and database schema prefixes for your database(s). Note. You will run this SQL file manually in a SQL client in a later step.
* Edit the example Atlas "config-local.js" file to specify the WebAPI URL, otherwise the default is localhost & port 8080.
* Edit the docker-compose.yml file to specify the following:
 * set the WEBAPI\_URL environment variable to your Docker host machine IP address. If using "Docker Toolbox" use the following command to find your Docker host machine IP address otherwise you can use "localhost":
```
docker-machine ip
```
 * specify the database connection info for your database  
   * database name
   * database user name
   * database user password
 
* Start the Broadsea Docker Containers:
```
docker-compose up -d
```
* __Only as part of initial configuration:__
 * stop the containers (**docker-compose down**)
 * run your edited "source_source_daimon.sql" file in your database using a SQL client
 * start the containers again (**docker-compose up -d**)  
 
* View the status of the containers:
```
docker-compose ps
```
* **Wait up to a minute for the Broadsea containers to start**.
* Open the OHDSI RStudio web interface in a web browser at **http://your-docker-host-IP-address>:8787**
* Open the Atlas OHDSI web application at **http://your-docker-host-ip-address:8080/atlas**
* Open the Calypso OHDSI web application at **http://your-docker-host-ip-address:8080/calypso**
* Use the below command to stop the running containers & remove them (new container instances can be started again later):
```
docker-compose down
```

The Broadsea Methods Library container includes RStudio Server.  By default it runs with a single user, userid="rstudio", password="rstudio".  **The "rstudio" user home directory only exists within the Docker container and any files saved to that directory will be lost if the container is removed!**  

**To retain the files in the "rstudio" user home directory on the Docker host machine see section: "Sharing/Saving files between RStudio & Docker host machine") later in this guide.**


## Troubleshooting

### Viewing The Broadsea Web Tools Log Files

* Find the name of the running Broadsea Web Tools Docker container (the value in the "Names" column):
```  
  docker-compose ps
```
* Connect to the Broadsea Web Tools container in a bash shell:
```
  docker exec -it <broadsea-web-tools-container-name> bash
```
* Change directory to the log directory in the running container and view the stderr and stdout log files:
  
  The "*" char is the bash shell file name wild card character.
```
  cd /var/log/supervisor
  tail -1000 *stderr*
  tail -1000 *stdout*
```


## Hardware/OS Requirements for Installing Docker

### Mac OS X

Follow the instructions here - [Install Docker for Mac](https://www.docker.com/products/docker#/mac)  
*Docker for Mac* includes both Docker Engine & Docker Compose

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

###Linux

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
      - ./site-library:/usr/lib/R/site-library
```

Any files added to the home/rstudio or site-library sub-directories on the Docker host can be accessed by RStudio in the container.  

The Broadsea Methods container RStudio /usr/lib/R/site-library originally contains the "littler" and "rgl" R packages. Volume mapping masks the original files in the directory so you will need to add those 2 packages to your Docker host site-library sub-directory if you need them.

##Other Information

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
