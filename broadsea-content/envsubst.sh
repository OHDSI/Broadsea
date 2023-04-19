#!/bin/sh

set -e

envsubst < /tmp/index.html > /usr/share/nginx/html/index.html
nginx -g 'daemon off;'