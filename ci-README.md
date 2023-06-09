# CONCOURSE CONTINUOUS INTEGRATION

I use concourse to automate,

* Use README for
  [GitHub Webpage](https://jeffdecola.github.io/concourse-deploy-docker-resource/)
* BUILD docker image
* PUSH to dockerhub
* Alert me of the progress via repo status and slack

## PIPELINE

The concourse
[pipeline.yml](https://github.com/JeffDeCola/concourse-deploy-docker-resource/blob/master/ci/pipeline.yml)
shows the entire ci flow,

![IMAGE - concourse-deploy-docker-resource concourse ci pipeline - IMAGE](docs/pics/concourse-deploy-docker-resource-pipeline.jpg)

## JOBS, TASKS AND RESOURCE TYPES

Concourse Jobs and Tasks

* `job-readme-github-pages` runs task
  [task-readme-github-pages.yml](https://github.com/JeffDeCola/concourse-deploy-docker-resource/blob/master/ci/tasks/task-readme-github-pages.yml)
  that kicks off shell script
  [readme-github-pages.sh](https://github.com/JeffDeCola/concourse-deploy-docker-resource/blob/master/ci/scripts/readme-github-pages.sh)
* `job-build-push` runs task
  [task-build-push.yml](https://github.com/JeffDeCola/concourse-deploy-docker-resource/blob/master/ci/tasks/task-build-push.yml)
  that kicks off shell script
  [build-push.sh](https://github.com/JeffDeCola/concourse-deploy-docker-resource/tree/master/ci/scripts/build-push.sh)

Concourse Resources

* `concourse-deploy-docker-resource` uses a resource type
  [docker-image](https://hub.docker.com/r/concourse/git-resource/)
  to PULL a repo from github
* `resource-dump-to-dockerhub` uses a resource type
  [docker-image](https://hub.docker.com/r/concourse/docker-image-resource/)
  to PUSH a docker image to dockerhub
* `resource-slack-alert` uses a resource type
  [docker image](https://hub.docker.com/r/cfcommunity/slack-notification-resource)
  that will notify slack on your progress
* `resource-repo-status` uses a resource type
  [docker image](https://hub.docker.com/r/jeffdecola/github-status-resource-clone)
  that will update your git status for that particular commit
