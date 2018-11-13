#!/usr/bin/env bash

# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-which-directory-it-is-stored-in#answer-246128
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_DIR=$SCRIPT_DIR/..

docker-compose -f $REPO_DIR/docker-compose-anonymous-nifi.yaml down

docker-compose -f $REPO_DIR/knox-dev-docker/docker-compose.yml down
