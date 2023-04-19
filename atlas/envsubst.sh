#!/bin/sh

set -e

envsubst < /tmp/config-local.js > /usr/share/nginx/html/atlas/js/config-local.js
nginx -g 'daemon off;'