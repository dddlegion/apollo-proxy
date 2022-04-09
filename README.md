# Apollo: Traefik proxy
This repository contains a configuration for reverse proxy based on Traefik v2 to bind all the services together by the single network.

## Requirements
1. Install [Docker](https://docker.com/) and [docker-compose](https://docs.docker.com/compose/install/)
2. Install [mkcert](https://github.com/FiloSottile/mkcert) for creating trusted ssh certificates locally.
3. (optional) Install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/) and [minikube](https://minikube.sigs.k8s.io/docs/start/)

## How to run locally:
1. Copy `.env.dev` file to `.env`
2. Run `mkcert -install` if you didn't have mkcert tool before.
3. Run `make ssl-certs`
4. Run `make up`
5. Traefik dashboard will be available [here](http://proxy.apollo.localhost/)

## Available commands:
- `make up` - runs all containers inside docker-compose.yml file.
- `make stop` - stops all containers.
- `make down` - stops and removes all containers.
- `make ssl-certs` - generates SSL certificates.