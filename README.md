# BroadSea [In development]
Repository to store Docker container that will include the all of the OHDSI tools

### Some simple Mac OS X commands:
```
boot2docker init # Only required once
boot2docker start
boot2docker shellinit
eval "$(boot2docker shellinit)"

# Terminal R version
docker run --rm -it ohdsi/development /usr/bin/R

# Or run Rstudio on http://192.168.59.103:8787 and RServe on 192.168.59.103:6311
docker run -d -p 8787:8787 -p 6311:6311 -e USER=ohdsi -e PASSWORD=ohdsi ohdsi/development

boot2docker stop
```

### Testing RServe from R on `localhost`
```{r}
library(RSclient)
c <- RS.connect("192.168.59.103")
RS.eval(c, library(Cyclops))
RS.close(c)
```


### Background information
* Built upon the `hadleyverse` container; see [FILL-IN]
