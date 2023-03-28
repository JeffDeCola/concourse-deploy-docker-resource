#!/bin/bash

# Example for the Docker Hub V2 API
# Returns all imagas and tags associated with a Docker Hub user account.
# Requires 'jq': https://stedolan.github.io/jq/

# set username and password
username="jeffdecola"
password="dckr_pat_GG7vu3PtkPkSo50MvfkOi3nGI9c"

# -------

set -e
echo ""

echo "Get tag"

# GET DOCKERHUB TOKEN
TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d '{"username": "'$username'", "password": "'$password'"}' https://hub.docker.com/v2/users/login/ | jq -r .token)

# GET DOCKERHUB TAGS
#IMAGE_TAG=$(curl -s -H "Authorization: JWT ${TOKEN}" https://hub.docker.com/v2/repositories/$username/concourse-deploy-docker-resource/tags/?page_size=100 | jq -r '.results|.[]|.name')
IMAGE_TAG=$(curl -s -H "Authorization: JWT ${TOKEN}" https://hub.docker.com/v2/repositories/$username/github-status-resource-clone/tags/?page_size=100 | jq -r '.results|.[]|.name')
echo "The latest version is $IMAGE_TAG"
echo ""

echo $IMAGE_TAG
