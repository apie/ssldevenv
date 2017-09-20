# ssldevenv
HTTPS Reverse Proxy in Docker Image for Dev Env

```
version: '3'

services:
  some_app:
    image: some_app # Expose port 80 in Dockerfile
  ssldevenv:
    image: matoba/ssldevenv
    ports:
      - "443:443"
    links:
      - some_app:webapp
```

Certificate will expire 2027/09.
