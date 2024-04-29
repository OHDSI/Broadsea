FROM rocker/verse as quarto

ARG CONTENT_TITLE
ARG CONTENT_ARES_DISPLAY
ARG CONTENT_ATLAS_DISPLAY
ARG CONTENT_HADES_DISPLAY
ARG CONTENT_PERSEUS_DISPLAY
ARG CONTENT_OPENSHINYSERVER_DISPLAY
ARG CONTENT_POSITCONNECT_DISPLAY

WORKDIR /tmp
RUN apt-get install -y --no-install-recommends wget
RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.3.433/quarto-1.3.433-linux-amd64.deb
RUN dpkg -i /tmp/quarto-1.3.433-linux-amd64.deb

COPY images /tmp/content/images
COPY apps.csv /tmp/content/apps.csv
COPY index.qmd /tmp/content/index.qmd

RUN quarto render /tmp/content/index.qmd \ 
    -P CONTENT_TITLE:'${CONTENT_TITLE}' \
    -P CONTENT_ARES_DISPLAY:'${CONTENT_ARES_DISPLAY}' \
    -P CONTENT_ATLAS_DISPLAY:'${CONTENT_ATLAS_DISPLAY}' \
    -P CONTENT_HADES_DISPLAY:'${CONTENT_HADES_DISPLAY}' \
    -P CONTENT_PERSEUS_DISPLAY:'${CONTENT_PERSEUS_DISPLAY}' \
    -P CONTENT_OPENSHINYSERVER_DISPLAY:'${CONTENT_OPENSHINYSERVER_DISPLAY}' \
    -P CONTENT_POSITCONNECT_DISPLAY:'${CONTENT_POSITCONNECT_DISPLAY}' \
     --to html

FROM nginx:latest
COPY --from=quarto /tmp/content /usr/share/nginx/html/