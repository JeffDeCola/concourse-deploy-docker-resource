# CONCOURSE DEPLOY DOCKER RESOURCE

[![Tag Latest](https://img.shields.io/github/v/tag/jeffdecola/concourse-deploy-docker-resource)](https://github.com/JeffDeCola/concourse-deploy-docker-resource/tags)
[![codeclimate Issue Count](https://codeclimate.com/github/JeffDeCola/concourse-deploy-docker-resource/badges/issue_count.svg)](https://codeclimate.com/github/JeffDeCola/concourse-deploy-docker-resource/issues)
[![Docker Pulls](https://badgen.net/docker/pulls/jeffdecola/concourse-deploy-docker-resource?icon=docker&label=pulls)](https://hub.docker.com/r/jeffdecola/concourse-deploy-docker-resource/)
[![MIT License](http://img.shields.io/:license-mit-blue.svg)](http://jeffdecola.mit-license.org)
[![jeffdecola.com](https://img.shields.io/badge/website-jeffdecola.com-blue)](https://jeffdecola.com)

_A concourse resource to deploy a dockerhub docker image on a machine via ssh._

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

To use this resource, you will provide the following
dockerhub information in the pipeline,

* username: jeffdecola
* password: ((dockerhub_password))

Then define the machine where you want and what dockerhub image to deploy,

* DOCKER_HOST_IP: '192.168.20.122'
* DOCKER_HOST_PORT: '22'
* DOCKER_HOST_USER: 'jeffry'
* DOCKER_HOST_SSH_PRIVATE_KEY_FILE: {{docker_host_ssh_private_key_file}}
* DOCKER_IMAGE_TO_DEPLOY: 'jeffdecola/crypto-miner-manager'

The resource is,

```yml
resource_types:

  - name: deploy-docker
    type: docker-image
    source:
      repository: jeffdecola/concourse-deploy-docker-resource
      tag: latest

resources:

  - name: test-resource-deploy-docker
    type: deploy-docker
    icon: docker
    source:
      username: jeffdecola
      password: ((dockerhub_password))
```

And to use as a put,

```yml
- put: test-resource-deploy-docker
  params:
    DOCKER_HOST_SSH_PRIVATE_KEY_FILE: {{docker_host_ssh_private_key_file}}
    DOCKER_HOST_PORT: '22'
    DOCKER_HOST_USER: 'jeffry'
    DOCKER_HOST_IP: '192.168.20.122'
    DOCKER_IMAGE_TO_DEPLOY: 'jeffdecola/crypto-miner-manager'
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
docker logs concourse-deploy-docker-resource
docker rm -f concourse-deploy-docker-resource
```
