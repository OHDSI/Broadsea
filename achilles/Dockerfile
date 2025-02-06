FROM docker.io/rocker/r-ver:4.2.3

RUN --mount=type=secret,id=GITHUB_PAT \
    GITHUB_PAT=$(cat /run/secrets/GITHUB_PAT)

RUN apt-get update && apt-get install -y --no-install-recommends openjdk-11-jre-headless && apt-get clean && rm -rf /var/lib/apt/lists/* && R CMD javareconf

RUN R -e "install.packages(c('rJava', 'remotes', 'ParallelLogger', 'SqlRender', 'DatabaseConnector'))"

RUN R -e "remotes::install_github(repo = 'OHDSI/Achilles')"