# OHDSI Broadsea 2.0

## Introduction

Broadsea runs the core OHDSI technology stack (The Atlas web application, and the Hades R library within RStudio Server), using cross-platform Docker container technology.

[Information on Observational Health Data Sciences and Informatics (OHDSI)](http://www.ohdsi.org/ "OHSDI Web Site")

This repository contains the Docker Compose file used to launch the OHDSI Broadsea Docker containers:

* OHDSI R HADES - in RStudio Server
  * [OHDSI Broadsea R HADES GitHub repository](https://github.com/OHDSI/Broadsea-Hades/ "OHDSI Broadsea R HADES GitHub Repository")
  * [OHDSI Broadsea R HADES Docker Hub container image](https://hub.docker.com/r/ohdsi/broadsea-hades/ "OHDSI Broadsea HADES Docker Image Repository")  

* OHDSI Atlas - including WebAPI REST services
  * [Atlas GitHub repository](https://github.com/OHDSI/Atlas "OHDSI Atlas GitHub Repository")
  * [Atlas Docker Hub container image](https://hub.docker.com/r/ohdsi/ohdsi-atlas/ "OHDSI Atlas Docker Image Repository")
  * [WebAPI GitHub repository](https://github.com/OHDSI/WebAPI "OHDSI WebAPI GitHub Repository")
  * [WebAPI Docker Hub container image](https://hub.docker.com/r/ohdsi/ohdsi-webapi/ "OHDSI WebAPI Docker Image Repository")
  * [Atlas application PostgreSQL database GitHub repository](https://github.com/OHDSI/Broadsea-Atlasdb "OHDSI Broadsea Atlas application PostgreSQL database GitHub Repository")
  * [Atlas application PostgreSQL databbase Docker Hub container image](https://hub.docker.com/r/ohdsi/broadsea-atlasdb/ "OHDSI Broadsea Atlas application PostgreSQL database Docker Image Repository")


### Broadsea Dependencies

* Docker (Version 1.11 or higher) 
 * Docker Engine
 * Docker Compose
* Git
* Chrome web browser

Docker Engine & Docker Compose are installed together as part of "Docker Toolbox" or "Docker for Windows" or "Docker for Mac". "Docker for Windows" or "Docker for Mac" are preferred over "Docker Toolbox" for improved performance but "Docker Toolbox" is also supported.

## Broadsea - Getting Started

* Download and install Docker. See the installation instructions at the [Docker Web Site](https://docs.docker.com/engine/installation/ "Install Docker")
* git clone this GitHub repo:
```
https://github.com/OHDSI/Broadsea.git
```
* In a command line / terminal window - navigate to the directory where this README.md file is located and start the Broadsea Docker Containers: (Wait up to one minute for the Docker containers to start)
```
docker-compose up -d
```
* In your Chrome browser open the URL: "http://127.0.0.1/broadsea"
* Click on the Atlas link to open Atlas in a new browser window
* Clink on the Hades link to open HADES (RStudio) in a new browser window.
  * The RStudio userid is 'ohdsi' and the password is 'mypass'  


## Shutdown Broadsea
You can stop the running Docker containers & remove them (new container instances can be started again later) with this command:
```
docker-compose down
```

----------------

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

### Viewing The Broadsea Web Tools Log Files

* Connect to the OHDSI WebAPI container in a bash shell:
```
docker logs ohdsi-webapi
```

## Enabling Atlas security in Broadsea

In order to enable Atlas security in Broadsea, the configuration in the config-local.js file and the docker-compose.yml file must be updated. Each Atlas security authentication method has it's own set of configuration values. 

### LDAP authentication

Here is an example showing the javascript code block to add to the config-local.js file for LDAP authentication.
It is this javascript code that will enable the Atlas Sign In link and the window where the user can enter their user name and password.
```javascript
 configLocal.userAuthenticationEnabled = true;
 configLocal.acceptanceExpiresInDays = 3650;

 configLocal.authProviders = [{
     		"name": "LDAP Authentication",
     		"url": "user/login/ldap",
     		"ajax": true,
     		"icon": "fa fa-cubes",
     		"isUseCredentialsForm": true
 }]
 ```

Here is an example showing the configuration variables to add to the docker-compose.yml file environment section for LDAP authentication.
You will need to update the ldap settings based on your ldap server url and your ldap organizational structure.
The ldap system username and password are used to connect to the ldap server and perform the search specified in the ldap search string.
In this example the ldap "commonName" field will be searched for a matching username in the Atlas application Sign In Username field. If a match is found then Atlas will also try to bind to that user using the password in the Atlas application Sign In Password field.
```
      - security_enabled=true
      - security_origin=*
      - security_provider=AtlasRegularSecurity
      - security.ldap.dn=cn={0},ou=users,dc=example,dc=org
      - security.ldap.url=ldap://host.docker.internal:1389
      - security.ldap.baseDn=ou=users,dc=example,dc=org
      - security.ldap.system.username=user01
      - security.ldap.system.password=password1
      - security.ldap.searchString=(&(objectClass=*)(commonName={0}))
      - security.ldap.searchBase=ou=users,dc=example,dc=org
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
      - ./site-library:/usr/local/lib/R/site-library
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
