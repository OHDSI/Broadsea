#!/bin/bash
# Copyright VMware, Inc.
# SPDX-License-Identifier: APACHE-2.0

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail

# Load libraries
. /opt/bitnami/scripts/liblog.sh

sed -i '6s/^/LDAP_PASSWORDS=$(<\/run\/secrets\/OPENLDAP_ACCOUNT_PASSWORDS)\n/' /opt/bitnami/scripts/libopenldap.sh

#if [[ "$1" = "/opt/bitnami/scripts/openldap/run.sh" ]]; then
    info "** Starting LDAP setup **"
    /opt/bitnami/scripts/openldap/setup.sh
    info "** LDAP setup finished! **"
#fi

echo ""
exec "$@"