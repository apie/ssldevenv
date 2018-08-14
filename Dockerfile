FROM nginx:alpine

COPY _nginx.conf /etc/nginx/_nginx.conf
RUN envsubst '$$LINK_TO' < /etc/nginx/_nginx.conf > /etc/nginx/nginx.conf

COPY server.crt /data/certs/server.crt
COPY server.key /data/certs/server.key

EXPOSE 443