#!/bin/bash

# Example for the Docker Hub V2 API
# Returns all imagas and tags associated with a Docker Hub user account.
# Requires 'jq': https://stedolan.github.io/jq/

# set username and password
UNAME="jeffdecola"
UPASS="dckr_pat_GG7vu3PtkPkSo50MvfkOi3nGI9c"

# -------

set -e
echo ""

echo "Get tag"

# AQUIRE TOKEN
TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d '{"username": "'${UNAME}'", "password": "'${UPASS}'"}' https://hub.docker.com/v2/users/login/ | jq -r .token)

# GET TAG
#IMAGE_TAG=$(curl -s -H "Authorization: JWT ${TOKEN}" https://hub.docker.com/v2/repositories/jeffdecola/concourse-deploy-docker-resource/tags/?page_size=100 | jq -r '.results|.[]|.name')
IMAGE_TAG=$(curl -s -H "Authorization: JWT ${TOKEN}" https://hub.docker.com/v2/repositories/dpb587/github-status-resource/tags/?page_size=100 | jq -r '.results|.[]|.name')

echo ${IMAGE_TAG}
