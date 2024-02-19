# ssldevenv
HTTPS Reverse Proxy in Docker Image for Dev Env
also
https://blog.francium.tech/provisioning-a-self-signed-certificate-ssl-for-nginx-in-a-docker-environment-2f2b10af612e


```
version: '3'

services:
  some_app:
    image: some_app # Expose port 80 in Dockerfile
  ssldevenv:
    image: matoba/ssldevenv
    ports:
      - "443:443"
    environment:
      - LINK_TO=some_app

```
