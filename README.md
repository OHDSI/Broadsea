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

# Or run Rstudio on http://192.168.59.103:8787
docker run -d -p 8787:8787 -e USER=ohdsi -e PASSWORD=ohdsi ohdsi/basic

# Or run Rserve on http://192.168.59.103:6311
docker run -d -p 6311:6311 ohdsi/basic startRserve

boot2docker stop
```

### Background information
* Built upon the `hadleyverse` container; see [FILL-IN]
