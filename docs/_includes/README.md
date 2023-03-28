  _built with
  [concourse](https://github.com/JeffDeCola/concourse-deploy-docker-resource/blob/master/ci-README.md)_

# OVERVIEW

_A concourse resource to deploy a docker image on a machine via ssh._

## HOW TO USE

To use this resource, you will provide the following
dockerhub information in the pipeline,

* username: jeffdecola
* password: ((dockerhub_password))

Then you need the machine where you want to deploy the docker image,

* DOCKER_HOST_IP: '192.168.20.122'
* DOCKER_HOST_PORT: '22'
* DOCKER_HOST_USER: 'jeffry'
* DOCKER_HOST_SSH_PRIVATE_KEY_FILE: {{docker_host_ssh_private_key_file}}

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
      branch: main
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
