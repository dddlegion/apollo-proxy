# Apollo: Traefik proxy
This repository contains a configuration for reverse proxy based on Traefik v2 to bind all the services together by the single network.

## Requirements
1. Install [Docker](https://docker.com/) and [docker-compose](https://docs.docker.com/compose/install/)
2. Install [mkcert](https://github.com/FiloSottile/mkcert) for creating trusted ssh certificates locally.

## How to run locally
1. Copy `.env.dev` file to `.env`
2. Run `mkcert -install` if you didn't have mkcert tool before.
3. Run `make ssl-certs`
4. Run `make up`
5. Traefik dashboard will be available [here](http://proxy.apollo.localhost/)

## How to connect service to reverse proxy network
This is the example how your service's `docker-compose.yml` file should look like:
```
# docker-compose.yml

version: "3.9"

services:

  # service example
  apollo_service:
    # enter your service container name
    container_name: apollo_service_name
    
    # --//--
     
    labels:
      # Explicitly tell Traefik to expose this container
      - "traefik.enable=true"
      # The domain the service will respond to
      - "traefik.http.routers.<service_name>.rule=Host(`<host>`)"
      # Enable TLS
      - "traefik.http.routers.<service_name>.tls=true"
      # Allow request only from the predefined entry points - "http" and "https"
      - "traefik.http.routers.<service_name>.entrypoints=http,https"
      # If port is different than 80, use the following service:
      - "traefik.http.services.<service_name>.loadbalancer.server.port=<port>"
    networks:
      # use the external network specified below
      - apollo

  # --//--

# add apollo external network
networks:
  apollo:
    external: true
```

After adding traefik labels and specifying the external network build/rerun your service container.

Your service will be available on `https://<host>`.

## Available commands:
- `make up` - runs all containers inside docker-compose.yml file.
- `make stop` - stops all containers.
- `make down` - stops and removes all containers.
- `make ssl-certs` - generates SSL certificates.