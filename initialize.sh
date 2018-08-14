#!/bin/sh
envsubst '$$LINK_TO' < /etc/nginx/_nginx.conf > /etc/nginx/nginx.conf
nginx -g daemon off;