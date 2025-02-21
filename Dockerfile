# syntax=docker/dockerfile:1
# You need Docker BuildKit enabled to build this Dockerfile.

# Define Alpine and NGINX versions to use.
ARG ALPINE_VERSION=3.17.3
ARG NGINX_VERSION=1.23.4

# Prepare an Alpine-based image with OpenSSL.
FROM alpine:${ALPINE_VERSION} as alpine
ARG DOMAIN_NAME=localhost
ARG DAYS_VALID=3000

RUN apk add --no-cache openssl
RUN echo "Creating self-signed certificate valid for ${DAYS_VALID} days for domain ${DOMAIN_NAME}" && \
    openssl \
    req -x509 \
    -nodes \
    -subj "/CN=${DOMAIN_NAME}" \
    -addext "subjectAltName=DNS:${DOMAIN_NAME}" \
    -days ${DAYS_VALID} \
    -newkey rsa:2048 -keyout /tmp/self-signed.key \
    -out /tmp/self-signed.crt

# Prepare an NGINX-based image with the certificate created above.
FROM nginx:${NGINX_VERSION} as nginx
COPY --from=alpine /tmp/self-signed.key /etc/ssl/private
COPY --from=alpine /tmp/self-signed.crt /etc/ssl/certs

RUN mkdir -p /app/cert
WORKDIR /app/cert
COPY _nginx.conf /etc/nginx/_nginx.conf
COPY initialize.sh  /app/cert
EXPOSE 443

ENTRYPOINT ["sh", "./initialize.sh"]
