FROM docker.io/rocker/r-ver:4.2.3
ARG ACHILLES_GITHUB_REF=main
ARG ARESINDEXER_GITHUB_REF=dockerfile

RUN echo 'GITHUB_PAT=' /run/secrets/GITHUB_PAT >> /root/.Renviron

RUN <<EOF
apt-get update
apt-get install -y --no-install-recommends openjdk-11-jre-headless
apt-get clean
rm -rf /var/lib/apt/lists/*

# The default GitHub Actions runner has 2 vCPUs (https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners)
install2.r --error --ncpus 2 \
    rJava \
    remotes \ 
    ParallelLogger \
    SqlRender \
    DatabaseConnector
R CMD javareconf
EOF

RUN R -e "remotes::install_github(repo = 'OHDSI/Achilles', ref = '${ACHILLES_GITHUB_REF}')"
RUN R -e "remotes::install_github(repo = 'alondhe/AresIndexer', ref = '${ARESINDEXER_GITHUB_REF}')"