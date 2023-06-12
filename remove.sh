#!/bin/bash
#closing containers that they deployed from docker-compose.yml
docker compose down
#removing volumes from containers
docker compose down --volume
