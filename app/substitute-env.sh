#!/bin/bash
set -a
source .env
set +a
envsubst "`printf '${%s} ' $(bash -c "compgen -A variable")`" < docker-compose.yml > docker-compose.resolved.yml
