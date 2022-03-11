# syntax=docker/dockerfile:1.4
FROM ubuntu:20.04
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
WORKDIR /opt/achilles
ENV DATABASECONNECTOR_JAR_FOLDER="/opt/achilles/drivers"

RUN <<EOF
groupadd -g 10001 achilles
useradd -u 10001 -g achilles achilles
mkdir ./output
mkdir ./drivers
chown -R achilles .
EOF

# hadolint ignore=DL3008
RUN <<EOF
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  software-properties-common \
  openjdk-11-jre \
  openjdk-11-jre-headless \
  libxml2-dev \
  locales \
  wget

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen en_US.utf8
/usr/sbin/update-locale LANG=en_US.UTF-8

wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
add-apt-repository "ppa:c2d4u.team/c2d4u4.0+"
apt-get update

DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  r-base \
  r-base-dev \
  r-cran-httr \
  r-cran-remotes \
  r-cran-rjava \
  r-cran-rjson \
  r-cran-littler \
  r-cran-docopt

rm -rf /var/lib/apt/lists/*
R CMD javareconf
ln -s /usr/lib/R/site-library/littler/examples/install2.r /usr/local/bin/install2.r
EOF

RUN <<EOF
install2.r --error \
  ParallelLogger \
  SqlRender \
  DatabaseConnector
R -e "library(DatabaseConnector); downloadJdbcDrivers('postgresql')"
EOF

RUN R -e "remotes::install_github('OHDSI/Achilles@c6b7adb6330e75c2311880db2eb3dc4c12341c4f')"

COPY entrypoint.r ./

USER 10001:10001
CMD ["Rscript", "entrypoint.r"]
