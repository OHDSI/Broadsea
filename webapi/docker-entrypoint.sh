#!/bin/sh
set -e

secret() {
    if [ -s "/run/secrets/$1" ]; then cat "/run/secrets/$1"; fi
}

# WebAPI 3.0 (Spring Boot 3) property names, filled from Broadsea's secret files.
export DATASOURCE_PASSWORD="$(secret WEBAPI_DATASOURCE_PASSWORD)"
export SPRING_FLYWAY_PASSWORD="$DATASOURCE_PASSWORD"
export SECURITY_AUTH_DB_DATASOURCE_PASSWORD="$(secret SECURITY_DB_DATASOURCE_PASSWORD)"
export SECURITY_AUTH_LDAP_SYSTEM_PASSWORD="$(secret SECURITY_LDAP_SYSTEM_PASSWORD)"
export SECURITY_AUTH_AD_SYSTEM_PASSWORD="$(secret SECURITY_AD_SYSTEM_PASSWORD)"
export SECURITY_AUTH_OAUTH_GOOGLE_APISECRET="$(secret SECURITY_OAUTH_GOOGLE_APISECRET)"
export SECURITY_AUTH_OAUTH_FACEBOOK_APISECRET="$(secret SECURITY_OAUTH_FACEBOOK_APISECRET)"
export SECURITY_AUTH_OAUTH_GITHUB_APISECRET="$(secret SECURITY_OAUTH_GITHUB_APISECRET)"
export SECURITY_AUTH_SAML_KEYMANAGER_STOREPASSWORD="$(secret SECURITY_SAML_KEYMANAGER_STOREPASSWORD)"
export SECURITY_AUTH_SAML_KEYMANAGER_PASSWORDS_ARACHNENETWORK="$(secret SECURITY_SAML_KEYMANAGER_PASSWORDS_ARACHNENETWORK)"

# WebAPI signs login tokens with this key; its built-in default is public, so
# anyone could forge an admin token. Without a configured secret, use a random
# one: logins then last only until the next container restart.
SECURITY_JWT_SECRET="$(secret SECURITY_JWT_SECRET)"
if [ -z "$SECURITY_JWT_SECRET" ]; then
    echo "WARNING: no SECURITY_JWT_SECRET configured; using a random key, users are logged out on restart" >&2
    SECURITY_JWT_SECRET="$(head -c 48 /dev/urandom | base64 | tr -d '\n')"
fi
export SECURITY_JWT_SECRET

JAVA_KEYSTORE="/opt/java/openjdk/lib/security/cacerts"
if [ -s "/tmp/cacerts" ]; then
    JAVA_KEYSTORE=/tmp/cacerts
fi

cd /var/lib/ohdsi/webapi
exec java -Djavax.net.ssl.trustStore=${JAVA_KEYSTORE} \
    ${DEFAULT_JAVA_OPTS} ${JAVA_OPTS} \
    -Dloader.path=/opt/webapi/plugins,/var/lib/ohdsi/webapi/lib/additional \
    --add-opens java.naming/com.sun.jndi.ldap=ALL-UNNAMED \
    -jar WebAPI.jar
