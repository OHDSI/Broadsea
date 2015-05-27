# OhdsiDocker [In development]
Docker container for OHDSI tools


### Some simple Mac OS X commands:
```
boot2docker init # Only required once
boot2docker start
boot2docker shellinit
eval "$(boot2docker shellinit)"

# Terminal R version
docker run --rm -it ohdsi/basic /usr/bin/R 

# Or run Rstudio on http://192.168.50.103:8787
docker run -d -p 8787:8787 -e USER=ohdsi -e PASSWORD=ohdsi ohdsi/basic

boot2docker stop
```

### Background information
* Built upon the `hadleyverse` container; see [FILL-IN]
