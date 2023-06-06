  _built with
  [concourse](https://github.com/JeffDeCola/concourse-deploy-docker-resource/blob/master/ci-README.md)_

# OVERVIEW

_A concourse resource to deploy a docker image from dockerhub on a machine via ssh._

## HOW TO USE

To use this resource, you will provide the following
dockerhub information in the pipeline,

* username: jeffdecola
* password: ((dockerhub_password))

Then define the machine where you want and what dockerhub image to deploy,

* DOCKER_HOST_IP: '192.168.20.122'
* DOCKER_HOST_PORT: '22'
* DOCKER_HOST_USER: 'jeffry'
* DOCKER_HOST_RUN_PRIVILEGED_MODE: 'true'
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
    DOCKER_HOST_IP: '192.168.20.122'
    DOCKER_HOST_PORT: '22'
    DOCKER_HOST_USER: 'jeffry'
    DOCKER_HOST_RUN_PRIVILEGED_MODE: 'true'
    DOCKER_HOST_SSH_PRIVATE_KEY_FILE: {{jeffs_mbp_docker_host_ssh_private_key}}
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
