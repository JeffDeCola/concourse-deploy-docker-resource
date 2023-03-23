#!/bin/sh
# concourse-deploy-docker-resource destroy-pipeline.sh

echo " "
echo "Destroy pipeline on target jeffs-ci-target which is team jeffs-ci-team"
fly --target jeffs-ci-target \
    destroy-pipeline \
    --pipeline concourse-deploy-docker-resource
echo " "
