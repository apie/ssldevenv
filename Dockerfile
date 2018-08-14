FROM nginx:alpine

RUN mkdir /app/cert
WORKDIR /app/cert
COPY _nginx.conf /etc/nginx/_nginx.conf
COPY server.crt /data/certs/server.crt
COPY server.key /data/certs/server.key
COPY initialize.sh  /app/cert
EXPOSE 443

ENTRYPOINT ["sh", "./initialize.sh"]
