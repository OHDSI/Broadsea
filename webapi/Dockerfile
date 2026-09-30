# WebAPI 3.0 image for Broadsea: the upstream 3.0 image, pinned to the same
# digest Atlas3 is tested against, with the trexsql plugin jar replaced by a
# specific OHDSI/trex release.

ARG WEBAPI_DIGEST=sha256:d4a2e14341c4674d94caf07f9a03726c2574be4d2d1e0f2c5ed127db59cc87c3
FROM ghcr.io/ohdsi/webapi:3.0-dev@${WEBAPI_DIGEST}

ARG TREXSQL_VERSION=0.3.3
ARG TREXSQL_URL=https://github.com/OHDSI/trex/releases/download/v${TREXSQL_VERSION}/trexsql-${TREXSQL_VERSION}.jar

USER root
RUN set -eux; \
    curl -fsSL -o /opt/webapi/plugins/trexsql.jar "${TREXSQL_URL}"; \
    unzip -p /opt/webapi/plugins/trexsql.jar META-INF/MANIFEST.MF > /tmp/trexsql.manifest; \
    grep -E '^Main-Class:[[:space:]]*trexsql\.core[[:space:]]*$' /tmp/trexsql.manifest > /dev/null; \
    rm /tmp/trexsql.manifest

# Home and trexsql cache location. A fresh named volume mounted here takes
# this ownership, so the non-root WebAPI user can write to it.
RUN mkdir -p /data && chown 101:101 /data
USER 101
