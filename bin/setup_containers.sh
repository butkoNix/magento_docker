#!/usr/bin/env bash

docker-compose -f ./docker/docker-compose.yml -p test build
docker-compose -f ./docker/docker-compose.yml -p test up -d