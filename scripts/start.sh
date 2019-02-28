#!/usr/bin/env bash

# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-which-directory-it-is-stored-in#answer-246128
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_DIR=$SCRIPT_DIR/..

# clone Sandeep's repo, which creates docker containers to compile Knox,
# start an LDAP, and start Knox
git clone https://github.com/moresandeep/knox-dev-docker.git $REPO_DIR/knox-dev-docker

# copy the NiFi topology into the cloned knox-dev-docker repo
cp $REPO_DIR/topologies/nifi.xml $REPO_DIR/knox-dev-docker/topologies

docker-compose -f $REPO_DIR/knox-dev-docker/docker-compose.yml up -d

docker-compose -f $REPO_DIR/docker-compose-anonymous-nifi.yaml up -d
