#!/bin/sh
set -e


export SOLR_OPTS="-DVOCAB_VERSION=${SOLR_VOCAB_VERSION} \
                -DVOCAB_JDBC_DRIVER_PATH=${SOLR_VOCAB_JDBC_DRIVER_PATH} \
                -DVOCAB_JDBC_URL=${SOLR_VOCAB_JDBC_URL} \
                -DVOCAB_JDBC_USER=${SOLR_VOCAB_JDBC_USER} \
                -DVOCAB_JDBC_PASSWORD=$(cat /run/secrets/SOLR_VOCAB_JDBC_PASSWORD)"

solr-precreate ${SOLR_VOCAB_VERSION} /tmp/solr_config