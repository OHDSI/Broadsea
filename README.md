# OhdsiDocker [In development]
Docker container for OHDSI tools


### Some simple Mac OS X commands:
```
boot2docker init # Only required once
boot2docker start
boot2docker shellinit
eval "$(boot2docker shellinit)"

# Command-line version
docker run --rm -it rocker/hadleyverse /usr/bin/R 

# Or run Rstudio on http://192.168.50.103:8787
docker run -d -p 8787:8787 -e USER=ohdsi -e PASSWORD=ohdsi rocker/hadleyverse 

boot2docker stop
```
