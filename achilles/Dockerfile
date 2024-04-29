FROM docker.io/rocker/r-ver:4.2.3

RUN --mount=type=secret,id=GITHUB_PAT \
    GITHUB_PAT=$(cat /run/secrets/GITHUB_PAT)

RUN <<EOF
apt-get update
apt-get install -y --no-install-recommends openjdk-11-jre-headless
apt-get clean
rm -rf /var/lib/apt/lists/*

# The default GitHub Actions runner has 2 vCPUs (https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners)
install2.r --error --ncpus 2  --skipinstalled --repos "https://packagemanager.posit.co/cran/latest" \
    rJava \
    remotes \ 
    ParallelLogger \
    SqlRender \
    DatabaseConnector
R CMD javareconf
EOF

RUN R -e "remotes::install_github(repo = 'OHDSI/Achilles')"