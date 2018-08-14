FROM nginx:alpine

COPY nginx.template /etc/nginx/nginx.template
RUN envsubst '$$LINK_TO' < /etc/nginx/nginx.template > /etc/nginx/nginx.conf

COPY server.crt /data/certs/server.crt
COPY server.key /data/certs/server.key

EXPOSE 443