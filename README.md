# CONCOURSE DEPLOY DOCKER RESOURCE

[![Tag Latest](https://img.shields.io/github/v/tag/jeffdecola/concourse-deploy-docker-resource)](https://github.com/JeffDeCola/concourse-deploy-docker-resource/tags)
[![codeclimate Issue Count](https://codeclimate.com/github/JeffDeCola/concourse-deploy-docker-resource/badges/issue_count.svg)](https://codeclimate.com/github/JeffDeCola/concourse-deploy-docker-resource/issues)
[![Docker Pulls](https://badgen.net/docker/pulls/jeffdecola/concourse-deploy-docker-resource?icon=docker&label=pulls)](https://hub.docker.com/r/jeffdecola/concourse-deploy-docker-resource/)
[![MIT License](http://img.shields.io/:license-mit-blue.svg)](http://jeffdecola.mit-license.org)
[![jeffdecola.com](https://img.shields.io/badge/website-jeffdecola.com-blue)](https://jeffdecola.com)

_A concourse resource to deploy a docker image on a machine via ssh._

Table of Contents

Table of Contents

* [OVERVIEW](https://github.com/JeffDeCola/concourse-deploy-docker-resource#overview)
* [HOW TO USE](https://github.com/JeffDeCola/concourse-deploy-docker-resource#how-to-use)
* [HOW I BUILT AND PUSHED THIS RESOURCE (REFERENCE)](https://github.com/JeffDeCola/concourse-deploy-docker-resource#how-i-built-and-pushed-this-resource-reference)

Documentation and Reference

* [concourse-deploy-docker-resource docker image](https://hub.docker.com/r/jeffdecola/concourse-deploy-docker-resource)
  on DockerHub
* Built using my
  [concourse-resource-template](https://github.com/JeffDeCola/concourse-resource-template)
* This repos
  [github webpage](https://jeffdecola.github.io/concourse-deploy-docker-resource/)
  _built with
  [concourse](https://github.com/JeffDeCola/concourse-deploy-docker-resource/blob/master/ci-README.md)_

## OVERVIEW

_A concourse resource to deploy a docker image on a machine via ssh._

## HOW TO USE

To use this resource in your pipeline, you will need,

* {}

```yml
#------------------------------------------------------------------------------------------
jobs:

#**********************************************
- name: job-test-concourse-deploy-docker-resource
#**********************************************
  plan:

    # GET REPO FROM GITHUB
    - get: concourse-deploy-docker-resource
      trigger: true

    # CONCOURSE RESOURCE TEMPLATE
    - get: concourse-deploy-docker-resource-test
      params:
        param1: "get param1"
        param2: "get param2"
        param3: "get param3"

    # RUN TASK IN REPO USING ALPINE DOCKER IMAGE
    - task: task-test-concourse-deploy-docker-resource
      file: concourse-deploy-docker-resource/test-this-resource/tasks/task-test-concourse-deploy-docker-resource.yml

      # TASK SUCCESS
      on_success:
        do:
          # CONCOURSE RESOURCE TEMPLATE
          - put: concourse-deploy-docker-resource-test
            params:
              param1: "put param1"
              param2: "put param2"
              param3: "put param3"

#------------------------------------------------------------------------------------------
resource_types:

  - name: jeffs-resource
    type: docker-image
    source:
      repository: jeffdecola/concourse-deploy-docker-resource
      tag: latest

#------------------------------------------------------------------------------------------
resources:

  - name: concourse-deploy-docker-resource
    type: git
    icon: github
    source:
      uri: git@github.com:jeffdecola/concourse-deploy-docker-resource.git
      branch: master
      private_key: ((git_private_key))

  - name: concourse-deploy-docker-resource-test
    type: jeffs-resource
    source:
      source1: "source1 info"
      source2: "source2 info"
      source3: "source3 info"
```

## HOW I BUILT AND PUSHED THIS RESOURCE (REFERENCE)

Refer to my
[concourse-resource-template](https://github.com/JeffDeCola/concourse-resource-template)
on how I built this resource.

To
[build.sh](https://github.com/JeffDeCola/concourse-deploy-docker-resource/blob/master/build-resource-using-bash/build/build.sh)
using the
[Dockerfile](https://github.com/JeffDeCola/concourse-deploy-docker-resource/blob/master/build-resource-using-bash/build/Dockerfile),

```bash
cd build-resource-using-bash/build
sh build-resource.sh
```

Note how a concourse base image is used to build the resource.

To
[push.sh](https://github.com/JeffDeCola/concourse-deploy-docker-resource/blob/master/build-resource-using-bash/push/push.sh)
the resource docker image to dockerhub,

```bash
cd build-resource-using-bash/push
sh push.sh
```

You can check this docker image,

```bash
docker images jeffdecola/concourse-deploy-docker-resource
docker run --name concourse-deploy-docker-resource -dit jeffdecola/concourse-deploy-docker-resource
docker exec -i -t concourse-deploy-docker-resource /bin/bash
cd /opt/resource
tree
docker logs concourse-deploy-docker-resource
docker rm -f concourse-deploy-docker-resource
```
